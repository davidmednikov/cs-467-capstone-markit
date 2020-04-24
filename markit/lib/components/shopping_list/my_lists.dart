import 'package:flutter/material.dart';

import '../common/page.dart';

class MyLists extends StatefulWidget {

  MyLists({Key key}) : super(key: key);

  @override
  MyListsState createState() => MyListsState();
}

class MyListsState extends State<MyLists> {

  @override
  Widget build(BuildContext context) {
    return MarkitPage(
      title: 'My Lists',
      view: Placeholder(),
    );
  }
}