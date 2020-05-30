import 'package:flutter/material.dart';

import 'package:markit/components/common/navigation/navigation_options.dart';
import 'package:markit/components/common/navigation/tab_navigator.dart';
import 'package:markit/components/store/pages/view_stores.dart';

class StoresNavigator extends StatefulWidget {

  String deepLinkInitRoute;

  StoresNavigator({Key key, this.deepLinkInitRoute}) : super(key: key);

  GlobalKey<ViewStoresState> viewStoresKey = new GlobalKey();

  @override
  StoresNavigatorState createState() => StoresNavigatorState();
}

class StoresNavigatorState extends State<StoresNavigator> {

  @override
  Widget build(BuildContext context) {
    return TabNavigator(
      deepLinkInitRoute: widget.deepLinkInitRoute,
      routesToPagesMap: getStoresRoutes(widget.viewStoresKey),
    );
  }
}