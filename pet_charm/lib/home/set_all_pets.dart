import 'package:flutter/material.dart';
import 'package:pet_charm/home/set_to_vaccinated.dart';
import 'package:pet_charm/models/pet.dart';
import 'package:pet_charm/models/post.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../common/toast.dart';
import '../main.dart';
import 'package:dio/dio.dart';

class SetPetPage extends StatefulWidget {
  const SetPetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SetPetPage();
  }
}

class _SetPetPage extends State<SetPetPage> {
  Future<List<Pet>> getHomePets() async {
    try {
      var response = await Global.dio.get('pet/list/');

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['pets'];

        List<Pet> pets =
            body.map((dynamic item) => Pet.fromJson(item)).toList();

        return pets;
      } else {
        throw "Can't get posts.";
      }
    } on DioError catch (e) {
      toast("请检查您的网络情况并稍后重试");
      throw Exception(e.response?.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getHomePets(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Pet> petTobeset = snapshot.data;

            return ListView(
              children: petTobeset
                  .map((Pet pet) => Card(
                          child: ListTile(
                        // leading: CircleAvatar(
                        //   backgroundImage: NetworkImage(post.cover),
                        // ),
                        // title: Text(post.title),
                        title: Text(pet.petName),
                        // subtitle: Text(post.author),
                        subtitle: Text(pet.petType),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => VaccinationDetail(
                                    pet: pet,
                                  )),
                        ),
                      )))
                  .toList(),
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
//   final String postsUrl = "http://43.138.31.99/api/pet/list";
//
//   Future<List<Pet>> getHomePets() async {
//     try{
//       var response = await Global.dio.get('pet/list/');
//
//       if (response.statusCode == 200) {
//         List<dynamic> body = response.data['pets'];
//
//         List<Pet> pets =
//         body.map((dynamic item) => Pet.fromJson(item)).toList();
//
//         return pets;
//       } else {
//         throw "Can't get posts.";
//       }
//     } on DioError catch (e) {
//       throw Exception(e.response?.data);
//     }
//   }
// }
