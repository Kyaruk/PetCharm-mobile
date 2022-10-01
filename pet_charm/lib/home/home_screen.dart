import 'package:flutter/material.dart';
import '../common/toast.dart';
import '../main.dart';
import 'home_page.dart';
import 'vet_page.dart';
import 'package:pet_charm/user/me.dart';
import 'package:pet_charm/petAdoption/home.dart';

//底部的索引
int _selectedIndex = 0;
// 创建数组引入页面
List pageList = [
  const HomePage(),
  const MyHomePage(),
  const VetPage(),
  const Me()
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: pageList[_selectedIndex],
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 3,
      title: _selectedIndex == 0
          ? const Text(
              "首页资讯",
              style: TextStyle(color: Colors.black),
            )
          : _selectedIndex == 1
              ? const Text(
                  "宠物列表",
                  style: TextStyle(color: Colors.black),
                )
              : _selectedIndex == 2
                  ? const Text(
                      "咨询服务",
                      style: TextStyle(color: Colors.black),
                    )
                  : const Text(
                      "我的",
                      style: TextStyle(color: Colors.black),
                    ),
      iconTheme: const IconThemeData(
        color: Colors.black, //修改颜色
      ),
      backgroundColor: const Color.fromRGBO(250, 249, 249, 1),
      // backgroundColor: Color(0xD7000000),
      // leading: IconButton(
      //   icon: SvgPicture.asset("assets/icons/back.svg"),
      //   onPressed: () {},
      // ),
      actions: <Widget>[returnAction(), const SizedBox(width: 10.0)],
    );
  }

  //右上角小图标组件
  Widget returnAction() {
    if (_selectedIndex == 3) {
      return TextButton(
        child: const Text(
          "登出",
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        onPressed: logout,
      );
    } else if (_selectedIndex == 1) {
      return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          Navigator.of(context).pushNamed("searchPet_page");
        },
      );
    } else if (_selectedIndex == 2) {
      return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          Navigator.of(context).pushNamed("searchVet_page");
        },
      );
    }
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        Navigator.of(context).pushNamed("searchPost_page");
      },
    );
  }

  void logout() {
    _logout();
  }

  _logout() async {
    var response = await Global.dio.get('logout/');
    if (response.statusCode == 200) {
      if (response.data["success"]) {
        toast("Logout Successfully");
        Navigator.pushNamed(context, "login_page");
      } else {
        toast("Something Wrong, Try Again");
      }
    } else {
      // print("ERROR:\nhttp请求出现错误，错误编码为:" + response.statusCode.toString());
      toast("Http Error: " + response.statusCode.toString());
    }
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      fixedColor: const Color(0xFF535353),
      type: BottomNavigationBarType.fixed,
      elevation: 5.0,
      unselectedFontSize: 12.0,
      selectedFontSize: 18.0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
        BottomNavigationBarItem(
            icon: Icon(Icons.wysiwyg_outlined), label: '宠物列表'),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_outlined), label: '咨询服务'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined), label: '我'),
      ],
      currentIndex: _selectedIndex,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
          // if(_selectedIndex == 3){
          //   Navigator.pushNamed(context, "new_user_page");
          // }
        });
      },
      // onTap: _onItemTapped,
    );
  }
}
