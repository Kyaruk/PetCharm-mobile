import 'package:pet_charm/consultation/post_consultationReply.dart';
import 'package:pet_charm/models/consultation.dart';
import 'package:flutter/material.dart';
import 'package:pet_charm/http/my_http.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../models/consultationReply.dart';
import '../models/consultationReply_detail.dart';

class ConsultationDetail extends StatefulWidget {
  final Consultation consultation;

  const ConsultationDetail({Key? key, required this.consultation})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ConsultationDetail();
  }
}

class _ConsultationDetail extends State<ConsultationDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "咨询详情",
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
                    Image.network(widget.consultation.consultationCover),
                    ListTile(
                      title: const Text("Title"),
                      subtitle: Text(widget.consultation.consultationTitle),
                    ),
                    ListTile(
                      title: const Text("Vet-Time"),
                      subtitle: Text(widget.consultation.consultationUser2 +
                          "-" +
                          DateFormat("yyyy-MM-dd")
                              .format(widget.consultation.consultationDate)
                              .toString()),
                    ),
                    ListTile(
                      title: const Text("Content"),
                      subtitle: Text(widget.consultation.consultationContent),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future:
                    getConsultationReplies(widget.consultation.consultationId),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<ConsultationReply> consultationReplies = snapshot.data;
                    return Container(
                      constraints: BoxConstraints(
                          maxHeight: Global.deviceSize.height * 0.5),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: consultationReplies.length,
                        itemBuilder: (context, index) {
                          ConsultationReply consultationReply =
                              consultationReplies[index];
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
                                      backgroundImage: ((consultationReply
                                                      .consultationReplyUserIconUrl ==
                                                  "")
                                              ? const AssetImage(
                                                  "assets/images/User.jpg")
                                              : NetworkImage(consultationReply
                                                  .consultationReplyUserIconUrl))
                                          as ImageProvider,
                                    ),
                                    title: Text(consultationReply
                                        .consultationReplyUser),
                                    subtitle: Text(DateFormat("yyyy-MM-dd")
                                        .format(consultationReply
                                            .consultationReplyDate)
                                        .toString()),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConsultationReplyDetail(
                                                consultationReply:
                                                    consultationReply,
                                                consultationId: widget.consultation.consultationId,
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
                                          consultationReply
                                              .consultationReplyContent,
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
                          return PostConsultationReply(
                            consultationId: widget.consultation.consultationId,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text("发布回复"))
            ],
          ),
        ),
      ),
    );
  }
}
