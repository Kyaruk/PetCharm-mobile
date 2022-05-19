import 'package:flutter/material.dart';
import 'package:pet_charm/main.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: Global.deviceSize.height * 0.4,
            ),
            Image.asset("assets/images/Error.jpg"),
            SizedBox(
              height: Global.deviceSize.height * 0.1,
            ),
            const Text("您本来不应该看到这个,但我们出了一点问题，程序员正在全力抢修，您可以退出之后重新进入",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

}