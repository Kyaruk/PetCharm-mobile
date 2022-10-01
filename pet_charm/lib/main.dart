import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pet_charm/user/add_pet.dart';
import 'package:pet_charm/user/my_comments.dart';
import 'package:pet_charm/user/my_posts.dart';
import 'package:pet_charm/user/pet_info.dart';
import 'petAdoption/searchPet_page.dart';
import 'consultation/my_consultation.dart';
import 'home/set_all_pets.dart';
import 'home/vet_search_page.dart';
import 'login/log_in.dart';
import 'login/register_pet.dart';
import 'login/register_userinfo.dart';
import 'login/terms_and_conditions.dart';
import 'login/forgot_pwd.dart';
import 'home/home_screen.dart';
import 'home/post_message.dart';
import 'map/trace_path_list_page.dart';
import 'map/trace_path_page.dart';
import 'user/user_info.dart';
import 'package:pet_charm/home/searchPost_page.dart';
import 'models/user.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'common/error.dart';
import 'package:pet_charm/user/vet_certificate.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'Paimon.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  Global.dio.interceptors.add(CookieManager(Global.cookieJar));

  runApp(const MyApp());

  LocationFlutterPlugin myLocPlugin = LocationFlutterPlugin();
  requestPermission();
  // NOTE: 各个SDK的隐私合规接口相互独立，若您同时集成地图SDK和定位SDK，需要分别调用隐私合规接口：地图初始化前请设置！！！
  myLocPlugin.setAgreePrivacy(true);

  /// 设置用户是否同意SDK隐私协议
  /// since 3.1.0 开发者必须设置
  // NOTE: 各个SDK的隐私合规接口相互独立，若您同时集成地图SDK和定位SDK，需要分别调用隐私合规接口：地图初始化前请设置！！！
  BMFMapSDK.setAgreePrivacy(true);

  // 百度地图sdk初始化鉴权
  if (Platform.isIOS) {
    BMFMapSDK.setApiKeyAndCoordType(
        'qS0voHyGMNZo6MURAU6z2GjBdRlrbgyo', BMF_COORD_TYPE.BD09LL);
  } else if (Platform.isAndroid) {
    // Android 目前不支持接口设置Apikey,
    // 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)demo
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }

  /// iOS端鉴权结果 （指定位SDK的！！）
  myLocPlugin.getApiKeyCallback(callback: (String result) {
    // String str = result;
    // print('鉴权结果：' + str);
  });
}

// 动态申请定位权限
void requestPermission() async {
  // 申请权限
  bool hasLocationPermission = await requestLocationPermission();
  if (hasLocationPermission) {
    // 权限申请通过
  } else {}
}

/// 申请定位权限
/// 授予定位权限返回true， 否则返回false
Future<bool> requestLocationPermission() async {
  //获取当前的权限
  var status = await Permission.location.status;
  if (status == PermissionStatus.granted) {
    //已经授权
    return true;
  } else {
    //未授权则发起一次申请
    status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PetCharm',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        //指定本地化的字符串和一些其他的值
        GlobalWidgetsLocalizations.delegate,
        //定义 widget 默认的文本方向，从左到右或从右到左。
        GlobalCupertinoLocalizations.delegate,
        //对应的 Cupertino 风格（Cupertino 风格组件即 iOS 风格组件）
      ],
      supportedLocales: const [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        fontFamily: 'Nunito-Regular',
      ),
      routes: {
        "login_page": (context) => const Login(),
        "register_page": (context) => const RegisterPet(),
        "register_userinfo": (context) => const RegisterUserInfo(),
        "terms_and_conditions": (context) => const TermsAndConditions(),
        "forget_password_page": (context) => const ForgotPwd(),
        "home_page": (context) => const HomeScreen(),
        "post_page": (context) => const PostMessage(),
        "user_info_page": (context) => UserInfo(
            user: User(0, "", "", "", "", "", "", 0.0, false),
            temp: User(0, "", "", "", "", "", "", 0.0, false)),
        "searchPost_page": (context) => const SearchPostPage(),
        "searchPet_page": (context) => const SearchPetPage(),
        "searchVet_page": (context) => const SearchVetPage(),
        "error_page": (context) => const ErrorPage(),
        "pet_info_page": (context) => const PetInfo(),
        "vet_cer_page": (context) => const VetCer(),
        "my_post_page": (context) => const MyPostPage(),
        "trace_path_page": (context) => const TracePathPage(),
        "path_record_page": (context) => const TracePathListPage(),
        "my_comments_page": (context) => const MyComments(),
        "my_consultation_page": (context) => const MyConsultation(),
        "paimon_page": (context) => const Paimon(),
        "set_all_pets": (context) => const SetPetPage(),
        "add_pet_page": (context) => const AddPet(),
      },
      home: const Login(),
    );
  }
}

abstract class Global {
  static var options = BaseOptions(
    baseUrl: 'http://43.138.31.99/api/',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static var dio = Dio(options);
  static var cookieJar = CookieJar();

  //本地测试时URL
  static String localhost = "10.0.2.2/";

  //强制初始化，不用管，在login里有赋值
  static Size deviceSize = const Size(375, 375);
}
