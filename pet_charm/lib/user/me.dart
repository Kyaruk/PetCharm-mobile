import 'package:flutter/material.dart';
import 'package:pet_charm/common/toast.dart';
import 'package:pet_charm/models/user.dart';
import 'package:pet_charm/user/user_info.dart';
import 'package:pet_charm/http/my_http.dart';
import 'package:pet_charm/user/ver_email.dart';
import '../main.dart';
import 'package:dio/dio.dart';

class Me extends StatefulWidget {
  const Me({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Me();
  }
}

class _Me extends State<Me> {
  late User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getUserInfo(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data;
            return Container(
              color: const Color.fromRGBO(248, 248, 248, 1),
              child: Column(
                children: <Widget>[
                  headInfo(),
                  blockTitle("宠物"),
                  blockArea1(),
                  blockTitle("我的"),
                  blockArea2(),
                  blockTitle("遛宠地图"),
                  blockArea3(),
                  Expanded(
                      child: Container(
                    color: Colors.white,
                  ))
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget headInfo() {
    return Container(
      ///设置背景渐变色
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey, //底色,阴影颜色
              offset: Offset(0, 0), //阴影位置,从什么位置开始
              blurRadius: 2, // 阴影模糊层度
              spreadRadius: 0.5, //阴影模糊大小
            ),
          ],
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: Container(
        margin: const EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: CircleAvatar(
                backgroundImage: ((user.userIconUrl == "")
                    ? const AssetImage("assets/images/User.jpg")
                    : NetworkImage(user.userIconUrl)) as ImageProvider,
              ),
            ),
            Expanded(
              flex: 100,
              child: Container(
                margin: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, //元素左对齐
                  children: <Widget>[
                    RawChip(
                        avatar: CircleAvatar(
                          child: Text(user.userName.substring(0, 1)),
                        ),
                        label: Text(user.userFirstName)),
                    // Text(
                    //   user.userName + "---" + user.userFirstName,
                    //   style: const TextStyle(
                    //       fontSize: 19,
                    //       fontWeight: FontWeight.bold,
                    //       color: Color.fromRGBO(255, 165, 170, 1)),
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    returnUserType(),
                  ],
                ),
              ),
            ),
//            Spacer(),
            Container(
              height: 28,
              padding: const EdgeInsets.only(right: 16, left: 6),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  side:
                      const BorderSide(color: Color.fromRGBO(255, 165, 170, 1)),
                ),
                child: const Baseline(
                  baseline: 12,
                  baselineType: TextBaseline.alphabetic,
                  child: Text("个人信息",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 165, 170, 1),
                          fontSize: 12),
                      textAlign: TextAlign.center),
                ),
                onPressed: () async {
                  User temp = User(
                      user.userId,
                      user.userName,
                      user.userFirstName,
                      user.userEmail,
                      user.userIconUrl,
                      user.userPhoneNumber,
                      user.userType,
                      user.userScore,
                      user.userEmailValid);
                  var result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return UserInfo(user: user, temp: temp);
                  }));
                  if (result != null && user != result) {
                    setState(() {
                      user = result;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///返回用户身份标识
  RawChip returnUserType() {
    if (user.userType == "兽医") {
      return const RawChip(
        label: Text(
          '兽医',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    } else if (user.userType == "技师") {
      return const RawChip(label: Text('技师'));
    }
    return const RawChip(label: Text('爱宠人士'));
  }

  Widget blockTitle(String title) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(top: 5, left: 0, right: 0),
        child: ClipRRect(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 39.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: Text(title,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 0),
                    color: const Color.fromRGBO(238, 238, 238, 1),
                    height: 0.5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget blockArea1() {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey, //底色,阴影颜色
              offset: Offset(0, 0), //阴影位置,从什么位置开始
              blurRadius: 1, // 阴影模糊层度
              spreadRadius: 0.5, //阴影模糊大小
            ),
          ],
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      // color: Colors.white,
      height: 92,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: Global.deviceSize.width * 0.25,
            child: TextButton(
              child: Column(
                children: const [
                  Expanded(
                    child: Icon(
                      Icons.pets,
                      color: Color.fromRGBO(255, 165, 170, 1),
                    ),
                  ),
                  Text("我的宠物",
                      style: TextStyle(color: Color.fromRGBO(255, 165, 170, 1)))
                ],
              ),
              onPressed: () {
                checkPet();
              },
            ),
          ),
          SizedBox(
            width: Global.deviceSize.width * 0.25,
            child: TextButton(
              child: Column(
                children: const [
                  Expanded(
                    child: Icon(
                      Icons.account_box_outlined,
                      color: Color.fromRGBO(255, 165, 170, 1),
                    ),
                  ),
                  Text("资质认证",
                      style: TextStyle(color: Color.fromRGBO(255, 165, 170, 1)))
                ],
              ),
              onPressed: () {
                if (user.userType == "兽医") {
                  toast("您的身份是兽医，无下一步身份认证");
                } else {
                  Navigator.of(context).pushNamed("vet_cer_page");
                }
              },
            ),
          ),
          SizedBox(
            width: Global.deviceSize.width * 0.25,
            child: TextButton(
              child: Column(
                children: const [
                  Expanded(
                    child: Icon(
                      Icons.account_box_outlined,
                      color: Color.fromRGBO(255, 165, 170, 1),
                    ),
                  ),
                  Text("兽医中心",
                      style: TextStyle(color: Color.fromRGBO(255, 165, 170, 1)))
                ],
              ),
              onPressed: () {
                if (user.userType != "兽医") {
                  toast("您的身份不是兽医，不可进入兽医中心");
                } else {
                  Navigator.of(context).pushNamed("set_all_pets");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void checkPet() {
    _checkPet();
  }

  _checkPet() async {
    try {
      var response = await Global.dio.get(
        'pet/',
      );
      if (response.statusCode == 200) {
        if (response.data["success"]) {
          Navigator.of(context).pushNamed("pet_info_page");
        } else {
          Navigator.of(context).pushNamed("register_page");
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

  Widget blockArea2() {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey, //底色,阴影颜色
              offset: Offset(0, 0), //阴影位置,从什么位置开始
              blurRadius: 1, // 阴影模糊层度
              spreadRadius: 0.5, //阴影模糊大小
            ),
          ],
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      // color: Colors.white,
      height: 92,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: Global.deviceSize.width * 0.25,
            child: TextButton(
              child: Column(
                children: const [
                  Expanded(
                    child: Icon(Icons.bookmarks,
                        color: Color.fromRGBO(255, 165, 170, 1)),
                  ),
                  Text("我的发帖",
                      style: TextStyle(color: Color.fromRGBO(255, 165, 170, 1)))
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("my_post_page");
              },
            ),
          ),
          SizedBox(
            width: Global.deviceSize.width * 0.25,
            child: TextButton(
              child: Column(
                children: const [
                  Expanded(
                    child: Icon(Icons.comment,
                        color: Color.fromRGBO(255, 165, 170, 1)),
                  ),
                  Text("我的评论",
                      style: TextStyle(color: Color.fromRGBO(255, 165, 170, 1)))
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("my_comments_page");
              },
            ),
          ),
          SizedBox(
            width: Global.deviceSize.width * 0.25,
            child: TextButton(
              child: Column(
                children: const [
                  Expanded(
                    child: Icon(Icons.shop_two,
                        color: Color.fromRGBO(255, 165, 170, 1)),
                  ),
                  Text("我的咨询",
                      style: TextStyle(color: Color.fromRGBO(255, 165, 170, 1)))
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("my_consultation_page");
              },
            ),
          ),
          SizedBox(
            width: Global.deviceSize.width * 0.25,
            child: TextButton(
              child: Column(
                children: const [
                  Expanded(
                    child: Icon(Icons.mark_email_read,
                        color: Color.fromRGBO(255, 165, 170, 1)),
                  ),
                  Text(
                    "邮箱认证",
                    style: TextStyle(color: Color.fromRGBO(255, 165, 170, 1)),
                  )
                ],
              ),
              onPressed: () async {
                if (!user.userEmailValid) {
                  if (user.userEmail == "") {
                    toast("您还没有添加邮箱");
                  } else {
                    var response = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return VerEmail(emailAddr: user.userEmail);
                    }));
                    if (response) {
                      setState(() {
                        user.userEmailValid = true;
                      });
                    }
                  }
                } else {
                  toast("您的邮箱已经认证，无需再次认证");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget blockArea3() {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey, //底色,阴影颜色
              offset: Offset(0, 0), //阴影位置,从什么位置开始
              blurRadius: 1, // 阴影模糊层度
              spreadRadius: 0.5, //阴影模糊大小
            ),
          ],
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      // color: Colors.white,
      height: 92,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: Global.deviceSize.width * 0.25,
            child: TextButton(
              child: Column(
                children: const [
                  Expanded(
                    child: Icon(Icons.map,
                        color: Color.fromRGBO(255, 165, 170, 1)),
                  ),
                  Text("录制轨迹",
                      style: TextStyle(color: Color.fromRGBO(255, 165, 170, 1)))
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("trace_path_page");
              },
            ),
          ),
          SizedBox(
            width: Global.deviceSize.width * 0.25,
            child: TextButton(
              child: Column(
                children: const [
                  Expanded(
                    child: Icon(Icons.list_alt,
                        color: Color.fromRGBO(255, 165, 170, 1)),
                  ),
                  Text("查看记录",
                      style: TextStyle(color: Color.fromRGBO(255, 165, 170, 1)))
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("path_record_page");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemCell(Icon itemIcon, String itemTitle, String url, int count) {
    double cWidth;
    if (count < 10) {
      cWidth = 20;
    } else if (count > 100) {
      cWidth = 35;
    } else {
      cWidth = 30;
    }
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 23,

                  /// left 要有一定大小来保持结构
                  margin: const EdgeInsets.only(top: 28, left: 20, right: 20),
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: itemIcon,
                    tooltip: 'item',
                    iconSize: 23,
                    onPressed: () {}, // FIXME
                  ),
                ),
                Positioned(
                  left: 17,
                  top: 20,
                  child: Offstage(
                    offstage: count == 0,
                    child: Container(
                      margin: const EdgeInsets.only(left: 30),
                      width: cWidth,
                      height: 14,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                            topRight: Radius.circular(7)),
                        color: Color(0xFFFF491C),
                      ),
                      child: Text(
                        count >= 100 ? '99+' : count.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 4),
              child: Text(
                itemTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
