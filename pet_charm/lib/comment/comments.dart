import 'package:flutter/material.dart';
import 'package:pet_charm/comment/post_comment.dart';
import 'package:pet_charm/models/comment.dart';
import 'comment_detail.dart';
import 'package:pet_charm/http/my_http.dart';

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
        future: getAllComments(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Comment> courses = snapshot.data;

            return ListView(
              children: courses
                  .map((Comment comment) => Card(
                          child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: ((comment.commentIconUrl == "")
                                  ? const AssetImage("assets/images/User.jpg")
                                  : NetworkImage(comment.commentIconUrl))
                              as ImageProvider,
                        ),
                        title: Text(comment.commentAuthor),
                        subtitle: Text(comment.commentDate),
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
