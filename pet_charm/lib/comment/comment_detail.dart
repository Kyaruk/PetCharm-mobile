import 'package:pet_charm/models/comment.dart';
import 'package:flutter/material.dart';

class CommentDetail extends StatelessWidget {
  final Comment comment;

  const CommentDetail({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "评论详情",
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
                returnPic(),
                ListTile(
                  title: const Text("Comment User"),
                  subtitle: Text(comment.commentAuthor),
                ),
                ListTile(
                  title: const Text("Body"),
                  subtitle: Text(comment.commentContent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget returnPic() {
    if(comment.commentIconUrl == "") {
      return Image.asset("assets/images/User.jpg");
    }
    return Image.network(comment.commentIconUrl);
  }
}
