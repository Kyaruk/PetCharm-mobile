import 'package:pet_charm/models/post.dart';
import 'package:flutter/material.dart';
import 'package:pet_charm/models/comment.dart';
import 'package:pet_charm/http/my_http.dart';

import '../comment/comment_detail.dart';
import '../comment/post_comment.dart';
import '../main.dart';

class PostDetail extends StatefulWidget {
  final Post post;

  const PostDetail({Key? key, required this.post}) : super(key: key);

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
                    returnKeywords(),
                  ],
                ),
              ),
              FutureBuilder(
                future: getPostComments(widget.post.id),
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
                                      Expanded(
                                        child: Text(
                                          comment.commentContent,
                                          style: const TextStyle(fontSize: 16),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Global.deviceSize.width * 0.05,
                                      )
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
              TextButton(
                  onPressed: () {
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
                  },
                  child: const Text("发布评论"))
            ],
          ),
        ),
      ),
    );
  }

  Widget returnKeywords() {
    if (widget.post.keywords.isNotEmpty &&
        !(widget.post.keywords.length == 1 && widget.post.keywords[0] == "")) {
      return SizedBox(
        height: Global.deviceSize.height * 0.1,
        width: Global.deviceSize.width * 0.8,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.post.keywords.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                RawChip(label: Text(widget.post.keywords[index])),
                SizedBox(
                  width: Global.deviceSize.width * 0.03,
                ),
              ],
            );
          },
        ),
      );
    } else {
      return SizedBox(
        height: Global.deviceSize.height * 0.001,
      );
    }
  }
}
