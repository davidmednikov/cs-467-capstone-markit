import 'package:flutter/material.dart';

import 'package:markit/components/common/navigation/navigation_options.dart';
import 'package:markit/components/common/navigation/tab_navigator.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';

class ProfilesNavigator extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;

  ProfilesNavigator({Key key, this.dynamicFabKey}) : super(key: key);

  @override
  ProfilesNavigatorState createState() => ProfilesNavigatorState();
}

class ProfilesNavigatorState extends State<ProfilesNavigator> {

  @override
  Widget build(BuildContext context) {
    return TabNavigator(
      routesToPagesMap: getProfileRoutes(widget.dynamicFabKey),
    );
  }
}