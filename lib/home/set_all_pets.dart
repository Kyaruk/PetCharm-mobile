import 'package:flutter/material.dart';
import 'package:pet_charm/home/set_to_vaccinated.dart';
import 'package:pet_charm/models/pet.dart';
import 'package:pet_charm/models/post.dart';
import 'package:http/http.dart';
import 'dart:convert';

class SetPetPage extends StatefulWidget {
  const SetPetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SetPetPage();
  }

}

class _SetPetPage extends State<SetPetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: HomeHttp().getHomePosts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            List<Pet> petTobeset = snapshot.data;

            return ListView(
              children: petTobeset.map((Pet pet) => Card(
                  child: ListTile(
                    // leading: CircleAvatar(
                    //   backgroundImage: NetworkImage(post.cover),
                    // ),
                    // title: Text(post.title),
                    title: const Text("暂时用这个代替宠物的标题"),
                    // subtitle: Text(post.author),
                    subtitle: const Text("暂时用这个代替宠物二级标题"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => VaccinationDetail(
                            pet: pet,
                          )
                      ),
                    ),
                  )
              )).toList(),
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

class HomeHttp {
  // final String postsUrl = Global.baseUrl + "test";
  final String postsUrl = "http://43.138.31.99/api/pet/";

  Future<List<Post>> getHomePosts() async {
    Response response = await get(Uri.parse(postsUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Post> news =
      body.map((dynamic item) => Post.fromJson(item)).toList();

      return news;
    } else {
      throw "Can't get posts.";
    }
  }
}