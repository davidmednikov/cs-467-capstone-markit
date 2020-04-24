import 'package:flutter/material.dart';

import '../common/scaffold/top_scaffold.dart';

class LiveFeed extends StatelessWidget {

  LiveFeed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'Live Feed',
      view: Placeholder(),
    );
  }
}