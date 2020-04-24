import 'package:flutter/material.dart';

import '../common/page.dart';

class LiveFeed extends StatelessWidget {

  LiveFeed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MarkitPage(
      title: 'Live Feed',
      view: Placeholder(),
    );
  }
}