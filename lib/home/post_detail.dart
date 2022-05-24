import 'package:pet_charm/models/post.dart';
import 'package:flutter/material.dart';
import 'package:pet_charm/comment/comments.dart';
import 'package:pet_charm/models/comment.dart';
import 'package:dio/dio.dart';

import '../comment/comment_detail.dart';
import '../comment/post_comment.dart';
import '../main.dart';

class PostDetail extends StatefulWidget {
  final Post post;
  final HomeHttp homeHttp = HomeHttp();

  PostDetail({Key? key, required this.post}) : super(key: key);

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
                    Image.network(widget.post.cover),
                    ListTile(
                      title: const Text("Title"),
                      subtitle: Text(widget.post.title),
                    ),
                    ListTile(
                      title: const Text("Author-Time"),
                      subtitle:
                          Text(widget.post.author + "-" + widget.post.date),
                    ),
                    ListTile(
                      title: const Text("Body"),
                      subtitle: Text(widget.post.content),
                    ),
                    ListTile(
                      leading: TextButton.icon(
                        icon: const Icon(Icons.article),
                        label: const Text("评论"),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CommentPage(
                                  postId: widget.post.id,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: widget.homeHttp.getPostComment(widget.post.id),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<Comment> comments = snapshot.data;
                    return Container(
                      constraints: BoxConstraints(
                          maxHeight: Global.deviceSize.height * 0.5),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          Comment comment = comments[index];
                          return Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0))),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          ((comment.commentIconUrl == "")
                                                  ? const AssetImage(
                                                      "assets/images/User.jpg")
                                                  : NetworkImage(
                                                      comment.commentIconUrl))
                                              as ImageProvider,
                                    ),
                                    title: Text(comment.commentAuthor),
                                    subtitle: Text(comment.commentDate),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => CommentDetail(
                                                comment: comment,
                                              )),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Global.deviceSize.width * 0.185,
                                      ),
                                      Text(comment.commentContent,
                                      style: const TextStyle(
                                        fontSize: 16
                                      ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Global.deviceSize.height * 0.015,
                                  ),
                                ],
                              ));
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PostComment(
                        postId: widget.post.id,
                      );
                    },
                  ),
                );
              }, child: const Text("发布评论"))
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHttp {
  Future<List<Comment>> getPostComment(int postId) async {
    try {
      // FormData formData = FormData.fromMap({"postId": postId});
      // var response = await Global.dio.post('comment/list/', data: formData);

      Map<String, dynamic> map = <String, dynamic>{};
      map["postId"] = postId;
      var response =
          await Global.dio.get("comment/list/", queryParameters: map);

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['comments'];

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
