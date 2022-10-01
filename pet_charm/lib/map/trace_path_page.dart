import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:pet_charm/common/toast.dart';

import '../main.dart';

/// 连续定位的时间间隔，单位ms。
/// 注意谨慎设置，这会影响到轨迹字符串的长度大小。
/// 假如10s定位一次，产生类似'39.917215,116.380341,'的信息，即产生21/22字节左右的信息，
/// 那么1minute就是6*22字节，1hour就是60*6*22=7920字节的信息。
const int locateTimeInterval = 10000;

///
const int coordinateDigitsLeft = 6;

/// 最短录制时间
/// 持续时间小于此值的录制应该被丢弃
const int MinTraceTimeInSeconds = 120;

///上传轨迹信息失败时会重试，uploadTracePathRetryTime指总尝试次数，需要大于等于1
const int uploadTracePathRetryTime = 1;

class TracePathPage extends StatefulWidget {
  const TracePathPage({Key? key}) : super(key: key);

  @override
  _TracePathPage createState() => _TracePathPage();
}

class _TracePathPage extends State<TracePathPage> {
  BaiduLocation _locationResult = BaiduLocation();
  late BMFMapController _myMapController;
  final LocationFlutterPlugin _myLocPlugin = LocationFlutterPlugin();
  bool _suc = false;

  List<String> coordinates = [];

  late DateTime tracePathStartTime;
  late DateTime tracePathEndTime;

  // 轨迹
  late BMFTraceOverlay _traceOverlay;
  // 由于空安全机制，无法判断late声明得变量是否被初始化过，所以手动维护_traceOverlay得初始化状态
  bool hasTraceOverlay = false;

  // marker大头针
  late BMFMarker _marker;
  // 由于空安全机制，无法判断late声明得变量是否被初始化过，所以手动维护_marker的初始化状态
  bool hasMarker = false;

  /// 状态变量，用于判断用户是否点击了开始按钮来开始录制
  /// 用于转换浮动按钮的图标显示（从开始图标变成停止图标）
  bool isStartTrace = false;

  @override
  void initState() {
    super.initState();

    ///接受定位回调
    _myLocPlugin.seriesLocationCallback(callback: (BaiduLocation result) {
      setState(() {
        _locationResult = result;
        _locationFinish();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stopLocation();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> resultWidgets = [];

    if (_locationResult.locTime != null) {
      _locationResult.getMap().forEach((key, value) {
        resultWidgets.add(_resultWidget(key, value));
      });
    }

    return WillPopScope(
        child: MaterialApp(
            home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFE7E9EC),
            title: const Text(
              "录制轨迹",
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                buildQuitConfirmDialog(context);
              },
            ),
          ),
          body: Column(children: [
            _createMapContainer(),
            // Container(height: 20),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height - 756,
            //   child: ListView(
            //     children: resultWidgets,     // debug用 实时展示定位结果
            //   ),
            // ),
            // _createButtonContainer() // 用floatingActionButton
          ]),
          floatingActionButton: SizedBox(
            height: 320,
            width: 200,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 80.0,
                    width: 200.0,
                    child: FloatingActionButton(
                      child: isStartTrace
                          ? const Icon(Icons.stop, size: 40)
                          : const Icon(Icons.play_arrow, size: 40),
                      onPressed: () {
                        if (!isStartTrace) {    // 点击开始
                          ///设置定位参数
                          _locationAction();
                          // 开始连续定位
                          _startLocation();
                          tracePathStartTime = DateTime.now();
                          toast("开始记录轨迹");
                          setState(() {
                            isStartTrace = true;
                          });
                        } else {                // 点击结束
                          if (DateTime.now().difference(tracePathStartTime).inSeconds < MinTraceTimeInSeconds) {
                            buildQuitConfirmDialog(context, leadingText: '录制时间过短，当前记录不会保存');
                          } else {
                            buildStopTraceConfirmDialog(context);
                          }
                        }
                      },
                      backgroundColor: const Color.fromRGBO(0, 216, 134, 1),
                    ),
                  ),
                ]),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        )),
        onWillPop: () async {
          buildQuitConfirmDialog(context);
          return true;
        });
  }

  Widget _createMapContainer() {
    return SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: BMFMapWidget(
          onBMFMapCreated: (controller) {
            _onBMFMapCreated(controller);
          },
          mapOptions: _initMapOptions(),
        ));
  }

  Container _createButtonContainer() {
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  ///设置定位参数
                  _locationAction();
                  _startLocation();
                },
                child: const Text('开始定位'),
                style: ElevatedButton.styleFrom(
                  primary:
                      Colors.blueAccent, //change background color of button
                  onPrimary: Colors.yellow, //change text color of button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                )),
            Container(width: 20),
            ElevatedButton(
                onPressed: () {
                  _stopLocation();
                },
                child: const Text('停止定位'),
                style: ElevatedButton.styleFrom(
                  primary:
                      Colors.blueAccent, //change background color of button
                  onPrimary: Colors.yellow, //change text color of button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ))
          ],
        ));
  }

  Widget _resultWidget(key, value) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$key:' ' $value'),
          ]),
    );
  }

  void _locationAction() async {
    /// 设置android端和ios端定位参数
    /// android 端设置定位参数
    /// ios 端设置定位参数
    Map iosMap = _initIOSOptions().getMap();
    Map androidMap = _initAndroidOptions().getMap();

    _suc = await _myLocPlugin.prepareLoc(androidMap, iosMap);
    print('设置定位参数：$iosMap');
  }

  /// 设置地图参数
  BaiduLocationAndroidOption _initAndroidOptions() {
    BaiduLocationAndroidOption options = BaiduLocationAndroidOption(
      coorType: 'bd09ll',
      coordType: BMFLocationCoordType.bd09ll,
      locationMode: BMFLocationMode.hightAccuracy,
      isNeedAddress: true,
      isNeedAltitude: false,
      isNeedLocationPoiList: false,
      isNeedNewVersionRgc: false,
      isNeedLocationDescribe: false,
      openGps: true,
      scanspan: locateTimeInterval, // 单位为ms
    );
    return options;
  }

  BaiduLocationIOSOption _initIOSOptions() {
    BaiduLocationIOSOption options = BaiduLocationIOSOption(
        coordType: BMFLocationCoordType.bd09ll,
        BMKLocationCoordinateType: 'BMKLocationCoordinateTypeBMK09LL',
        desiredAccuracy: BMFDesiredAccuracy.best,
        allowsBackgroundLocationUpdates: true,
        pausesLocationUpdatesAutomatically: false);
    return options;
  }

  // /// 启动定位
  Future<void> _startLocation() async {
    _suc = await _myLocPlugin.startLocation();
    print('开始连续定位：$_suc');
  }

  /// 停止定位
  void _stopLocation() async {
    _suc = await _myLocPlugin.stopLocation();
    print('停止连续定位：$_suc');
  }

  ///定位完成添加mark
  void _locationFinish() {
    // 首先将坐标信息加入coordinates这个list中
    // 注意顺序！ 先经度longitude再纬度latitude
    coordinates.add((_locationResult.longitude ?? 0.0)
        .toStringAsFixed(coordinateDigitsLeft));
    coordinates.add((_locationResult.latitude ?? 0.0)
        .toStringAsFixed(coordinateDigitsLeft));

    // marker大头针部分 /////////////////////////////////////////////////////////////////////
    // 先删除旧的marker（如果有的话）
    if (hasMarker) {
      _myMapController.removeMarker(_marker);
    }

    /// 创建BMFMarker
    _marker = BMFMarker.icon(
        position: BMFCoordinate(
            _locationResult.latitude ?? 0.0, _locationResult.longitude ?? 0.0),
        title: 'tracePathMarker',
        identifier: 'trace_path_marker',
        // icon: 'assets/map/icon_mark.png'
        icon: 'assets/map/mark_red.png');
    print(_locationResult.latitude.toString() +
        ' ' +
        _locationResult.longitude.toString());

    /// 添加Marker
    _myMapController.addMarker(_marker);
    hasMarker = true;
    ///////////////////////////////////////////////////////////////////////////////////////
    // 由于有了新的位置信息，重新画轨迹
    _updateTraceOverlay();

    ///设置中心点
    _myMapController.setCenterCoordinate(
        BMFCoordinate(
            _locationResult.latitude ?? 0.0, _locationResult.longitude ?? 0.0),
        false);
  }

  /// 设置地图参数
  BMFMapOptions _initMapOptions() {
    BMFMapOptions mapOptions = BMFMapOptions(
        center: BMFCoordinate(39.917215, 116.380341),
        zoomLevel: 18, // 设置默认缩放级别，经测试设定为18
        mapPadding: BMFEdgeInsets(top: 0, left: 0, right: 0, bottom: 0));
    return mapOptions;
  }

  /// 创建完成回调
  void _onBMFMapCreated(BMFMapController controller) {
    _myMapController = controller;

    /// 地图加载回调
    _myMapController.setMapDidLoadCallback(callback: () {
      print('mapDidLoad-地图加载完成');
    });
  }

  Future<void> _updateTraceOverlay() async {
    List<BMFCoordinate> coords = [];
    for (var i = 0; i < coordinates.length; i += 2) {
      BMFCoordinate tmpCoordinate = BMFCoordinate(
          double.parse(coordinates[i + 1]), double.parse(coordinates[i]));
      coords.add(tmpCoordinate);
    }

    /// 构造动态轨迹动画参数
    BMFTraceOverlayAnimateOption traceOverlayAnimateOption =
        BMFTraceOverlayAnimateOption(
      animate: false, // 需要关闭动画，来瞬间绘制完毕轨迹
    );
    // 构造动态轨迹
    // 注意判断如果当前只定位了一次，不要画轨迹
    if (coords.length > 1) {
      _traceOverlay = BMFTraceOverlay(
          coordinates: coords,
          traceOverlayAnimateOption: traceOverlayAnimateOption);

      if (hasTraceOverlay) {
        await _myMapController.removeTraceOverlay(_traceOverlay.Id);
      }
      await _myMapController.addTraceOverlay(_traceOverlay);
      hasTraceOverlay = true;
    }
  }

  Future<dynamic> buildQuitConfirmDialog(BuildContext context, {String leadingText = ''}) {
    return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(leadingText + '\n' + '当前记录轨迹会被丢弃，确认退出？'), actions: <Widget>[
              ElevatedButton(
                  child: const Text('退出'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }),
              ElevatedButton(
                  child: const Text('取消'),
                  onPressed: () => Navigator.of(context).pop(false)),
            ]));
  }
  Future<dynamic> buildStopTraceConfirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: const Text('确认停止记录并上传轨迹？'), actions: <Widget>[
              ElevatedButton(
                  child: const Text('确认'),
                  onPressed: () async {
                    _stopLocation();
                    tracePathEndTime = DateTime.now();
                    String tracePathString = coordinates.join(',');
                    bool isUploadSuccess = false;
                    for (var i = 0; i < (uploadTracePathRetryTime > 0 ? uploadTracePathRetryTime : 1); i++) {
                      bool ok = await uploadTracePath(tracePathString);
                      if (ok) {
                        isUploadSuccess = true;
                        // toast('记录上传成功');
                        break;
                      } else {
                        toast('上传记录失败，请检查网络连接情况，正在重试上传');
                        await Future.delayed(const Duration(seconds: 1));
                      }
                    }
                      toast('上传轨迹记录：${isUploadSuccess ? '成功' : '失败'}');
                      Navigator.pop(context);
                      Navigator.pop(context);
                  }),
              ElevatedButton(
                  child: const Text('取消'),
                  onPressed: () => Navigator.of(context).pop(false)),
            ]));
  }

  //
  Future<bool> uploadTracePath(String tracePathString) async {
    // FIXME: DEBUG:
    print('进入uploadTracePath，此时记录的轨迹坐标: ${coordinates.toString()}');
    try {
      await _uploadTracePath(tracePathString);
    } on DioError catch(e) {
      toast("网络连接异常，请检查网络设置");
      return false;
    } catch(e) {
      toast(e.toString());
      return false;
    }
    return true;
  }

  Future _uploadTracePath(String tracePathString) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        "tracePathStartTime": tracePathStartTime,
        "tracePathEndTime": tracePathEndTime,
        "tracePathNote":  "",     // FIXME: 暂不支持用户主动输入备注note
        "tracePathCoordinates": tracePathString
      });
      for (var m in formData.fields) {
        print(m.key + " 为：" + m.value);
      }
      var response = await Global.dio.post('tracePath/', data: formData);
      // print('在_uploadTracePath中的response:' + response.toString() + 'responseStatus为：' + response.statusCode.toString());
      if (response.statusCode == 200) {
        if (response.data["success"]) {
          return;
        } else {
          throw "上传失败，状态码不为200";
        }
      } else {
        throw "Http Error: " + response.statusCode.toString();
      }
    } on DioError catch (e) {
      // FIXME: DEBUG:
      print(e.toString());
      print(e.response.toString());
      rethrow;
    }
  }
}