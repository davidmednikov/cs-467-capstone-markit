import 'package:flutter/material.dart';

import '../../common/scaffold/top_scaffold.dart';

class AddTag extends StatelessWidget {

  AddTag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return TopScaffold(
      title: 'Add Tag',
      view: Placeholder(),
    );
  }
}