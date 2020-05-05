import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/markit_app_bar.dart';

class TopScaffold extends StatelessWidget {

  String title;

  Widget view;

  TopScaffold({Key key, this.title, this.view }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MarkitAppBar(
        titleProp: title,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: view,
        ),
      ),
    );
  }
}