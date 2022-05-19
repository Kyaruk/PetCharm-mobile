import 'package:flutter/material.dart';
import 'package:pet_charm/comment/post_comment.dart';
import 'package:pet_charm/models/comment.dart';
import '../main.dart';
import '../models/comment_detail.dart';
import 'package:dio/dio.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, required this.postId}) : super(key: key);

  final int postId;

  @override
  State<StatefulWidget> createState() {
    return _CommentPage();
  }
}

class _CommentPage extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: HomeHttp(widget.postId).getHomePosts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Comment> courses = snapshot.data;

            return ListView(
              children: courses
                  .map((Comment comment) => Card(
                          child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(comment.userIconUrl),
                        ),
                        title: Text(comment.commentUserName),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CommentDetail(
                                    comment: comment,
                                  )),
                        ),
                      )))
                  .toList(),
            );
          }
          return const Center(
            child: Text("目前还没有评论"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(252, 238, 238, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PostComment(
                  postId: widget.postId,
                );
              },
            ),
          );
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
    );
  }
}

class HomeHttp {
  HomeHttp(this.postId);

  int postId;

  Future<List<Comment>> getHomePosts() async {
    try {
      FormData formData = FormData.fromMap({"postId": postId});
      var response = await Global.dio.post('comments/', data: formData);

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['posts'];

        List<Comment> comments =
            body.map((dynamic item) => Comment.fromJson(item)).toList();

        return comments;
      } else {
        throw "Can't get posts.";
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
  }
}
