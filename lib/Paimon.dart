import 'package:flutter/material.dart';

class Paimon extends StatefulWidget {
  const Paimon({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Paimon();
  }
}

class _Paimon extends State<Paimon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(250, 249, 249, 1),
        leading: IconButton(
            color: const Color.fromRGBO(0, 0, 0, 1),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
                "https://img0.baidu.com/it/u=3879918274,2005020690&fm=253&fmt=auto&app=138&f=JPG?w=492&h=682"),
            const Text(
              "前面的区域下辈子再来探索吧",
              style: TextStyle(fontSize: 28),
            )
          ],
        ),
      ),
    );
  }
}
