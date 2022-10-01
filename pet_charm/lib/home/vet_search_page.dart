import 'package:flutter/material.dart';
import 'package:pet_charm/home/vet_detail.dart';
import 'package:pet_charm/main.dart';
import 'package:pet_charm/http/my_http.dart';
import 'package:pet_charm/models/user.dart';

class SearchVetPage extends StatefulWidget {
  const SearchVetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchVetPage();
  }
}

class _SearchVetPage extends State<SearchVetPage> {
  List<User> _vets = [];
  final List<User> _models = [];
  bool _showClear = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 84,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 44,
                  child: Row(
                    children: [
                      Container(
                        width: Global.deviceSize.width - 50,
                        height: 34,
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(240, 240, 240, 1),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/放大镜.png'),
                              width: 20,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: _onChanged,
                                cursorColor: Colors.green,
                                autofocus: true,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 5, bottom: 10),
                                  border: InputBorder.none,
                                  hintText: '搜索',
                                ),
                              ),
                            ),
                            if (_showClear)
                              GestureDetector(
                                child: const Icon(
                                  Icons.cancel,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  _searchController.clear();
                                  setState(() {
                                    _onChanged("");
                                  });
                                },
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: const Text('取消'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: getVets(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                List<User> vets = snapshot.data;
                _vets = vets;
              }
              return const Text("");
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: itemBuilder,
            itemCount: _models.length,
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return ListTile(
      tileColor: Color.fromRGBO(240, 240, 240, 1),
      title: Text(_models[index].userType),
      subtitle: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.only(right: 10),
        height: 25,
        child: Text(
          _models[index].userFirstName,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: ClipRRect(
        //剪裁为圆角矩形
        borderRadius: BorderRadius.circular(5.0),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => VetDetail(
                  user: _models[index],
                )),
      ),
    );
  }

  void _onChanged(String text) {
    _models.clear(); // 每次搜索先清空
    if (text.isNotEmpty) {
      for (int i = 0; i < _vets.length; i++) {
        String? name = _vets[i].userFirstName.toLowerCase();
        String? type = _vets[i].userType.toLowerCase();
        String? lowerText = text.toLowerCase();
        if ((name).contains(lowerText) || (type).contains(lowerText)) {
          _models.add(_vets[i]);
        }
      }
    }
    setState(() {
      _showClear = text.isNotEmpty;
    });
  }
}
