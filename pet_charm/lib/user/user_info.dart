import 'package:flutter/material.dart';
import 'package:pet_charm/models/user.dart';
import 'package:pet_charm/main.dart';
import 'package:pet_charm/common/toast.dart';
import 'package:pet_charm/common/formatChecker.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserInfo extends StatefulWidget {
  UserInfo({Key? key, required this.user, required this.temp})
      : super(key: key);

  User user, temp;

  @override
  State<StatefulWidget> createState() {
    return _UserInfo();
  }
}

class _UserInfo extends State<UserInfo> {
  final _picker = ImagePicker();
  File imagePath = File("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7E9EC),
        title: const Text(
          "User Info",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context, widget.user);
          },
        ),
        actions: [
          TextButton(
            child: const Text("Save", style: TextStyle(color: Colors.black)),
            onPressed: () {
              widget.user = widget.temp;
              checkUserInfo(widget.user);
            },
            style: TextButton.styleFrom(),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Global.deviceSize.height * 0.05),
              GestureDetector(
                onTap: _showModalBottomSheetUserUrl,
                child: SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundImage: (widget.temp.userIconUrl != ""
                                ? NetworkImage(widget.temp.userIconUrl)
                                : const AssetImage("assets/images/User.jpg"))
                            as ImageProvider,
                        // backgroundImage: NetworkImage(temp.userIconUrl),
                      ),
                      Positioned(
                        right: -10,
                        bottom: 0,
                        child: SizedBox(
                            height: 65,
                            width: 65,
                            child: IconButton(
                              color: const Color(0xFFF5F6F9),
                              onPressed: _showModalBottomSheetUserUrl,
                              icon: const Icon(Icons.add_a_photo_outlined),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: Global.deviceSize.height * 0.05),
              Text("userName: " + widget.temp.userName),
              SizedBox(height: Global.deviceSize.height * 0.05),
              returnItem(
                  widget.temp.userFirstName,
                  const Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                  _showModalBottomSheetUserName),
              returnItem(
                  (widget.temp.userType == "") ? "爱宠人士" : widget.temp.userType,
                  const Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                  route2VerCer),
              returnItem(
                  (widget.temp.userEmail == "")
                      ? "您没有设置邮箱"
                      : widget.temp.userEmail,
                  const Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                  _showModalBottomSheetEmail),
              returnItem(
                  (widget.temp.userPhoneNumber == "")
                      ? "您没有设置电话"
                      : widget.temp.userPhoneNumber.substring(0, 3) +
                          "-" +
                          widget.temp.userPhoneNumber.substring(3, 7) +
                          "-" +
                          widget.temp.userPhoneNumber.substring(7, 11),
                  const Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                  _showModalBottomSheetPhoneNumber),
              // Item("My Info", const Icon(Icons.person), () {}),
            ],
          ),
        ),
      ),
    );
  }

  Padding returnItem(String text, Icon icon, VoidCallback press) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: const Color.fromRGBO(252, 238, 238, 1),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child:
                    Text(text, style: Theme.of(context).textTheme.bodyText1)),
            const Icon(Icons.arrow_forward_ios, color: Colors.red),
          ],
        ),
        onPressed: press,
      ),
    );
  }

  void _showModalBottomSheetUserName() {
    TextEditingController _textEditingController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _textEditingController,
                  maxLines: 5,
                ),
                TextButton(
                  child: const Text("Save"),
                  onPressed: () {
                    setState(() {
                      widget.temp.setFirstName(_textEditingController.text);
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
      },
    );
  }

  void route2VerCer() {
    Navigator.of(context).pushNamed("vet_cer_page");
  }

  void _showModalBottomSheetEmail() {
    TextEditingController _textEditingController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _textEditingController,
                  maxLines: 5,
                ),
                TextButton(
                  child: const Text("Save"),
                  onPressed: () {
                    if (formatChecker(_textEditingController.text, 1)) {
                      setState(() {
                        widget.temp.setEmail(_textEditingController.text);
                      });
                      Navigator.pop(context);
                    } else {
                      toast(
                          "邮箱地址应该符合正则表达式：'[A-Za-z0-9_-.]+@([A-Za-z0-9_-.])+.([A-Za-z]{2,4})'");
                    }
                  },
                ),
              ],
            ));
      },
    );
  }

  void _showModalBottomSheetPhoneNumber() {
    TextEditingController _textEditingController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _textEditingController,
                  maxLines: 5,
                ),
                TextButton(
                  child: const Text("Save"),
                  onPressed: () {
                    if (formatChecker(_textEditingController.text, 0)) {
                      setState(() {
                        widget.temp.setPhoneNumber(_textEditingController.text);
                      });
                      Navigator.pop(context);
                    } else {
                      toast("电话应该符合正则表达式：'[0-9]{11}'");
                    }
                  },
                ),
              ],
            ));
      },
    );
  }

  void _showModalBottomSheetUserUrl() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
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
                                const BorderSide(
                                    color: Colors.white, width: 0.67),
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
                                const BorderSide(
                                    color: Colors.white, width: 0.67),
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
                TextButton(
                  child: const Text("Save"),
                  onPressed: () {
                    if (imagePath.path != "") {
                      upLoadImg();
                      Navigator.pop(context);
                    } else {
                      toast("未选择图片");
                    }
                  },
                ),
              ],
            ));
      },
    );
  }

  void upLoadImg() {
    _upLoadImg();
  }

  _upLoadImg() async {
    try {
      String path = imagePath.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      FormData formData = FormData.fromMap(
          {"image": await MultipartFile.fromFile(path, filename: name)});

      var response = await Global.dio.post('uploadImage/', data: formData);
      if (response.statusCode == 200) {
        if (response.data["success"]) {
          setState(() {
            widget.temp.setUserIconUrl(response.data["imageUrl"]);
          });
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

  void checkUserInfo(User user) {
    _checkUserInfo(user);
  }

  _checkUserInfo(User user) async {
    FormData formData = FormData.fromMap({
      "userFirstName": user.userFirstName,
      "userEmail": user.userEmail,
      "userIconUrl": user.userIconUrl,
      "userPhoneNumber": user.userPhoneNumber,
    });
    try {
      var response = await Global.dio.post('user/', data: formData);
      if (response.statusCode == 200) {
        Navigator.pop(context, user);
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
