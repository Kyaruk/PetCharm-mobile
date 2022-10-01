import 'package:flutter/material.dart';
import 'package:pet_charm/consultation/consultation_detail.dart';
import 'package:pet_charm/http/my_http.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import '../models/consultation.dart';

class MyConsultation extends StatefulWidget {
  const MyConsultation({Key? key}) : super(key: key);

  @override
  State<MyConsultation> createState() {
    return _MyConsultation();
  }
}

class _MyConsultation extends State<MyConsultation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的咨询", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromRGBO(250, 249, 249, 1),
        leading: IconButton(
            color: const Color.fromRGBO(0, 0, 0, 1),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: FutureBuilder(
        future: getAllConsultation(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Consultation> consultations = snapshot.data;
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2.0,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 0,
                ),
                itemCount: consultations.length,
                itemBuilder: (context, index) {
                  Consultation consultation = consultations[index];

                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ConsultationDetail(
                                consultation: consultation,
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
                                child: Image.network(
                                    consultation.consultationCover,
                                    fit: BoxFit.fill),
                              ),
                            ),
                            ListTile(
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              title: Text(
                                consultation.consultationTitle,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // subtitle: Text(post.author + "-" + post.date),
                              subtitle: Text(consultation.consultationUser2 +
                                  " " +
                                  DateFormat("yyyy-MM-dd")
                                      .format(consultation.consultationDate)
                                      .toString()),
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
