import 'package:flutter/material.dart';
import 'package:pet_charm/models/post.dart';
import '../main.dart';
import 'post_detail.dart';
import 'package:dio/dio.dart';

class VetPage extends StatefulWidget {
  const VetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VetPage();
  }

}

class _VetPage extends State<VetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: HomeHttp().getHomePosts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            List<Post> courses = snapshot.data;

            return ListView(
              children: courses.map((Post post) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(post.cover),
                  ),
                  title: Text(post.title),
                  subtitle: Text(post.author),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => PostDetail(
                          post: post,
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
 Future<List<Post>> getHomePosts() async {

    try{
      var response = await Global.dio.get('post/list/');

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['posts'];

        List<Post> news =
        body.map((dynamic item) => Post.fromJson(item)).toList();

        return news;
      } else {
        throw "Can't get posts.";
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }
}