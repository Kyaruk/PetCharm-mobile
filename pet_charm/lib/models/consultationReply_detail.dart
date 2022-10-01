import 'package:pet_charm/consultation/post_consultationReply.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/consultationReply.dart';

class ConsultationReplyDetail extends StatefulWidget {
  final ConsultationReply consultationReply;
  final int consultationId;

  const ConsultationReplyDetail(
      {Key? key, required this.consultationReply, required this.consultationId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ConsultationReplyDetail();
  }
}

class _ConsultationReplyDetail extends State<ConsultationReplyDetail> {
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
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: ((widget.consultationReply
                                        .consultationReplyUserIconUrl ==
                                    "")
                                ? const AssetImage("assets/images/User.jpg")
                                : NetworkImage(widget.consultationReply
                                    .consultationReplyUserIconUrl))
                            as ImageProvider,
                      ),
                      title: const Text("Vet-Time"),
                      subtitle: Text(
                          widget.consultationReply.consultationReplyUser +
                              "-" +
                              DateFormat("yyyy-MM-dd")
                                  .format(widget
                                      .consultationReply.consultationReplyDate)
                                  .toString()),
                    ),
                    ListTile(
                      title: const Text("Content"),
                      subtitle: Text(
                          widget.consultationReply.consultationReplyContent),
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PostConsultationReply(
                            consultationId: widget.consultationId,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text("回复"))
            ],
          ),
        ),
      ),
    );
  }
}
