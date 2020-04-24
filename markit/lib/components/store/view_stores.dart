import 'package:flutter/material.dart';

import '../common/scaffold/top_scaffold.dart';

class ViewStores extends StatelessWidget {

  ViewStores({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'View Stores',
      view: Placeholder(),
    );
  }
}