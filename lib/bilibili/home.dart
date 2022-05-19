import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_charm/bilibili/unadopted.dart';
import '../common/toast.dart';
import '../main.dart';
import 'constants.dart';
import 'pet.dart';
import 'pet_card_widget.dart';
import 'package:http/http.dart';
import 'category.dart';
import 'category_card_widget.dart';
import 'dart:io';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

import '../common/toast.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:pet_charm/models/post.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:pet_charm/models/post.dart';
import 'package:http/http.dart';
import 'dart:convert';

///报错，先注释掉了

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(); // 实现抽象方法 createState
}

class _HomePageState extends State<MyHomePage> {
  // List<Pet> petlistlocal = [];

  // final String postsUrl =
  //     "http://43.138.31.99/api/allUnadoptedPets/";
  //
  // getHomePosts() async {
  //   FormData formData = FormData.fromMap({
  //     "unadopted_para":"1"
  //   });
  //   var response = await Global.dio.post(
  //       'getAllUnadoptedPets/',
  //       data: formData
  //   );
  //   if(response.statusCode == 200){
  //     if (response.data["success"]) {
  //
  //       ///输出当前cookie
  //       // Global.globalUser.userId = "${_userNameController.text}";
  //
  //       toast("Welcome Back");
  //       Navigator.pushNamed(context, "home_page");
  //     } else {
  //       toast("Wrong Password, Try Again");
  //     }
  //   }
  //   else {
  //     // print("ERROR:\nhttp请求出现错误，错误编码为:" + response.statusCode.toString());
  //     toast("Http Error: " + response.statusCode.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.alignCenter,
            color: kPrimaryColor,
          ),
          onPressed: () {},
        ),
        title: Column(
          children: [
            Text("Location", style: kSubtitle2Style.copyWith(fontSize: 17.0)),
            SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, color: kPrimaryColor),
                    const SizedBox(width: 12.0),
                    RichText(
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        text: const TextSpan(children: [
                          TextSpan(text: "JAck, ", style: kTitleStyle),
                          TextSpan(text: "ID, ", style: kSubtitleStyle),
                        ]))
                  ],
                ))
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              radius: 23.0,
              backgroundColor: Color.fromRGBO(255,165,170,1),
              // backgroundImage: AssetImage("assets/DouDou.jpg"),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),

      // body: Container(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         Container(
      //           width: double.infinity,
      //           height: 50.0,
      //           color: Colors.white,
      //         ),
      //         Container(
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(25.0),
      //               topRight: Radius.circular(25.0),
      //             ),
      //             color: Colors.grey[100],
      //           ),
      //           child: Column(
      //             children: [
      //               SizedBox(height: 25.0),
      //               Container(
      //                   width: double.infinity,
      //                   height: 50.0,
      //                   margin: EdgeInsets.symmetric(horizontal: 18.0),
      //                   padding: EdgeInsets.symmetric(horizontal: 12.0),
      //                   decoration: BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.circular(12.0),
      //                   ),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Icon(FontAwesomeIcons.search, color: kText2Color),
      //                       SizedBox(width: 12.0),
      //                       Expanded(
      //                           child: TextField(decoration: InputDecoration(
      //                             hintText: "Search pet to adopt",
      //                             border: InputBorder.none,
      //                             hintStyle: kSubtitleStyle,
      //                           ),)
      //                       ),
      //                       Icon(FontAwesomeIcons.slidersH,
      //                           color: kText2Color),
      //
      //                     ],
      //                   )
      //
      //
      //               ),
      //               SizedBox(height: 25.0),
      //               Container(
      //                 width: double.infinity,
      //                 height: 120.0,
      //                 child: ListView.builder(
      //                   itemCount: categoryList.length,
      //                   scrollDirection: Axis.horizontal,
      //                   shrinkWrap: true,
      //                   itemBuilder: (context, index) {
      //                     var category = categoryList[index];
      //                     return CategoryCardWidget(category: category);
      //                   },
      //                 ),
      //               ),
      //               ListView.builder(
      //                 itemCount: petList.length,
      //                 scrollDirection: Axis.vertical,
      //                 shrinkWrap: true,
      //                 physics: ScrollPhysics(),
      //                 itemBuilder: (context, index) {
      //                   var pet = petList[index];
      //                   return PetCardWidget(pet: pet);
      //                 },
      //
      //               )
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // )

      body: FutureBuilder(
        future: HomeHttp().getHomePets(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
    // if (1==1) {
            List<Pet> petlistlocal = snapshot.data;
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      color: Colors.white,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                        color: Colors.grey[100],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 25.0),
                          Container(
                              width: double.infinity,
                              height: 50.0,
                              margin: EdgeInsets.symmetric(horizontal: 18.0),
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(FontAwesomeIcons.search,
                                      color: kText2Color),
                                  SizedBox(width: 12.0),
                                  Expanded(
                                      child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Search pet to adopt",
                                      border: InputBorder.none,
                                      hintStyle: kSubtitleStyle,
                                    ),
                                  )),
                                  Icon(FontAwesomeIcons.slidersH,
                                      color: kText2Color),
                                ],
                              )),
                          const SizedBox(height: 25.0),
                          SizedBox(
                            width: double.infinity,
                            height: 120.0,
                            child: ListView.builder(
                              itemCount: categoryList.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var category = categoryList[index];
                                return CategoryCardWidget(category: category);
                              },
                            ),
                          ),
                          ListView.builder(
                            itemCount: petlistlocal.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              var pet = petlistlocal[index];
                              return PetCardWidget(pet: pet);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


// class HomeHttp {
//   // final String postsUrl = Global.baseUrl + "test";
//   final String postsUrl = "http://43.138.31.99/api/getAllUnadoptedPets/";
//
//   Future<List<Pet>> getHomePosts() async {
//     Response response = await get(Uri.parse(postsUrl));
//
//     if (response.statusCode == 200) {
//       List<dynamic> body = jsonDecode(response.body);
//
//       List<Pet> news = [];
//       // PetS pets = body.map((dynamic item) => PetS.fromJson(item)).toList();
//
//       return news;
//     } else {
//       throw "Can't get posts.";
//     }
//   }
// }

class HomeHttp {
  // final String postsUrl = Global.baseUrl + "test";
  final String postsUrl = "http://43.138.31.99/api/getAllUnadoptedPets/";

  Future<List<Pet>> getHomePets() async {
    Response response = await get(Uri.parse(postsUrl));

    if (response.statusCode == 200) {
      print("请求未领养宠物成功");
      List<dynamic> body = jsonDecode(response.body)["pets"];

      List<Pet> news =
      body.map((dynamic item) => Pet.fromJson(item)).toList();

      var num = 5;
      var factorial = 1;

      for( var i = 3 ; i >= 1; i-- ) {
        print(news[i]);
      } //原文出自【易百教程】，商业转载请联系作者获得授权，非商业请保留原文链接：https://www.yiibai.com/dart/dart_programming_for_loop.html



      return news;
    } else {
      throw "Can't get posts.";
    }
  }
}