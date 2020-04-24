import 'package:flutter/material.dart';

import '../common/page.dart';

class AddList extends StatelessWidget {

  AddList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MarkitPage(
      title: 'Add List',
      view: Placeholder(),
    );
  }
}