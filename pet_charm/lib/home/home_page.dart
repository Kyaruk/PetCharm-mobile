import 'package:flutter/material.dart';
import 'package:pet_charm/home/post_detail.dart';
import 'package:pet_charm/main.dart';
import 'package:pet_charm/models/post.dart';
import 'package:pet_charm/http/my_http.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  // final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        future: getAllPosts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data;
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2.0,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 0,
                ),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Post post = posts[index];

                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PostDetail(
                                post: post,
                              )),
                    ),
                    child: Container(
                      padding: (index % 2 == 0)
                          ? EdgeInsets.only(
                              left: Global.deviceSize.width * 0.015,
                              right: Global.deviceSize.width * 0.015)
                          : EdgeInsets.only(
                              right: Global.deviceSize.width * 0.015),
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
