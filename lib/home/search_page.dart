import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextFormField(
        controller: _searchController,
      ),
    );
  }

}