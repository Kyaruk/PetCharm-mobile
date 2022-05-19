import 'package:pet_charm/models/post.dart';
import 'package:flutter/material.dart';
import 'package:pet_charm/comment/comments.dart';

class PostDetail extends StatelessWidget {
  final Post homePosts;

  const PostDetail({
    Key? key,
    required this.homePosts,
  }) : super(key: key);

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
          child: Card(
            child: Column(
              children: <Widget>[
                Image.network(homePosts.cover),
                ListTile(
                  title: const Text("Title"),
                  subtitle: Text(homePosts.title),
                ),
                ListTile(
                  title: const Text("Author-Time"),
                  subtitle: Text(homePosts.author + "-" + homePosts.date),
                ),
                ListTile(
                  title: const Text("Body"),
                  subtitle: Text(homePosts.content),
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
                              postId: homePosts.id,
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
        ),
      ),
    );
  }
}
