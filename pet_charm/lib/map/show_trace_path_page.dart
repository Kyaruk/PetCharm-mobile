import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:pet_charm/models/trace_path.dart';
import 'package:pet_charm/common/toast.dart';

import '../main.dart';

class ShowTracePathPage extends StatefulWidget {
  int tracePathId;

  ShowTracePathPage({Key? key, required this.tracePathId}) : super(key: key);

  @override
  _ShowTracePathPage createState() => _ShowTracePathPage();
}

class _ShowTracePathPage extends State<ShowTracePathPage> {
  late BMFMapController myMapController;
  late Size screenSize;

  late BMFTraceOverlay _traceOverlay;

  var _futureTracePath;



  @override
  void initState() {
    super.initState();
    _futureTracePath = _getTracePathDetail();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFE7E9EC),
          title: const Text(
            "遛宠路线",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
              builder: _buildFuture,
              future: _futureTracePath
        )
      ),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
        if (snapshot.hasError) {
          toast(snapshot.error.toString());
          return const Center(child: Text("获取云端数据失败，请检查网络连接情况"));
        }
        print(snapshot.data.toString());
        return _buildActualView(context, snapshot);
    } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }

  Widget _buildActualView(BuildContext context, AsyncSnapshot snapshot) {
    TracePath tracePath = snapshot.data;
    return Stack(
      children: [
        generateMap(context, tracePath),
        generateInfoBar(context, tracePath),
      ],
    );
  }

  Widget generateInfoBar(BuildContext context, TracePath tracePath) {
    return Container(
      width: screenSize.width,
      height: 60,
      color: const Color.fromRGBO(245, 245, 245, 0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(tracePath.startTime)],
      ),
    );
  }

  /// 创建地图
  Container generateMap(BuildContext context, TracePath tracePath) {
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      child: BMFMapWidget(
        onBMFMapCreated: (controller) {
          onBMFMapCreated(controller, tracePath);
        },
        mapOptions: BMFMapOptions(
            center: BMFCoordinate(39.917215, 116.380341), zoomLevel: 18),
      ),
    );
  }
  /// 创建完成回调
  void onBMFMapCreated(BMFMapController controller, TracePath tracePath) {
    myMapController = controller;
    _addTraceOverlay(tracePath);
  }

  Future<void> _addTraceOverlay(TracePath tracePath) async {
    /// 读取动态轨迹点

    String coordinateStrings = tracePath.coordinates;
    coordinateStrings = coordinateStrings.trim();
    if (coordinateStrings.endsWith(',')) {
      coordinateStrings =
          coordinateStrings.substring(0, coordinateStrings.length - 1);
    }
    /// string -> list
    List<String> coordinateStringList = coordinateStrings.split(',');
    /// 动态轨迹点
    List<BMFCoordinate> coords = [];
    for (var i = 0; i < coordinateStringList.length; i += 2) {
      BMFCoordinate coordinate = BMFCoordinate(
          double.parse(coordinateStringList[i + 1]),
          double.parse(coordinateStringList[i]));
      coords.add(coordinate);
    }

    /// 构造动态轨迹动画参数
    BMFTraceOverlayAnimateOption traceOverlayAnimateOption =
        BMFTraceOverlayAnimateOption(
            animate: true,     // FIXME:
            delay: 1.2,
            duration: 3,
            fromValue: 0.0,
            toValue: 1.0,
            easingCurve: BMFTraceOverlayAnimationEasingCurve.Linear,
            trackMove: true);

    /// 构造动态轨迹
    _traceOverlay = BMFTraceOverlay(
        coordinates: coords,
        traceOverlayAnimateOption: traceOverlayAnimateOption);
    await myMapController.addTraceOverlay(_traceOverlay);
  }
//
// void _removeTraceOverlay() {
//   myMapController.removeTraceOverlay(_traceOverlay.Id);
// }
  Future<TracePath> _getTracePathDetail() async {


    try {
      var response = await Global.dio.get('tracePath/', queryParameters: {"tracePathId" : widget.tracePathId});
      // print('在_getTracePathList中的response:' + response.toString());   // FIXME: DEBUG:
      if (response.statusCode == 200) {
        dynamic tracePathJson = response.data['tracePath'];
        TracePath tracePath = TracePath.fromJson(tracePathJson);
        return tracePath;
      } else {
        throw "_getTracePathDetail状态码不为200";
      }
    } on DioError catch (e) {
      throw "网络连接异常，请检查网络设置";
    }
  }
}
