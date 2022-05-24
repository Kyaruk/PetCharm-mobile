import 'package:flutter/material.dart';
import 'package:pet_charm/user/my_posts.dart';
import 'package:pet_charm/user/pet_info.dart';
import 'home/set_all_pets.dart';
import 'login/log_in.dart';
import 'login/register_pet.dart';
import 'login/register_userinfo.dart';
import 'login/terms_and_conditions.dart';
import 'login/forgot_pwd.dart';
import 'home/home_screen.dart';
import 'home/post_message.dart';
import 'user/user_info.dart';
import 'package:pet_charm/home/search_page.dart';
import 'models/user.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'common/error.dart';
import 'package:pet_charm/user/vet_certificate.dart';
import 'Paimon.dart';
import 'package:pet_charm/复选框.dart';
import 'testios.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  Global.dio.interceptors.add(CookieManager(Global.cookieJar));

  runApp(const MyApp());
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
        GlobalMaterialLocalizations.delegate,//指定本地化的字符串和一些其他的值
        GlobalWidgetsLocalizations.delegate,//定义 widget 默认的文本方向，从左到右或从右到左。
        GlobalCupertinoLocalizations.delegate,//对应的 Cupertino 风格（Cupertino 风格组件即 iOS 风格组件）
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
            user: User("", "", "", "", "", ""), temp: User("", "", "", "", "", "")),
        "search_page": (context) => const SearchPage(),
        "error_page": (context) => const ErrorPage(),
        "test_page": (context) => const Test(),
        "pet_info_page": (context) => const PetInfo(),
        "vet_cer_page": (context) => const VetCer(),
        "my_post_page": (context) => const MyPostPage(),
        "paimon_page": (context) => const Paimon(),
        "set_all_pets": (context) => const SetPetPage(),
      },
      home: const Login(),
      // home: RegisterPet(),
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

  static String localhost = "10.0.2.2/";

  //强制初始化，不用管，在login里有赋值
  static Size deviceSize = const Size(375, 375);
}
