import 'package:flutter/material.dart';
import 'package:pet_charm/http/my_http.dart';
import 'package:pet_charm/main.dart';
import 'package:pet_charm/common/toast.dart';
import 'package:dio/dio.dart';
import 'package:pet_charm/models/pet.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../common/formatChecker.dart';

class PetInfo extends StatefulWidget {
  const PetInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PetInfo();
  }
}

class _PetInfo extends State<PetInfo> {
  DateTime initialDate = DateTime.now();
  Pet pet =
      Pet(0, "petName", "petType", "petBreed", "petGender", DateTime.now(), "");
  Pet temp =
      Pet(0, "petName", "petType", "petBreed", "petGender", DateTime.now(), "");
  final _picker = ImagePicker();
  File imagePath = File("");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPetInfo(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var response = snapshot.data;
            if (response.statusCode == 200) {
              if (response.data['success']) {
                pet = Pet.fromJson(response.data['pet']);
                if (temp.petId != 0) {
                  pet = temp;
                } else {
                  temp = pet;
                }
                initialDate = pet.petDateOfBirth;
              } else {
                toast("网络出现错误，请您退出重试");
              }
            } else {
              // print("ERROR:\nhttp请求出现错误，错误编码为:" + response.statusCode.toString());
              toast("Http Error: " + response.statusCode.toString());
              // toast("请检查您的网络连接或稍后重试");
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFFE7E9EC),
                title: const Text(
                  "Pet Info",
                  style: TextStyle(color: Colors.black),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  TextButton(
                    child: const Text("Save",
                        style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      checkPetInfo(pet);
                    },
                    style: TextButton.styleFrom(),
                  )
                ],
              ),
              body: buildBody(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget buildBody() {
    return Center(
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
                    backgroundImage: (pet.petIconUrl != ""
                            ? NetworkImage(pet.petIconUrl)
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
          buildItem(
              pet.petName,
              const Icon(
                Icons.pets,
                color: Colors.red,
              ),
              _showModalBottomSheetName),
          buildItem(pet.petType, const Icon(Icons.pets, color: Colors.red),
              _showModalBottomSheetType),
          buildItem(pet.petBreed, const Icon(Icons.pets, color: Colors.red),
              _showModalBottomSheetBreed),
          buildItem(pet.petGender, const Icon(Icons.pets, color: Colors.red),
              _showModalBottomSheetGender),
          buildItem(
              DateFormat("yyyy-MM-dd").format(pet.petDateOfBirth).toString() +
                  " - 距今：" +
                  DateTime.now()
                      .difference(pet.petDateOfBirth)
                      .inDays
                      .toString() +
                  "天",
              const Icon(Icons.pets, color: Colors.red),
              _showModalBottomSheetAge),
        ],
      ),
    );
  }

  Padding buildItem(String text, Icon icon, VoidCallback press) {
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
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            ),
          ],
        ),
        onPressed: press,
      ),
    );
  }

  void _showModalBottomSheetName() {
    TextEditingController _textEditingController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _textEditingController,
                    maxLines: 5,
                  ),
                  TextButton(
                    child: const Text("Save"),
                    onPressed: () {
                      setState(() {
                        pet.setPetName(_textEditingController.text);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _showModalBottomSheetType() {
    TextEditingController _textEditingController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _textEditingController,
                  maxLines: 5,
                ),
                SizedBox(height: Global.deviceSize.height * 0.02),
                const Text("请您输入'狗'、'猫'、'鱼'、'鸟'、'猪'、'兔子'、'老鼠'或'其他'"),
                TextButton(
                  child: const Text("Save"),
                  onPressed: () {
                    if (formatChecker(_textEditingController.text, 2)) {
                      setState(() {
                        pet.setPetType(_textEditingController.text);
                      });
                      Navigator.pop(context);
                    } else {
                      toast("您的输入不符合规范");
                      _textEditingController.text = "";
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showModalBottomSheetBreed() {
    TextEditingController _textEditingController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _textEditingController,
                    maxLines: 5,
                  ),
                  TextButton(
                    child: const Text("Save"),
                    onPressed: () {
                      setState(() {
                        pet.setPetBreed(_textEditingController.text);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _showModalBottomSheetGender() {
    TextEditingController _textEditingController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _textEditingController,
                    maxLines: 5,
                  ),
                  SizedBox(height: Global.deviceSize.height * 0.02),
                  const Text("请您输入'男孩子'、'女孩子'或'其他'"),
                  TextButton(
                    child: const Text("Save"),
                    onPressed: () {
                      if (formatChecker(_textEditingController.text, 3)) {
                        setState(() {
                          pet.setPetGender(_textEditingController.text);
                        });
                        Navigator.pop(context);
                      } else {
                        toast("您的输入不符合规范");
                        _textEditingController.text = "";
                      }
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }

  _showModalBottomSheetAge() async {
    var picker = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1986),
        lastDate: DateTime(DateTime.now().year + 2),
        locale: const Locale("zh"));
    if (picker != null) {
      setState(() {
        initialDate = picker;
        pet.setTime(initialDate);
        // _timeTxt.text = dataFormat.formatDate(picker, ['yyyy', '-', 'mm', '-', 'dd']);
      });
    }
  }

  void checkPetInfo(Pet pet) {
    _checkPetInfo(pet);
  }

  _checkPetInfo(Pet pet) async {
    try {
      //TODO：时间格式测试
      FormData formData = FormData.fromMap({
        "petName": pet.petName,
        "petType": pet.petType,
        "petBreed": pet.petBreed,
        "petGender": pet.petGender,
        "petDateOfBirth": pet.petDateOfBirth,
        "petIconUrl": pet.petIconUrl,
        "test": DateFormat("yyyy-MM-dd").format(pet.petDateOfBirth).toString()
      });
      var response = await Global.dio.post('pet/', data: formData);
      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        // print("ERROR:\nhttp请求出现错误，错误编码为:" + response.statusCode.toString());
        toast("Http Error: " + response.statusCode.toString());
      }
    } on DioError catch (e) {
      toast("请检查您的网络情况并稍后重试");
      throw Exception(e.response?.data);
    }
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
            pet.setPetIconUrl(response.data["imageUrl"]);
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
}
