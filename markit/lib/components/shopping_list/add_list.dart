import 'package:flutter/material.dart';

import '../common/scaffold/top_scaffold.dart';

class AddList extends StatelessWidget {

  AddList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'Add List',
      view: Placeholder(),
    );
  }
}