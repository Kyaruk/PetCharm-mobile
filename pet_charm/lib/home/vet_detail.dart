import 'package:pet_charm/home/post_vet_page.dart';
import 'package:pet_charm/home/vet_post_detail.dart';
import 'package:pet_charm/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pet_charm/http/my_http.dart';
import 'package:pet_charm/common/ffStars.dart';

import '../consultation/post_consultation.dart';
import '../main.dart';
import '../models/rating.dart';

class VetDetail extends StatefulWidget {
  final User user;

  const VetDetail({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VetDetail();
  }
}

class _VetDetail extends State<VetDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "兽医详情",
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
                    SizedBox(height: Global.deviceSize.height * 0.05),
                    GestureDetector(
                      child: SizedBox(
                        height: 115,
                        width: 115,
                        child: CircleAvatar(
                          backgroundImage: (widget.user.userIconUrl != ""
                                  ? NetworkImage(widget.user.userIconUrl)
                                  : const AssetImage("assets/images/User.jpg"))
                              as ImageProvider,
                          // backgroundImage: NetworkImage(temp.userIconUrl),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text("Vet Name"),
                      subtitle: Text(widget.user.userFirstName),
                    ),
                    ListTile(
                      title: const Text("Vet Email"),
                      subtitle: Text(widget.user.userEmail),
                    ),
                    ListTile(
                      title: const Text("Vet Phone Number"),
                      subtitle: Text(widget.user.userPhoneNumber),
                    ),
                    ListTile(
                      leading: TextButton.icon(
                        icon: const Icon(Icons.article),
                        label: const Text("发布提问"),
                        onPressed: () async {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PostConsultation(
                                  userId: widget.user.userId,
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
                future: getRatings(widget.user.userId),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<Rating> ratings = snapshot.data;
                    return Container(
                      constraints: BoxConstraints(
                          maxHeight: Global.deviceSize.height * 0.5),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: ratings.length,
                        itemBuilder: (context, index) {
                          Rating rating = ratings[index];
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
                                      backgroundImage: ((rating
                                                      .ratingByUserIconUrl ==
                                                  "")
                                              ? const AssetImage(
                                                  "assets/images/User.jpg")
                                              : NetworkImage(
                                                  rating.ratingByUserIconUrl))
                                          as ImageProvider,
                                    ),
                                    title: Text(rating.ratingByUser),
                                    subtitle: returnStars(rating.ratingScore,
                                        Global.deviceSize.width * 0.045),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => VetPostDetail(
                                                rating: rating,
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
                                          rating.ratingContent,
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
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PostVetPage(
                            userId: widget.user.userId,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text("发布评价"))
            ],
          ),
        ),
      ),
    );
  }
}
