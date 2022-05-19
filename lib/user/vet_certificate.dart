import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../common/toast.dart';
import '../main.dart';

class VetCer extends StatefulWidget {
  const VetCer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VetCer();
  }
}

class _VetCer extends State<VetCer> {
  final _picker = ImagePicker();
  File imagePath = File("");
  final TextEditingController _postController = TextEditingController();
  String typeValue = "兽医";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "资质认证",
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
            const Text("请上传您的资质认证证书或其他证明材料"),
            Row(
              children: [
                const Text("您要申请认证的身份:"),
                DropdownButton<String>(
                  value: typeValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      typeValue = newValue!;
                    });
                  },
                  items: <String>["兽医", "技师"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
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
                  height: Global.deviceSize.height * 0.3,
                  child: Center(
                    child: Image.file(imagePath),
                  )),
            Card(
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _postController,
                minLines: 2,
                maxLines: 10,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(252, 238, 238, 1),
                  hintText: "补充说明",
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
              child: const Text('申请认证'),
            )
          ],
        ),
      ),
    );
  }

  void openGallery() async {
    PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    print("\n\n\n\n" + pickedFile!.path + "\n\n\n\n");
    final File file = File(pickedFile.path);
    setState(() {
      imagePath = file;
    });
  }

  void takePhotos() async {
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.camera,
    );
    print("\n\n\n\n" + pickedFile!.path + "\n\n\n\n");
    final File file = File(pickedFile.path);
    setState(() {
      imagePath = file;
    });
  }

  void upLoadImg() {
    _upLoadImg();
  }

  _upLoadImg() async {
    try {
      FormData formData;
      if (imagePath.path == "") {
        formData = FormData.fromMap({
          "applicationDescription": _postController.text,
          "applicationType": typeValue,
        });
      } else {
        String path = imagePath.path;
        var name = path.substring(path.lastIndexOf("/") + 1, path.length);
        formData = FormData.fromMap({
          "applicationDescription": _postController.text,
          "applicationType": typeValue,
          "applicationImage": await MultipartFile.fromFile(path, filename: name)
        });
      }

      // 多个文件上传
      // var response = await Dio().post('10.0.0.2:5000/post/', data: formData);
      var response = await Global.dio.post('apply/', data: formData);
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
      // FormData.fromMap({
      //   'files': [
      //     MultipartFile.fromFileSync('./example/upload.txt',
      //         filename: 'upload.txt'),
      //     MultipartFile.fromFileSync('./example/upload.txt',
      //         filename: 'upload.txt'),
      //   ]
      // });
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }
}
