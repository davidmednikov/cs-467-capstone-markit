import 'package:flutter/material.dart';
import 'package:markit/components/common/navigation/navigation_options.dart';

import 'navigator.dart';

class LiveFeedNavigator extends StatefulWidget {

  LiveFeedNavigator({Key key}) : super(key: key);

  @override
  LiveFeedNavigatorState createState() => LiveFeedNavigatorState();
}

class LiveFeedNavigatorState extends State<LiveFeedNavigator> {

  @override
  Widget build(BuildContext context) {
    return MarkitNavigator(
      routesToPagesMap: getLiveFeedRoutes(),
    );
  }
}