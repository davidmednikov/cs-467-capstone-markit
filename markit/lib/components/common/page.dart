import 'package:flutter/material.dart';

import 'scaffold/top_scaffold.dart';

class MarkitPage extends StatefulWidget {

  String title;

  Widget view;

  MarkitPage({Key key, this.title, this.view}) : super(key: key);

  @override
  MarkitPageState createState() => MarkitPageState();
}

class MarkitPageState extends State<MarkitPage> {

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: widget.title,
      view: widget.view,
    );
  }

  void navigate(String route) {
    Navigator.of(context).pushNamed(route);
  }
}