import 'package:flutter/material.dart';

import '../common/page.dart';

class ViewStores extends StatelessWidget {

  ViewStores({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MarkitPage(
      title: 'View Stores',
      view: Placeholder(),
    );
  }
}