import 'package:flutter/cupertino.dart';

class Testios extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Test();
  }

}

class _Test extends State<Testios> {
  final List<String> _titles = ['首页', '产品', '更多'];
  final List<Text> _pageContents = [Text('This is Home page'), Text('This is Product page'), Text('This is More page')];
  int select = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: select,
        onTap: (index) {
          setState(() {
            select = index;
          });
        },
        items: <BottomNavigationBarItem> [ //标签栏项集合
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: _titles[0],
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_dash),
            label: _titles[1]
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: _titles[2]
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) { //标签栏对应的页面创建
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoActivityIndicator();
          },
        );
      },
    );
  }

}