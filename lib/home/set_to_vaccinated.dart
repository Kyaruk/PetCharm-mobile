import 'package:pet_charm/main.dart';
import 'package:pet_charm/models/pet.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class VaccinationDetail extends StatelessWidget {
  final Pet pet;

  const VaccinationDetail({
    Key? key,
    required this.pet,
  }) : super(key: key);

  setToVaccinated(String set_state) async {
    // try {
    //   FormData formData = FormData.fromMap({"petId": pet.petId,"status":set_state});
    //   //TODO:需要更新所有的参数和url
    //   var response = await Global.dio.post('post/delete/', data: formData);
    //
    //   if (response.statusCode == 200) {
    //
    //     // Navigator.pushNamed(context, "home_page");
    //   } else {
    //     throw "Can't get posts.";
    //   }
    // } on DioError catch (e) {
    //   throw Exception(e.response?.data);
    // }

    try {
      var response = await Global.dio.post('allUnadoptedPets/');

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['pets'];

        List<Pet> pets =
            body.map((dynamic item) => Pet.fromJson(item)).toList();

        return pets;
      } else {
        throw "Can't get posts.";
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }

    // Response response = await post(Uri.parse(postsUrl));
    //
    // if (response.statusCode == 200) {
    //   // print("修改宠物医疗信息post请求发送成功");
    //   List<dynamic> body = jsonDecode(response.body);
    //
    //   List<Pet> news = body.map((dynamic item) => Pet.fromJson(item)).toList();
    //
    //   // var num = 5;
    //   // var factorial = 1;
    //   //
    //   // for( var i = 3 ; i >= 1; i-- ) {
    //   //   print(news[i]);
    //   // } //原文出自【易百教程】，商业转载请联系作者获得授权，非商业请保留原文链接：https://www.yiibai.com/dart/dart_programming_for_loop.html
    //
    //   return news;
    // } else {
    //   throw "Can't get posts.";
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "宠物医疗信息详情",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(250, 249, 249, 1),
        leading: IconButton(
            color: const Color.fromRGBO(0, 0, 0, 1),
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Increase volume by 10',
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Column(
              children: <Widget>[
                // Image.network(pet.picture), //把宠物的照片展示出来
                ListTile(
                  title: const Text("Title"),
                  subtitle: Text(pet.petName),
                ),
                ListTile(
                  title: const Text("Author-Time"),
                  subtitle: Text(pet.petType),
                ),
                ListTile(
                  title: const Text("Body"),
                  subtitle: Text(pet.petDateOfBirth.toString()),
                ),
                Card(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: setToVaccinated(""),
                        icon: const Icon(Icons.star),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
