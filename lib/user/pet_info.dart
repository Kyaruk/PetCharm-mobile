import 'package:flutter/material.dart';
import 'package:pet_charm/main.dart';
import 'package:pet_charm/common/toast.dart';
import 'package:dio/dio.dart';
import 'package:pet_charm/models/pet.dart';

class PetInfo extends StatefulWidget {
  const PetInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PetInfo();
  }
}

class _PetInfo extends State<PetInfo> {
  late Pet pet = Pet("", "", "", "", "", "");

  @override
  void initState() {
    super.initState();
    // pet = Pet("petName", "petType", "petBreed", "petGender", "petAge", false);
    getPet();
  }

  Future<void> getPet() async {
    var response = await Global.dio.get(
      'pet/',
    );
    if (response.statusCode == 200) {
      if (response.data['success']) {
        setState(() {
          pet = Pet.fromJson(response.data['pet']);
        });
      } else {
        Navigator.of(context).pushNamed("register_page");
      }
    } else {
      setState(() {
        pet = Pet(
            "petId", "petName", "petType", "petBreed", "petGender", "petAge");
      });
      // print("ERROR:\nhttp请求出现错误，错误编码为:" + response.statusCode.toString());
      toast("Http Error: " + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7E9EC),
        title: const Text(
          "Pet Info",
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
            child: const Text("Save", style: TextStyle(color: Colors.black)),
            onPressed: () {
              checkPetInfo(pet);
            },
            style: TextButton.styleFrom(),
          )
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: Global.deviceSize.height * 0.05),
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                const Text("Pet Info"),
                // CircleAvatar(
                //   // backgroundImage: AssetImage("assets/images/User.jpg"),
                //   backgroundImage: NetworkImage(temp.userIconUrl),
                // ),
                Positioned(
                  right: -10,
                  bottom: 0,
                  child: SizedBox(
                      height: 65,
                      width: 65,
                      child: IconButton(
                        color: const Color(0xFFF5F6F9),
                        onPressed: () {},
                        icon: const Icon(Icons.add_a_photo_outlined),
                      )),
                )
              ],
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
          buildItem(pet.petDateOfBirth, const Icon(Icons.pets, color: Colors.red),
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
                      pet.setPetType(_textEditingController.text);
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
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
                  },
                ),
              ],
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
                      pet.setPetGender(_textEditingController.text);
                    });
                  },
                ),
              ],
            ));
      },
    );
  }

  void _showModalBottomSheetAge() {
    TextEditingController _textEditingController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: MediaQuery.of(context).viewInsets,
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
                      pet.setTime(_textEditingController.text);
                    });
                  },
                ),
              ],
            ));
      },
    );
  }

  void checkPetInfo(Pet pet) {
    _checkPetInfo(pet);
  }

  _checkPetInfo(Pet pet) async {
    FormData formData = FormData.fromMap({
      "petName": pet.petName,
      "petType": pet.petType,
      "petBreed": pet.petBreed,
      "petGender": pet.petGender,
      "petAge": pet.petDateOfBirth
    });
    var response = await Global.dio.post('pet/', data: formData);
    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      // print("ERROR:\nhttp请求出现错误，错误编码为:" + response.statusCode.toString());
      toast("Http Error: " + response.statusCode.toString());
    }
  }
}
