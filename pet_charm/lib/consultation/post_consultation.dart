import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../common/toast.dart';
import '../main.dart';

class PostConsultation extends StatefulWidget {
  const PostConsultation({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  _PostConsultation createState() => _PostConsultation();
}

class _PostConsultation extends State<PostConsultation> {
  final _picker = ImagePicker();
  File imagePath = File("");
  final TextEditingController _postTitleController = TextEditingController();
  final TextEditingController _postController = TextEditingController();

  _PostConsultation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "发起咨询",
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
            Row(
              children: [
                SizedBox(
                  width: Global.deviceSize.width * 0.03,
                ),
                Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(252, 238, 238, 1)),
                          side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.white, width: 0.67),
                          ),
                        ),
                        onPressed: openGallery,
                        child: const Text('图库',
                            style: TextStyle(color: Colors.red)))),
                SizedBox(
                  width: Global.deviceSize.width * 0.03,
                ),
                Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(252, 238, 238, 1)),
                          side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.white, width: 0.67),
                          ),
                        ),
                        onPressed: takePhotos,
                        child: const Text('拍照',
                            style: TextStyle(color: Colors.red)))),
                SizedBox(
                  width: Global.deviceSize.width * 0.03,
                ),
              ],
            ),
            if (imagePath.path == "")
              SizedBox(
                height: Global.deviceSize.height * 0.3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(252, 238, 238, 1),
                  ),
                  child: const Center(child: Text('未选择图片')),
                ),
              )
            else
              SizedBox(
                  height: Global.deviceSize.height * 0.5,
                  child: Center(
                    child: Image.file(imagePath),
                  )),
            Card(
              child: TextFormField(
                controller: _postTitleController,
                minLines: 1,
                maxLines: 2,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(252, 238, 238, 1),
                  hintText: "Post Title",
                  labelStyle: const TextStyle(
                      fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color.fromARGB(255, 126, 126, 126),
                    ),
                    onPressed: () {
                      _postTitleController.text = "";
                    },
                  ),
                ),
              ),
            ),
            Card(
              child: TextFormField(
                controller: _postController,
                maxLines: 10,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(252, 238, 238, 1),
                  hintText: "Post Message",
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

  void openGallery() async {
    PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    // print("\n\n\n\n" + pickedFile!.path + "\n\n\n\n");
    final File file = File(pickedFile!.path);
    setState(() {
      imagePath = file;
    });
  }

  void takePhotos() async {
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.camera,
    );
    // print("\n\n\n\n" + pickedFile!.path + "\n\n\n\n");
    final File file = File(pickedFile!.path);
    setState(() {
      imagePath = file;
    });
  }

  void upLoadImg() {
    if (_postTitleController.text == "") {
      toast("请输入帖子标题");
    } else if (_postController.text == "") {
      toast("请输入帖子内容");
    } else {
      _upLoadImg();
    }
  }

  _upLoadImg() async {
    try {
      FormData formData;
      if (imagePath.path == "") {
        formData = FormData.fromMap({
          "consultationUser": widget.userId,
          "consultationTitle": _postTitleController.text,
          "consultationContent": _postController.text,
        });
      } else {
        String path = imagePath.path;
        var name = path.substring(path.lastIndexOf("/") + 1, path.length);
        formData = FormData.fromMap({
          "consultationUser": widget.userId,
          "consultationTitle": _postTitleController.text,
          "consultationContent": _postController.text,
          "consultationCover":
              await MultipartFile.fromFile(path, filename: name)
        });
      }

      // 多个文件上传
      // var response = await Dio().post('10.0.0.2:5000/post/', data: formData);
      var response = await Global.dio.post('consultation/', data: formData);
      if (response.statusCode == 200) {
        if (response.data["success"]) {
          Navigator.pushNamed(context, "home_page");
        } else {
          toast("请检查您的网络连接或稍后重试");
        }
      } else {
        // print("ERROR:\nhttp请求出现错误，错误编码为:" + response.statusCode.toString());
        // toast("Http Error: " + response.statusCode.toString());
        toast("请检查您的网络连接或稍后重试");
      }
      // FormData.fromMap({
      //   'files': [
      //     MultipartFile.fromFileSync('./example/upload.txt',
      //         filename: 'upload.txt'),
      //     MultipartFile.fromFileSync('./example/upload.txt',
      //         filename: 'upload.txt'),
      //   ]
      // });
    } on DioError catch (e) {
      toast("请检查您的网络情况并稍后重试");
      throw Exception(e.response?.data);
    }
  }
}
