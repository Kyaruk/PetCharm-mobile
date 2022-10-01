import 'package:flutter/material.dart';
import 'package:pet_charm/models/pet.dart';
import 'package:pet_charm/models/post.dart';
import 'package:pet_charm/main.dart';
import 'package:dio/dio.dart';
import 'package:pet_charm/home/post_detail.dart';

import '../common/toast.dart';

class SearchPetPage extends StatefulWidget {
  const SearchPetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchPetPage();
  }
}

class _SearchPetPage extends State<SearchPetPage> {
  List<Pet> _pets = [];
  final List<Pet> _models = [];
  final HomeHttp homeHttp = HomeHttp();
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
            future: homeHttp.getHomePets(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                List<Pet> pets = snapshot.data;
                _pets = pets;
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
      title: Text(_models[index].petName),
      subtitle: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.only(right: 10),
        height: 25,
        child: Text(
          _models[index].petType + '       ' + _models[index].petBreed,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      leading: ClipRRect(
        //剪裁为圆角矩形
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  void _onChanged(String text) {
    _models.clear(); // 每次搜索先清空
    if (text.isNotEmpty) {
      for (int i = 0; i < _pets.length; i++) {
        String? name = _pets[i].petName.toLowerCase();
        String? type = _pets[i].petType.toLowerCase();
        String? breed = _pets[i].petBreed.toLowerCase();
        text = text.toLowerCase();
        if ((type).contains(text) || (breed).contains(text) || (name).contains(text)) {
          _models.add(_pets[i]);
        }
      }
    }
    setState(() {
      _showClear = text.isNotEmpty;
    });
  }
}

class HomeHttp {
  Future<List<Pet>> getHomePets() async {
    try {
      var response = await Global.dio.get('pet/unadopted/');

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['pets'];

        List<Pet> news =
            body.map((dynamic item) => Pet.fromJson(item)).toList();

        return news;
      } else {
        throw "Can't get pets.";
      }
    } on DioError catch (e) {
      toast("请检查您的网络情况并稍后重试");
      throw Exception(e.response?.data);
    }
  }
}
