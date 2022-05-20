import 'package:flutter/material.dart';
import 'package:pet_charm/models/user.dart';
import 'package:pet_charm/user/user_info.dart';
import '../common/toast.dart';
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
  Future<User> getUser() async {
    try {
      var response = await Global.dio.get(
        'user/',
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        // print("ERROR:\nhttp请求出现错误，错误编码为:" + response.statusCode.toString());
        toast("Http Error: " + response.statusCode.toString());
        return User("", "", "", "", "", "");
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }

  late User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFFE7E9EC),
      //   title: const Text(
      //     "我的",
      //     style: TextStyle(
      //         color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      //   ),
      //
      //   ///导航栏下的那条黑线
      //   elevation: 0,
      //
      //   ///右侧按钮，可设置多个
      //   actions: <Widget>[
      //     TextButton(
      //       child: const Text(
      //         "设置",
      //         style: TextStyle(
      //             color: Colors.black,
      //             fontSize: 15,
      //             fontWeight: FontWeight.bold),
      //       ),
      //       onPressed: () {
      //         // FIXME  设置动作？
      //       },
      //     ),
      //   ],
      // ),
      body: FutureBuilder(
        future: getUser(),
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
          gradient: LinearGradient(
        colors: [
          // Color.fromRGBO(216, 12, 30, 1),
          // Color.fromRGBO(255,165,170,1),
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

              ///切成圆形
              // child: const ClipOval(
              //   child: Image(
              //     image: AssetImage('assets/images/User.jpg'),
              //     width: 48,
              //     height: 48,
              //   ),
              // ),
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
                    Text(
                      user.userName,

                      /// 可加长，会显示...  // FIXME
                      style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 165, 170, 1)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
                  User temp = User(user.userId, user.userName, user.email, user.userIconUrl,
                      user.userPhoneNumber, user.userType);
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
      return const RawChip(label: Text('兽医'));
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
//           borderRadius: BorderRadius.only(
// //              topLeft: Radius.circular(10), topRight: Radius.circular(10)
//           ),
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
                                fontWeight: FontWeight.w400),
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
//      child:
      ),
    );
  }

  Widget blockArea1() {
    return Container(
      color: Colors.white,
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
                Navigator.of(context).pushNamed("pet_info_page");
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
                Navigator.of(context).pushNamed("vet_cer_page");
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
                //TODO：兽医身份认证
                Navigator.of(context).pushNamed("set_all_pets");
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
                  Text("遛狗地图",
                      style: TextStyle(color: Color.fromRGBO(255, 165, 170, 1)))
                ],
              ),
              onPressed: () {
                //TODO：兽医身份认证
                Navigator.of(context).pushNamed("set_all_pets");
              },
            ),
          ),
          // itemCell(
          //     const Icon(
          //       Icons.pets,
          //       color: Color(0xFF3479FD),
          //     ),
          //     '我的宠物',
          //     "foo/bar",
          //     0),
        ],
      ),
    );
  }

  Widget blockArea2() {
    return Container(
      color: Colors.white,
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
                Navigator.of(context).pushNamed("paimon_page");
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
                  Text("消费记录",
                      style: TextStyle(color: Color.fromRGBO(255, 165, 170, 1)))
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("paimon_page");
              },
            ),
          ),
          SizedBox(
            width: Global.deviceSize.width * 0.25,
            child: TextButton(
              child: Column(
                children: const [
                  Expanded(
                    child: Icon(Icons.settings,
                        color: Color.fromRGBO(255, 165, 170, 1)),
                  ),
                  Text(
                    "系统设置",
                    style: TextStyle(color: Color.fromRGBO(255, 165, 170, 1)),
                  )
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("paimon_page");
              },
            ),
          ),

          // itemCell(
          //     const Icon(
          //       Icons.bookmarks,
          //       color: Color(0xFF3479FD),
          //     ),
          //     '我的收藏',
          //     "foo/bar",
          //     0),
          // itemCell(
          //     const Icon(
          //       Icons.comment,
          //       color: Color(0xFF3479FD),
          //     ),
          //     '我的评论',
          //     "foo/bar",
          //     0),
          // itemCell(
          //     const Icon(
          //       Icons.shop_two,
          //       color: Color(0xFF3479FD),
          //     ),
          //     '消费记录',
          //     'foo/bar',
          //     0),
          // itemCell(
          //     const Icon(
          //       Icons.settings,
          //       color: Color(0xFF3479FD),
          //     ),
          //     '系统设置',
          //     'foo/bar',
          //     0),
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
