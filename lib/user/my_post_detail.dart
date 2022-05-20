import 'package:pet_charm/models/post.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../main.dart';

class PostDetail extends StatefulWidget {
  final Post homePosts;
  final HomeHttp homeHttp = HomeHttp();

  PostDetail({Key? key, required this.homePosts}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PostDetail();
  }
}

class _PostDetail extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "资讯详情",
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
          child: Column(
            children: [
              Card(
                child: Column(
                  children: <Widget>[
                    Image.network(widget.homePosts.cover),
                    ListTile(
                      title: const Text("Title"),
                      subtitle: Text(widget.homePosts.title),
                    ),
                    ListTile(
                      title: const Text("Author-Time"),
                      subtitle: Text(widget.homePosts.author +
                          "-" +
                          widget.homePosts.date),
                    ),
                    ListTile(
                      title: const Text("Body"),
                      subtitle: Text(widget.homePosts.content),
                    ),
                    ListTile(
                      // leading: TextButton.icon(
                      //   icon: const Icon(Icons.article),
                      //   label: const Text("评论"),
                      //   onPressed: () async {
                      //     var result = await Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) {
                      //           return CommentPage(
                      //             postId: homePosts.id,
                      //           );
                      //         },
                      //       ),
                      //     );
                      //   },
                      // ),
                      trailing: TextButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text("删除"),
                        onPressed: () {
                          deletePost(widget.homePosts.id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: Global.deviceSize.height * 0.5,
                  child: FutureBuilder(
                    future: widget.homeHttp.getPostComment(widget.homePosts.id),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        List<Post> posts = snapshot.data;
                        return ListView(
                          children: posts
                              .map((Post post) => Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0),
                                          bottomLeft: Radius.circular(15.0),
                                          bottomRight: Radius.circular(15.0))),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(post.cover),
                                    ),
                                    title: Text(post.title),
                                    subtitle: Text(post.author),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => PostDetail(
                                                homePosts: post,
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
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void deletePost(int postId) {
    _deletePost(postId);
  }

  _deletePost(int postId) async {
    try {
      FormData formData = FormData.fromMap({"postId": postId});
      var response = await Global.dio.post('post/delete/', data: formData);

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
      } else {
        throw "Can't get posts.";
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }
}

class HomeHttp {
  Future<List<Post>> getPostComment(int postId) async {
    try {
      // FormData formData = FormData.fromMap({"postId": postId});
      // var response = await Global.dio.post('comment/list/', data: formData);

      Map<String, dynamic> map = <String, dynamic>{};
      map["postId"] = postId;
      var response = await Global.dio.get("comment/list/", queryParameters: map);

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['comments'];

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
