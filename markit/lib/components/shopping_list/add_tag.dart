import 'package:flutter/material.dart';

import '../common/page.dart';

class AddTag extends StatelessWidget {

  AddTag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return MarkitPage(
      title: 'Add Tag',
      view: Placeholder(),
    );
  }
}