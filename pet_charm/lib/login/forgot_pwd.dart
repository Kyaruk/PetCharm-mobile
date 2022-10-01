import 'package:flutter/material.dart';
import 'package:pet_charm/common/toast.dart';
import 'package:pet_charm/main.dart';
import 'package:dio/dio.dart';

class ForgotPwd extends StatefulWidget {
  const ForgotPwd({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ForgotPwd();
  }
}

class _ForgotPwd extends State<ForgotPwd> {
  final TextEditingController _userName = TextEditingController();

  // final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _emailVerification = TextEditingController();
  final TextEditingController _password1 = TextEditingController();
  final TextEditingController _password2 = TextEditingController();
  bool isShowPassWord1 = false;
  bool isShowPassWord2 = false;
  bool sendVerificationCode = false;
  bool sendCodeBefore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "重置密码",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            color: const Color.fromRGBO(0, 0, 0, 1),
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Increase volume by 10',
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Column(
        children: [
          // const Text("Welcome!"),
          SizedBox(
            height: Global.deviceSize.height * 0.05,
          ),
          Text(
            "请完善您的信息来帮助我们快速重置您的密码",
            style: TextStyle(
                color: const Color.fromRGBO(208, 59, 51, 1.0),
                fontSize: Global.deviceSize.width * 0.08,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Global.deviceSize.height * 0.02,
          ),
          returnForm(_userName, "输入您的用户名", TextInputType.text),
          // returnForm(_emailAddress, "Enter your email address",
          //     TextInputType.emailAddress),
          returnForm(_emailVerification, "输入您邮箱收到的验证码", TextInputType.text),
          returnFormPassWord1(
              _password1, "输入您新的密码", TextInputType.visiblePassword),
          returnFormPassWord2(
              _password2, "重复您新的密码", TextInputType.visiblePassword),
          Container(
            margin: const EdgeInsets.only(top: 5, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: Global.deviceSize.height * 0.02,
                ),
                TextButton(
                  onPressed: checkEmail,
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
                    '发送验证码',
                    style: TextStyle(fontSize: 13.0, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: checkForgotForm,
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
                    '完成',
                    style: TextStyle(fontSize: 13.0, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void checkEmail() {
    if (sendVerificationCode) {
      toast("验证码已经发送，请您查收");
    } else {
      if (_userName.text == "") {
        toast("Please Enter UserName");
      } else {
        _checkEmail();
      }
    }
  }

  _checkEmail() async {
    try {
      FormData formData = FormData.fromMap({
        "username": _userName.text,
      });
      var response = await Global.dio
          .post('code/retrievePasswordVerificationCode/', data: formData);
      if (response.statusCode == 200) {
        if (response.data["success"]) {
          toast("已经发送，请您查收");
          sendVerificationCode = true;
          sendCodeBefore = true;
        } else {
          toast("发送失败，您的邮箱未经过认证");
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

  void checkForgotForm() {
    if (sendCodeBefore) {
      if (_userName.text == "") {
        toast("UserName不能为空");
      } else if (_emailVerification.text == "") {
        toast("Email Verification Code不能为空");
      } else if (_password1.text == "" || _password2.text == "") {
        toast("PassWord不能为空");
      } else if (_password1.text != _password2.text) {
        toast("两次输入的密码不一致");
      } else {
        _checkRegisterInfo();
      }
    } else {
      toast("请先点击'发送验证码'");
    }
  }

  _checkRegisterInfo() async {
    try {
      FormData formData = FormData.fromMap({
        "username": _userName.text,
        "code": _emailVerification.text,
        "password": _password1.text,
      });
      var response =
          await Global.dio.post('code/retrievePassword/', data: formData);
      sendVerificationCode = false;
      if (response.statusCode == 200) {
        if (response.data["success"]) {
          Navigator.of(context).pushNamed("login_page");
          toast("修改成功");
        } else {
          toast("修改失败，请您检查验证码是否正确");
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

  /*
  returnForm和returnFormPassWord的基本格式一致，returnFormPassWord多一个bool值的控制
  returnFormPassWord和showPassWord为一组，用来控制密码的输入框格式
  */

  Container returnForm(TextEditingController _textEditingController,
      String _labelText, TextInputType textInputType) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 240, 240, 240), width: 1.0))),
      child: TextFormField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: _labelText,
          // labelText: _labelText,
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
    );
  }

  Container returnFormPassWord1(TextEditingController _textEditingController,
      String _labelText, TextInputType textInputType) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 240, 240, 240), width: 1.0))),
      child: TextFormField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: _labelText,
          // labelText: _labelText,
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
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 240, 240, 240), width: 1.0))),
      child: TextFormField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: _labelText,
          // labelText: _labelText,
          labelStyle: const TextStyle(
              fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              isShowPassWord2 ? Icons.visibility : Icons.visibility_off,
              color: const Color.fromARGB(255, 126, 126, 126),
            ),
            onPressed: showPassWord2,
          ),
        ),
        keyboardType: textInputType,
        obscureText: !isShowPassWord2,
      ),
    );
  }

  void showPassWord2() {
    setState(() {
      isShowPassWord2 = !isShowPassWord2;
    });
  }
}
