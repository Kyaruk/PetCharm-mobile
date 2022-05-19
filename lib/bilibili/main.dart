import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(new MyApp());
}


// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _MyAppState();
// }


// class _MyAppState extends State<MyApp>{
class MyApp extends StatelessWidget{

  // Future<CommonModel> fetchPost() async {
  //   final response = await http
  //       .get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
  //   Utf8Decoder utf8decoder = Utf8Decoder(); //fix 中文乱码
  //   var result = json.decode(utf8decoder.convert(response.bodyBytes));
  //   return CommonModel.fromJson(result);
  // }
  //
  // ————————————————
  // 版权声明：本文为CSDN博主「nicepainkiller」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
  // 原文链接：https://blog.csdn.net/nicepainkiller/article/details/121374703

  // final HomeHttp homeHttp = HomeHttp();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "FLutter Pet Shop",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      ///报错,先注释掉了
      home: MyHomePage(),
    );
  }
}