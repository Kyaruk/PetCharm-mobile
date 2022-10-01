import 'package:flutter/material.dart';
import 'package:pet_charm/common/toast.dart';
import 'package:pet_charm/main.dart';
import 'package:dio/dio.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  //获取Key用来获取Form表单组件
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  bool isShowPassWord = false;

  @override
  Widget build(BuildContext context) {
    // Global.globalUser.userId = "";
    Global.deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: Global.deviceSize.width * 0.2),
              width: Global.deviceSize.width,
              child: Image.asset("assets/images/bg_signIn.png"),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Global.deviceSize.width * 0.3,
                  left: Global.deviceSize.width * 0.05,
                  right: Global.deviceSize.width * 0.05),
              child: Form(
                key: _loginKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        bottom: Global.deviceSize.width * 0.05,
                        right: Global.deviceSize.width * 0.42,
                      ),
                      child: Text(
                        "登录社区",
                        style: TextStyle(
                            color: const Color.fromRGBO(208, 59, 51, 1.0),
                            fontSize: Global.deviceSize.width * 0.1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Global.deviceSize.width * 0.02,
                          right: Global.deviceSize.width * 0.02,
                          bottom: Global.deviceSize.width * 0.01),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.white, width: 0))),
                      child: Card(
                          color: const Color.fromRGBO(252, 238, 238, 1),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Container(
                            // padding: const EdgeInsets.only(left: 2),
                            padding:
                                EdgeInsets.all(Global.deviceSize.width * 0.01),
                            child: TextFormField(
                              // maxLines: 5,
                              controller: _userNameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromRGBO(252, 238, 238, 1),
                                hintText: "用户名",
                                labelStyle: const TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 93, 93, 93)),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Color.fromARGB(255, 126, 126, 126),
                                  ),
                                  onPressed: () {
                                    _userNameController.text = "";
                                  },
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Global.deviceSize.width * 0.02,
                          right: Global.deviceSize.width * 0.02),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.white, width: 0))),
                      child: Card(
                          color: const Color.fromRGBO(252, 238, 238, 1),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Container(
                            padding:
                                EdgeInsets.all(Global.deviceSize.width * 0.01),
                            child: TextFormField(
                              controller: _passWordController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(252, 238, 238, 1),
                                  hintText: "密码",
                                  labelStyle: const TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isShowPassWord
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color.fromARGB(
                                          255, 126, 126, 126),
                                    ),
                                    onPressed: showPassWord,
                                  )),
                              obscureText: !isShowPassWord,
                            ),
                          )),
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        TextButton(
                          child: const Text(
                            "忘记密码?",
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Color.fromRGBO(226, 39, 39, 1)),
                          ),
                          onPressed: router2ForgetPwd,
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(226, 39, 39, 1)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              const Text(
                                "还没有账号?",
                              ),
                              TextButton(
                                child: const Text(
                                  "注册",
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 13.0,
                                      color: Color.fromRGBO(226, 39, 39, 1)),
                                ),
                                onPressed: router2Register,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: checkLoginInfo,
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(255, 186, 186, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  width: 2,
                                  color: Colors.red,
                                  // style: BorderStyle.solid,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            child: const Text(
                              '登录',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )));
  }

  void checkLoginInfo() {
    if ((_loginKey.currentState as FormState).validate()) {
      if (_userNameController.text == "") {
        toast("Please Enter Username");
      } else if (_passWordController.text == "") {
        toast("Please Enter Password");
      } else {
        //验证通过提交数据
        _checkUserInfo();
        // print('userName: ' +
        //     _userNameController.text +
        //     ' password: ' +
        //     _passWordController.text);
      }
    }
  }

  _checkUserInfo() async {
    try {
      FormData formData = FormData.fromMap({
        "userName": _userNameController.text,
        "userPassword": _passWordController.text,
      });
      var response = await Global.dio.post('login/', data: formData);
      if (response.statusCode == 200) {
        if (response.data["success"]) {
          ///输出当前cookie
          // Global.globalUser.userId = "${_userNameController.text}";

          toast("Welcome Back");
          Navigator.of(context).pushReplacementNamed("home_page");
        } else {
          toast("Wrong Password, Try Again");
        }
      } else {
        // print("ERROR:\nhttp请求出现错误，错误编码为:" + response.statusCode.toString());
        toast("Http Error: " + response.statusCode.toString());
      }
    } on DioError catch (e) {
      toast("请检查您的网络情况并稍后重试");
      throw Exception(e.response?.data);
    }
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  void router2ForgetPwd() {
    Navigator.pushNamed(context, "forget_password_page");
  }

  void router2Register() {
    Navigator.pushNamed(context, "register_userinfo");
  }
}
