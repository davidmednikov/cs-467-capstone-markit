import 'package:flutter/material.dart';

import 'package:markit/components/common/navigation/navigation_options.dart';
import 'package:markit/components/common/navigation/tab_navigator.dart';
import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/live_feed/pages/live_feed.dart';

class LiveFeedNavigator extends StatefulWidget {

  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  LiveFeedNavigator({Key key, this.bottomScaffoldKey}) : super(key: key);

  GlobalKey<LiveFeedState> liveFeedKey = new GlobalKey();

  @override
  LiveFeedNavigatorState createState() => LiveFeedNavigatorState();
}

class LiveFeedNavigatorState extends State<LiveFeedNavigator> {

  @override
  Widget build(BuildContext context) {
    return TabNavigator(
      routesToPagesMap: getLiveFeedRoutes(widget.liveFeedKey, widget.bottomScaffoldKey),
    );
  }
}