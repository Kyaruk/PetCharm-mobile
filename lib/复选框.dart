import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Test();
  }
}

class _Test extends State<Test> {

  var selectItemValue;

  List<DropdownMenuItem<String>> generateItemList() {
    final List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    const DropdownMenuItem<String> item1 = DropdownMenuItem(child: Text('One'), value: 'One');
    const DropdownMenuItem<String> item2 = DropdownMenuItem(child: Text('Two'), value: 'Two');
    const DropdownMenuItem<String> item3 = DropdownMenuItem(child: Text('Three'), value: 'Three');
    const DropdownMenuItem<String> item4 = DropdownMenuItem(child: Text('Four'), value: 'Four');
    const DropdownMenuItem<String> item5 = DropdownMenuItem(child: Text('Five'), value: 'Five');
    items.add(item1);
    items.add(item2);
    items.add(item3);
    items.add(item4);
    items.add(item5);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: const Color.fromRGBO(252, 238, 238, 1),
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(10))),
          child: DropdownButton<String>(
            hint: const Text("Test"),
            underline: Container(height: 0,),
            items: generateItemList(),
            onChanged: (var value) {
              setState(() {
                selectItemValue = value;
              });
            },
            value: selectItemValue,
          ),
        ),
      ),
    );
  }
}


