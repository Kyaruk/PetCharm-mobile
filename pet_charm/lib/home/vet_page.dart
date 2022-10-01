import 'package:flutter/material.dart';
import 'package:pet_charm/models/user.dart';
import 'package:pet_charm/http/my_http.dart';
import 'package:pet_charm/common/ffStars.dart';
import '../main.dart';
import 'vet_detail.dart';

class VetPage extends StatefulWidget {
  const VetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VetPage();
  }
}

class _VetPage extends State<VetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getVets(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<User> vets = snapshot.data;

            return ListView(
              children: vets
                  .map((User vet) => Card(
                          child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: ((vet.userIconUrl == "")
                              ? const AssetImage("assets/images/User.jpg")
                              : NetworkImage(vet.userIconUrl)) as ImageProvider,
                        ),
                        title: Text(vet.userFirstName),
                        subtitle: Text(vet.userEmail),
                        trailing: returnStars(
                            vet.userScore, Global.deviceSize.width * 0.055),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => VetDetail(
                                    user: vet,
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
