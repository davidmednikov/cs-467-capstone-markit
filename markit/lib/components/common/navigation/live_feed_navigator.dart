import 'package:flutter/material.dart';
import 'package:markit/components/common/navigation/navigation_options.dart';

import 'tab_navigator.dart';

class LiveFeedNavigator extends StatefulWidget {

  LiveFeedNavigator({Key key}) : super(key: key);

  @override
  LiveFeedNavigatorState createState() => LiveFeedNavigatorState();
}

class LiveFeedNavigatorState extends State<LiveFeedNavigator> {

  @override
  Widget build(BuildContext context) {
    return TabNavigator(
      routesToPagesMap: getLiveFeedRoutes(),
    );
  }
}