import 'package:flutter/material.dart';

class SearchFunction extends StatefulWidget {
  @override
  SearchFunctionState createState() => SearchFunctionState();
}

class SearchFunctionState extends State<SearchFunction> {
  TextEditingController searchText = TextEditingController();

  startSearch() {}

  @override
  Widget build(BuildContext centext) {
    return Scaffold(
      appBar: searchHeader(),
    );
  }

  AppBar searchHeader() {
    return AppBar(
      backgroundColor: Colors.green,
      title: TextFormField(
        controller: searchText,
        decoration: InputDecoration(
          hintText: '검색',
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              searchText.clear();
            },
          ),
        ),
        style: TextStyle(
          fontSize: 16,
        ),
        onFieldSubmitted: startSearch(),
      ),
    );
  }
}
