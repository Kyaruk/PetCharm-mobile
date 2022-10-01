import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../common/toast.dart';
import '../main.dart';

class PostConsultationReply extends StatefulWidget {
  const PostConsultationReply({Key? key, required this.consultationId})
      : super(key: key);

  final int consultationId;

  @override
  _PostConsultationReply createState() => _PostConsultationReply();
}

class _PostConsultationReply extends State<PostConsultationReply> {
  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "发布回复",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //修改颜色
        ),
        backgroundColor: const Color(0xFFE7E9EC),
        // backgroundColor: Color(0xD7000000),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: TextFormField(
                controller: _postController,
                maxLines: 10,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(252, 238, 238, 1),
                  hintText: "Post Comment",
                  labelStyle: const TextStyle(
                      fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color.fromARGB(255, 126, 126, 126),
                    ),
                    onPressed: () {
                      _postController.text = "";
                    },
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: upLoadImg,
              child: const Text('上传'),
            )
          ],
        ),
      ),
    );
  }

  void upLoadImg() {
    if (_postController.text == "") {
      toast("请输入帖子内容");
    } else {
      _upLoadImg();
    }
  }

  _upLoadImg() async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        "consultationId": widget.consultationId,
        "consultationReplyContent": _postController.text,
      });

      var response =
          await Global.dio.post('consultation/reply/', data: formData);
      if (response.statusCode == 200) {
        if (response.data["success"]) {
          Navigator.pushNamed(context, "home_page");
        } else {
          toast("Something Wrong, Try Again");
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
}
