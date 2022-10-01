import 'package:flutter/material.dart';
import 'package:pet_charm/http/my_http.dart';
import 'package:pet_charm/models/comment.dart';

import '../comment/comment_detail.dart';

class MyComments extends StatefulWidget {
  const MyComments({Key? key}) : super(key: key);

  @override
  State<MyComments> createState() {
    return _MyComments();
  }
}

class _MyComments extends State<MyComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的评论", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromRGBO(250, 249, 249, 1),
        leading: IconButton(
            color: const Color.fromRGBO(0, 0, 0, 1),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: FutureBuilder(
        future: getUserComments(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Comment> courses = snapshot.data;

            return ListView(
              children: courses
                  .map((Comment comment) => Card(
                          child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: (comment.commentIconUrl == ""
                                  ? const AssetImage("assets/images/User.jpg")
                                  : NetworkImage(comment.commentIconUrl))
                              as ImageProvider,
                        ),
                        title: Text(
                          comment.commentContent,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
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
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
