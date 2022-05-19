import 'package:flutter/material.dart';
import 'package:pet_charm/common/toast.dart';
import 'package:pet_charm/main.dart';
import 'package:dio/dio.dart';
import 'package:pet_charm/common/formatChecker.dart';

class RegisterUserInfo extends StatefulWidget {
  const RegisterUserInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterUserInfo();
  }
}

class _RegisterUserInfo extends State<RegisterUserInfo> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _password1 = TextEditingController();
  final TextEditingController _password2 = TextEditingController();
  bool isShowPassWord1 = false;
  bool isShowPassWord2 = false;
  bool _checkboxSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          elevation: 0,
          leading: IconButton(
              color: const Color.fromRGBO(0, 0, 0, 1),
              icon: const Icon(Icons.arrow_back),
              tooltip: 'Increase volume by 10',
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: Global.deviceSize.width * 0.4),
                child: Text(
                  "欢迎加入",
                  style: TextStyle(
                      color: const Color.fromRGBO(208, 59, 51, 1.0),
                      fontSize: Global.deviceSize.width * 0.1,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    bottom: Global.deviceSize.width * 0,
                    left: Global.deviceSize.width * 0.06,
                    right: Global.deviceSize.width * 0.5),
                child: Text(
                  "请填写必要信息",
                  style: TextStyle(
                      color: const Color.fromRGBO(208, 59, 51, 1.0),
                      fontSize: Global.deviceSize.width * 0.05,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(bottom: Global.deviceSize.width * 0.03),
                width: Global.deviceSize.width * 0.9,
                child: Image.asset("assets/images/bg_userinfo.png"),
              ),
              returnForm(_userName, "用户名", TextInputType.text),
              returnFormPassWord1(_password1, "密码",
                  TextInputType.visiblePassword),
              returnFormPassWord2(_password2, "重复密码",
                  TextInputType.visiblePassword),
              returnForm(_emailAddress, "邮箱地址",
                  TextInputType.emailAddress),
              Container(
                padding: EdgeInsets.only(left: Global.deviceSize.width * 0.04),
                child: Row(
                  children: [
                    Checkbox(
                      value: _checkboxSelected,
                      activeColor: const Color.fromRGBO(208, 59, 51, 1.0),
                      onChanged: (value) {
                        setState(() {
                          _checkboxSelected = value!;
                        });
                      },
                    ),
                    const Text("我已阅读并同意"),
                    TextButton(
                      child: const Text(
                        "相关条款",
                        // "Terms and Conditions",
                        style:
                            TextStyle(color: Color.fromRGBO(208, 59, 51, 1.0)),
                      ),
                      onPressed: router2Terms,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: Global.deviceSize.width * 0.7),
                child: TextButton(
                  onPressed: checkRegisterInfo,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 186, 186, 1),
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
                    '下一步',
                    style: TextStyle(fontSize: 13.0, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void checkRegisterInfo() {
    if (_userName.text == "") {
      toast("请填写用户名");
    } else if (_password1.text == "" || _password2.text == "") {
      toast("请填写密码");
    } else if (_password1.text != _password2.text) {
      toast("请重复填写密码");
    } else if (_emailAddress.text == "") {
      toast("请填写邮件地址");
    } else if (!formatChecker(_emailAddress.text, 1)) {
      toast("请填写正确的邮件地址");
    } else if (!_checkboxSelected) {
      toast("请同意条款");
    } else {
      _checkRegisterInfo();
    }
  }

  _checkRegisterInfo() async {
    FormData formData = FormData.fromMap({
      "userName": _userName.text,
      "userPassword": _password1.text,
      "userEmail": _emailAddress.text,
    });
    try {
      var response = await Global.dio.post('register/', data: formData);
      if (response.statusCode == 200) {
        if (response.data["success"]) {
          toast("注册成功");
          Navigator.pushNamed(context, "register_page");
        } else {
          toast("该用户名已经被注册了，请换一个吧");
          //TODO：用户名选中
        }
      } else {
        // print("ERROR:\nhttp请求出现错误，错误编码为:" + response.statusCode.toString());
        toast("Http Error: " + response.statusCode.toString());
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  void router2RegisterPage() {
    Navigator.pushNamed(context, "register_page");
  }

  void router2Terms() {
    Navigator.pushNamed(context, "terms_and_conditions");
  }

  /*
  returnForm和returnFormPassWord的基本格式一致，returnFormPassWord多一个bool值的控制
  returnFormPassWord和showPassWord为一组，用来控制密码的输入框格式
  */

  Container returnForm(TextEditingController _textEditingController,
      String _labelText, TextInputType textInputType) {
    return Container(
      padding: EdgeInsets.only(
          left: Global.deviceSize.width * 0.06,
          right: Global.deviceSize.width * 0.06),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromRGBO(250, 250, 250, 1), width: 0))),
      child: Card(
          color: const Color.fromRGBO(252, 238, 238, 1),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 240, 240, 240), width: 0))),
            padding: EdgeInsets.all(Global.deviceSize.width * 0.01),
            child: TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(252, 238, 238, 1),
                hintText: _labelText,
                labelStyle: const TextStyle(
                    fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Color.fromARGB(255, 126, 126, 126),
                  ),
                  onPressed: () {
                    _textEditingController.text = "";
                  },
                ),
              ),
              keyboardType: textInputType,
            ),
          )),
    );
  }

  Container returnFormPassWord1(TextEditingController _textEditingController,
      String _labelText, TextInputType textInputType) {
    return Container(
      padding: EdgeInsets.only(
          left: Global.deviceSize.width * 0.06,
          right: Global.deviceSize.width * 0.06),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromRGBO(250, 250, 250, 1), width: 0))),
      child: Card(
          color: const Color.fromRGBO(252, 238, 238, 1),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 240, 240, 240), width: 0))),
            padding: EdgeInsets.all(Global.deviceSize.width * 0.01),
            child: TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(252, 238, 238, 1),
                hintText: _labelText,
                labelStyle: const TextStyle(
                    fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    isShowPassWord1 ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromARGB(255, 126, 126, 126),
                  ),
                  onPressed: showPassWord1,
                ),
              ),
              keyboardType: textInputType,
              obscureText: !isShowPassWord1,
            ),
          )),
    );
  }

  void showPassWord1() {
    setState(() {
      isShowPassWord1 = !isShowPassWord1;
    });
  }

  Container returnFormPassWord2(TextEditingController _textEditingController,
      String _labelText, TextInputType textInputType) {
    return Container(
      padding: EdgeInsets.only(
          left: Global.deviceSize.width * 0.06,
          right: Global.deviceSize.width * 0.06),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromRGBO(250, 250, 250, 1), width: 0))),
      child: Card(
          color: const Color.fromRGBO(252, 238, 238, 1),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 240, 240, 240), width: 0))),
            padding: EdgeInsets.all(Global.deviceSize.width * 0.01),
            child: TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(252, 238, 238, 1),
                hintText: _labelText,
                labelStyle: const TextStyle(
                    fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    isShowPassWord1 ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromARGB(255, 126, 126, 126),
                  ),
                  onPressed: showPassWord2,
                ),
              ),
              keyboardType: textInputType,
              obscureText: !isShowPassWord2,
            ),
          )),
    );
  }

  void showPassWord2() {
    setState(() {
      isShowPassWord2 = !isShowPassWord2;
    });
  }
}
