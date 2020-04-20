import 'package:flutter/material.dart';

class ViewList extends StatefulWidget {

  ViewList({Key key}) : super(key: key);

  @override
  ViewListState createState() => ViewListState();
}

class ViewListState extends State<ViewList> {

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }

  void addTag() {
    // Navigator.of(context).pushNamed('addTag');
    print(3);
  }
}