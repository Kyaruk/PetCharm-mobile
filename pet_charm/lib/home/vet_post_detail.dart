import 'package:flutter/material.dart';
import 'package:pet_charm/common/ffStars.dart';
import '../main.dart';
import '../models/rating.dart';

class VetPostDetail extends StatefulWidget {
  final Rating rating;

  const VetPostDetail({Key? key, required this.rating}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VetPostDetail();
  }
}

class _VetPostDetail extends State<VetPostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "评价详情",
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
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: ((widget.rating.ratingByUserIconUrl == "")
                            ? const AssetImage("assets/images/User.jpg")
                            : NetworkImage(widget.rating.ratingByUserIconUrl))
                        as ImageProvider,
                  ),
                  title: Text(widget.rating.ratingByUser),
                  trailing: returnStars(widget.rating.ratingScore,
                      Global.deviceSize.width * 0.055),
                ),
                ListTile(
                  title: const Text("Content"),
                  subtitle: Text(widget.rating.ratingContent),
                ),
                SizedBox(
                  height: Global.deviceSize.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
