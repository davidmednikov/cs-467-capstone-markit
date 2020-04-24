import 'package:flutter/material.dart';
import 'package:markit/components/common/navigation/navigation_options.dart';

import 'navigator.dart';

class StoresNavigator extends StatefulWidget {

  StoresNavigator({Key key}) : super(key: key);

  @override
  StoresNavigatorState createState() => StoresNavigatorState();
}

class StoresNavigatorState extends State<StoresNavigator> {

  @override
  Widget build(BuildContext context) {
    return MarkitNavigator(
      routesToPagesMap: getStoresRoutes(),
    );
  }
}