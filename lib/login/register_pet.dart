import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../common/toast.dart';
import '../main.dart';

class RegisterPet extends StatefulWidget {
  const RegisterPet({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterPet();
  }
}

class _RegisterPet extends State<RegisterPet> {
  ///choice表示用户是否有宠物，0是初始状态，1是有，2是没有
  int choice = 0;
  bool petInfo = false;

  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petBreedController = TextEditingController();
  final TextEditingController _petGenderController = TextEditingController();
  final TextEditingController _petBirthController = TextEditingController();

  var selectItemValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "",
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
        leading: IconButton(
            color: const Color.fromRGBO(0, 0, 0, 1),
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Increase volume by 10',
            onPressed: () {
              Navigator.of(context).pushNamed("home_page");
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: Global.deviceSize.width * 0.35),
              child: Text(
                "让我们继续",
                style: TextStyle(
                    color: const Color.fromRGBO(208, 59, 51, 1.0),
                    fontSize: Global.deviceSize.width * 0.1,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  bottom: Global.deviceSize.width * 0.04,
                  left: Global.deviceSize.width * 0.05,
                  right: Global.deviceSize.width * 0.4),
              child: Text(
                "您是否拥有一只宠物?",
                style: TextStyle(
                    color: const Color.fromRGBO(208, 59, 51, 1.0),
                    fontSize: Global.deviceSize.width * 0.05,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: Global.deviceSize.width * 0.06,
                  right: Global.deviceSize.width * 0.06,
                  bottom: Global.deviceSize.width * 0.01),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white, width: 0))),
              child: Card(
                color: ((choice == 1)
                    ? const Color.fromRGBO(255, 154, 154, 1)
                    : const Color.fromRGBO(252, 238, 238, 1)),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Container(
                    padding: EdgeInsets.all(Global.deviceSize.width * 0.01),
                    child: ElevatedButton(
                      child: Text(
                        "🙋‍♂️ 是",
                        style: TextStyle(
                          fontSize: Global.deviceSize.width * 0.05,
                          color: (choice == 1)
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : const Color.fromRGBO(178, 178, 178, 1),
                        ),
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(choice == 1
                            ? const Color.fromRGBO(255, 154, 154, 1)
                            : const Color.fromRGBO(252, 238, 238, 1)),
                        minimumSize: MaterialStateProperty.all(Size(
                            MediaQuery.of(context).size.width * 0.9,
                            MediaQuery.of(context).size.height * 0.06)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      onPressed: clickHavePet,
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: Global.deviceSize.width * 0.06,
                  right: Global.deviceSize.width * 0.06,
                  bottom: Global.deviceSize.width * 0.02),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white, width: 0))),
              child: Card(
                color: ((choice == 2)
                    ? const Color.fromRGBO(255, 154, 154, 1)
                    : const Color.fromRGBO(252, 238, 238, 1)),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Container(
                  padding: EdgeInsets.all(Global.deviceSize.width * 0.01),
                  child: ElevatedButton(
                    child: Text(
                      "🙅‍♀️ 否",
                      style: TextStyle(
                        fontSize: Global.deviceSize.width * 0.05,
                        color: (choice == 2)
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(178, 178, 178, 1),
                      ),
                    ),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(choice == 2
                          ? const Color.fromRGBO(255, 154, 154, 1)
                          : const Color.fromRGBO(252, 238, 238, 1)),
                      minimumSize: MaterialStateProperty.all(Size(
                          MediaQuery.of(context).size.width * 0.9,
                          MediaQuery.of(context).size.height * 0.06)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    onPressed: clickHaveNoPet,
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                  left: Global.deviceSize.width * 0.05,
                  right: Global.deviceSize.width * 0.05,
                  bottom: Global.deviceSize.width * 0.035,
                ),
                child: returnCard()),
            (choice == 0 || choice == 2)
                ? Container(
                    padding: EdgeInsets.only(
                        top: Global.deviceSize.width * 0.05,
                        bottom: Global.deviceSize.width * 0.043,
                        left: Global.deviceSize.width * 0.03,
                        right: Global.deviceSize.width * 0.03),
                    width: Global.deviceSize.width,
                    child: Image.asset("assets/images/bg_petInfo.png"),
                  )
                : Container(),

            // (petInfo || choice == 2)
            //     ?
            Container(
              padding: EdgeInsets.only(
                  left: Global.deviceSize.width * 0.05,
                  right: Global.deviceSize.width * 0.05,
                  bottom: Global.deviceSize.width * 0.05,
                  top: Global.deviceSize.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (petInfo || choice == 2) ? checkPetForm : null,
                    style: TextButton.styleFrom(
                      backgroundColor: (petInfo || choice == 2)
                          ? const Color.fromRGBO(255, 186, 186, 1)
                          : const Color.fromARGB(255, 215, 215, 215),
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
                      'Next',
                      style: TextStyle(fontSize: 13.0, color: Colors.black),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> generateItemList() {
    final List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    const DropdownMenuItem<String> item1 =
        DropdownMenuItem(child: Text('狗'), value: '狗');
    const DropdownMenuItem<String> item2 =
        DropdownMenuItem(child: Text('猫'), value: '猫');
    const DropdownMenuItem<String> item3 =
        DropdownMenuItem(child: Text('鱼'), value: '鱼');
    const DropdownMenuItem<String> item4 =
        DropdownMenuItem(child: Text('鸟'), value: '鸟');
    const DropdownMenuItem<String> item5 =
        DropdownMenuItem(child: Text('猪'), value: '猪');
    const DropdownMenuItem<String> item6 =
        DropdownMenuItem(child: Text('兔子'), value: '兔子');
    const DropdownMenuItem<String> item7 =
        DropdownMenuItem(child: Text('老鼠'), value: '老鼠');
    const DropdownMenuItem<String> item8 =
        DropdownMenuItem(child: Text('其他'), value: '其他');
    items.add(item1);
    items.add(item2);
    items.add(item3);
    items.add(item4);
    items.add(item5);
    items.add(item6);
    items.add(item7);
    items.add(item8);
    return items;
  }

  void clickHavePet() {
    setState(() {
      choice = 1;
    });
  }

  void clickHaveNoPet() {
    setState(() {
      choice = 2;
    });
  }

  void submitPetInfo() {
    setState(() {
      petInfo = true;
    });
  }

  void modifyPetInfo() {
    setState(() {
      petInfo = false;
    });
  }

  void checkPetForm() {
    if (choice == 1) {
      if (_petNameController.text == "") {
        toast("请输入宠物的名字");
      } else if (selectItemValue == null) {
        toast("请输入宠物的类型");
      } else if (_petBreedController.text == "") {
        toast("请输入宠物的品质");
      } else if (_petGenderController.text == "") {
        toast("请输入宠物的性别");
      } else if (_petBirthController.text == "") {
        toast("请输入宠物的生日");
      } else {
        _checkPetForm();
      }
    } else if (choice == 2) {
      Navigator.of(context).pushNamed("home_page");
    } else {
      Navigator.of(context).pushNamed("error_page");
    }
  }

  _checkPetForm() async {
    FormData formData = FormData.fromMap({
      "petName": _petNameController.text,
      "petType": selectItemValue,
      "petBreed": _petBreedController.text,
      "petGender": _petGenderController.text,
      "petDateOfBirth": DateTime(2002, 9, 2),
    });
    try {
      var response = await Global.dio.post('pet/', data: formData);
      if (response.statusCode == 200) {
        if (response.data["success"]) {
          toast("成功添加宠物");
          Navigator.pushNamed(context, "home_page");
        } else {
          toast("Something Wrong");
        }
      } else {
        // print("ERROR:\nhttp请求出现错误，错误编码为:" + response.statusCode.toString());
        toast("Http Error: " + response.statusCode.toString());
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Card returnCard() {
    if (petInfo && choice != 2) {
      return Card(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            ListTile(
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: modifyPetInfo,
              ),
              title: const Text("宠物姓名"),
              subtitle: Text(_petNameController.text),
            ),
            ListTile(
              title: const Text("宠物类型"),
              subtitle: Text(selectItemValue),
            ),
            ListTile(
              title: const Text("宠物品种"),
              subtitle: Text(_petBreedController.text),
            ),
            ListTile(
              title: const Text("宠物性别"),
              subtitle: Text(_petGenderController.text),
            ),
            ListTile(
              title: const Text("宠物生日"),
              subtitle: Text(_petBirthController.text),
            )
          ],
        ),
      );
    } else if (choice == 1) {
      return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: Colors.white,
            width: 0,
          ),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.height * 0.45,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Global.deviceSize.width * 0.02,
                    right: Global.deviceSize.width * 0.4),
                child: Text(
                  "添加一只宠物",
                  style: TextStyle(
                      color: const Color.fromRGBO(208, 59, 51, 1.0),
                      fontSize: Global.deviceSize.width * 0.07,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: Global.deviceSize.width * 0.035,
                        ),
                        child: Text(
                          "名称",
                          style: TextStyle(
                              color: const Color.fromRGBO(208, 59, 51, 1.0),
                              fontSize: Global.deviceSize.width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: returnPetForm(
                            _petNameController, "宠物名称", 0.025, 0.025),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: Global.deviceSize.width * 0.035,
                        ),
                        child: Text(
                          "类型\n品种",
                          style: TextStyle(
                              color: const Color.fromRGBO(208, 59, 51, 1.0),
                              fontSize: Global.deviceSize.width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: Global.deviceSize.width * 0.025,
                              right: Global.deviceSize.width * 0),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromRGBO(250, 250, 250, 1),
                                      width: 0))),
                          child: Card(
                              color: const Color.fromRGBO(252, 238, 238, 1),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromARGB(
                                                255, 240, 240, 240),
                                            width: 0))),
                                padding: EdgeInsets.only(
                                    top: Global.deviceSize.width * 0.01,
                                    right: Global.deviceSize.width * 0.01,
                                    bottom: Global.deviceSize.width * 0.01,
                                    left: Global.deviceSize.width * 0.045),
                                // child: Center(
                                child: DropdownButton<String>(
                                  hint: const Text("宠物种类"),
                                  underline: Container(
                                    height: 0,
                                  ),
                                  items: generateItemList(),
                                  onChanged: (var value) {
                                    setState(() {
                                      selectItemValue = value;
                                    });
                                  },
                                  value: selectItemValue,
                                ),
                                // ),
                              )),
                        ),
                      ),
                      Expanded(
                        child:
                            returnPetForm(_petBreedController, "品种", 0, 0.025),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: Global.deviceSize.width * 0.035,
                        ),
                        child: Text(
                          "性别",
                          style: TextStyle(
                              color: const Color.fromRGBO(208, 59, 51, 1.0),
                              fontSize: Global.deviceSize.width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: returnPetForm(
                            _petGenderController, "性别", 0.03, 0.025),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: Global.deviceSize.width * 0.04,
                        ),
                        child: Text(
                          "生日",
                          style: TextStyle(
                              color: const Color.fromRGBO(208, 59, 51, 1.0),
                              fontSize: Global.deviceSize.width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: returnPetForm(
                            _petBirthController, "生日", 0.03, 0.025),
                      ),
                    ],
                  ),
                  // returnPetForm(_petNameController, "Pet Name"),
                  // returnPetForm(_petTypeController, "Pet Species"),
                  // returnPetForm(_petBreedController, "Pet Breed"),
                  // returnPetForm(_petGenderController, "Pet Gender"),
                  // returnPetForm(_petBirthController, "Date of birth"),
                  IconButton(
                    icon: ImageIcon(
                      const AssetImage("assets/icons/button_petInfo.png"),
                      color: const Color.fromRGBO(208, 59, 51, 1.0),
                      size: Global.deviceSize.width * 0.1,
                    ),
                    onPressed: submitPetInfo,
                  )
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return const Card();
    }
  }

  Container returnPetForm(TextEditingController _textEditingController,
      String _labelText, double _leftPadding, double _rightPadding) {
    return Container(
      padding: EdgeInsets.only(
          left: Global.deviceSize.width * _leftPadding,
          right: Global.deviceSize.width * _rightPadding),
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
              keyboardType: TextInputType.text,
              controller: _textEditingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(252, 238, 238, 1),
                hintText: _labelText,
                labelStyle: const TextStyle(
                    // fontSize: 15.0,
                    color: Color.fromARGB(255, 93, 93, 93)),
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
            ),
          )),
    );
  }
}
