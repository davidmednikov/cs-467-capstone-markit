import 'package:flutter/material.dart';

import 'package:markit/components/common/navigation/navigation_options.dart';
import 'package:markit/components/common/navigation/tab_navigator.dart';
import 'package:markit/components/store/pages/view_stores.dart';

class StoresNavigator extends StatefulWidget {

  StoresNavigator({Key key}) : super(key: key);

  GlobalKey<ViewStoresState> viewStoresKey = new GlobalKey();

  @override
  StoresNavigatorState createState() => StoresNavigatorState();
}

class StoresNavigatorState extends State<StoresNavigator> {

  @override
  Widget build(BuildContext context) {
    return TabNavigator(
      routesToPagesMap: getStoresRoutes(widget.viewStoresKey),
    );
  }
}