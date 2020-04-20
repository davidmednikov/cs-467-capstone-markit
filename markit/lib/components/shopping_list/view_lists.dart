import 'package:flutter/material.dart';

class ViewLists extends StatefulWidget {

  ViewLists({Key key}) : super(key: key);

  @override
  ViewListsState createState() => ViewListsState();
}

class ViewListsState extends State<ViewLists> {

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }

  void addList(BuildContext context) {
    // Navigator.of(context).pushNamed('addList');
    print(2);
  }
}