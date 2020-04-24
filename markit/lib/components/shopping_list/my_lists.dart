import 'package:flutter/material.dart';

import '../common/scaffold/top_scaffold.dart';

class MyLists extends StatefulWidget {

  MyLists({Key key}) : super(key: key);

  @override
  MyListsState createState() => MyListsState();
}

class MyListsState extends State<MyLists> {

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'My Lists',
      view: Placeholder(),
    );
  }
}