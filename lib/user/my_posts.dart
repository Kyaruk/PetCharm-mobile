import 'package:flutter/material.dart';
import 'package:pet_charm/user/my_post_detail.dart';
import 'package:pet_charm/models/post.dart';
import 'package:dio/dio.dart';

import '../main.dart';

class MyPostPage extends StatefulWidget {
  const MyPostPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyPostPage();
  }
}

class _MyPostPage extends State<MyPostPage> {
  // final TextEditingController _search = TextEditingController();
  final HomeHttp homeHttp = HomeHttp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "我的帖子",
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(252, 238, 238, 1),
        onPressed: () {
          Navigator.pushNamed(context, "post_page");
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add,
                color: Color.fromRGBO(208, 59, 51, 1.0),
              )
            ]),
      ),
      body: FutureBuilder(
        future: homeHttp.getHomePosts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data;
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2.0,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 2.0,
                ),
                itemCount: posts.length,
                itemBuilder: (context, pos) {
                  Post post = posts[pos];

                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PostDetail(
                                homePosts: post,
                              )),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child:
                                  Image.network(post.cover, fit: BoxFit.fill),
                            ),
                          ),
                          ListTile(
                            trailing: const Icon(Icons.keyboard_arrow_right),
                            title: Text(post.title),
                            // subtitle: Text(post.author + "-" + post.date),
                            subtitle: Text(post.author),
                          ),
                        ],
                      ),
                    ),
                  );
                });
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
    try {
      var response = await Global.dio.get('post/user/');

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
