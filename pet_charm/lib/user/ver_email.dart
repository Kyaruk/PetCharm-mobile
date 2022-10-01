import 'package:flutter/material.dart';
import 'package:pet_charm/common/toast.dart';
import 'package:pet_charm/main.dart';
import 'package:dio/dio.dart';

class VerEmail extends StatefulWidget {
  const VerEmail({Key? key, required this.emailAddr}) : super(key: key);
  final String emailAddr;

  @override
  State<StatefulWidget> createState() {
    return _VerEmail();
  }
}

class _VerEmail extends State<VerEmail> {
  final TextEditingController _emailVerification = TextEditingController();
  bool sendVerificationCode = false;
  bool sendCodeBefore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "邮箱认证",
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
          SizedBox(height: Global.deviceSize.height * 0.05),
          Text(
            "您所要进行认证的邮箱为：" + widget.emailAddr,
            style: TextStyle(
                color: const Color.fromRGBO(208, 59, 51, 1.0),
                fontSize: Global.deviceSize.width * 0.08,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: Global.deviceSize.height * 0.02),
          returnForm(_emailVerification, "输入您邮箱收到的验证码", TextInputType.text),
          Container(
            margin: const EdgeInsets.only(top: 5, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: Global.deviceSize.height * 0.02,
                ),
                TextButton(
                  onPressed: getVerCode,
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
                SizedBox(
                  height: Global.deviceSize.height * 0.01,
                ),
                TextButton(
                  onPressed: checkVerCode,
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
                    '提交验证',
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

  void getVerCode() {
    if (sendVerificationCode) {
      toast("验证码已经发送，请您查收");
    } else {
      _getVerCode();
    }
  }

  _getVerCode() async {
    try {
      var response = await Global.dio.get('code/verificationCode/');
      if (response.statusCode == 200) {
        if (response.data["success"]) {
          toast("已经发送，请您查收");
          sendVerificationCode = true;
          sendCodeBefore = true;
        } else {
          toast("发送失败，请检查您的邮箱是否正确");
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

  void checkVerCode() {
    if (sendCodeBefore) {
      if (_emailVerification.text == "") {
        toast("Email Verification Code不能为空");
      } else {
        _checkVerCode();
      }
    } else {
      toast("请先点击'发送验证码'");
    }
  }

  _checkVerCode() async {
    try {
      FormData formData = FormData.fromMap({
        "code": _emailVerification.text,
      });
      var response =
          await Global.dio.post('code/verificationCode/', data: formData);
      sendVerificationCode = false;
      if (response.statusCode == 200) {
        if (response.data["success"]) {
          Navigator.of(context).pop(true);
          toast("认证成功");
        } else {
          toast("认证失败，请您重新获取验证码");
          sendVerificationCode = false;
          sendCodeBefore = false;
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
}
