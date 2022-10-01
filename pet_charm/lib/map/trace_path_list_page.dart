import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:pet_charm/map/show_trace_path_page.dart';

import '../main.dart';
import '../models/trace_path.dart';
import 'package:pet_charm/common/toast.dart';

class TracePathListPage extends StatefulWidget {
  const TracePathListPage({Key? key}) : super(key: key);

  @override
  _TracePathListPage createState() => _TracePathListPage();
}

class _TracePathListPage extends State<TracePathListPage> {

  var _futureTracePathList;

  @override
  void initState() {
    super.initState();
    _futureTracePathList = _getTracePathList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "遛宠记录",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(250, 249, 249, 1),
        leading: IconButton(
            color: const Color.fromRGBO(0, 0, 0, 1),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      // body: ListView(
      //   children: tracePathList.map((TracePath tracePath) => Card(
      //       child: ListTile(
      //         leading: const Icon(Icons.directions_walk),
      //         title: const Text('遛宠'),
      //         subtitle: Text('开始时间: ' + tracePath.startTime + '\n' + '结束时间: ' + tracePath.endTime),
      //         trailing: const Icon(Icons.arrow_forward_ios),
      //         onTap: () => Navigator.of(context).push(
      //           MaterialPageRoute(
      //               builder: (context) => ShowTracePathPage(
      //                 tracePath: tracePath,
      //               )
      //           ),
      //         ),
      //       )
      //   )).toList(),
      // ),
      body: FutureBuilder(
        builder: _buildFuture,
        future: _futureTracePathList
      )
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        if (snapshot.hasError) {
          toast(snapshot.error.toString());
          return const Center(child: Text("获取云端数据失败，请检查网络连接情况"));
        }
        return _buildTracePathListView(context, snapshot);
      default:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }

  Widget _buildTracePathListView(BuildContext context, AsyncSnapshot snapshot) {
    List<TracePath> tracePathList = snapshot.data;
    return ListView(
      children: tracePathList.reversed.map((TracePath tracePath) => Card(
        child: ListTile(
          leading: const Icon(Icons.directions_walk),
          title: const Text('遛宠'),
          subtitle: Text('开始时间: ' + tracePath.startTime + '\n' + '结束时间: ' + tracePath.endTime),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ShowTracePathPage(
                tracePathId: tracePath.id,
              )
            ),
          ),
        )
      )).toList(),
    );
  }

  Future<List<TracePath>> _getTracePathList() async {
    try {
      var response;
      // response = await Future<String>.delayed(
      //   const Duration(seconds: 5),      // 强行延迟1s，用于Debug测试
      //       () => 'Data Loaded',
      // );
      response = await Global.dio.get('tracePath/list/');
      // print('在_getTracePathList中的response:' + response.toString());   // FIXME: DEBUG:
      if (response.statusCode == 200) {
        List<dynamic> tracePathListJson = response.data['tracePaths'];
        List<TracePath> tracePathList =
        tracePathListJson.map((dynamic item) => TracePath.fromJson(item)).toList();
        return tracePathList;
      } else {
        throw "_getTracePathList状态码不为200";
      }
    } on DioError catch (e) {
        throw "网络连接异常，请检查网络设置";
    }
  }
}