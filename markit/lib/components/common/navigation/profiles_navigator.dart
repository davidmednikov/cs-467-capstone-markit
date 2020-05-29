import 'package:flutter/material.dart';

import 'package:markit/components/common/navigation/navigation_options.dart';
import 'package:markit/components/common/navigation/tab_navigator.dart';
import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/profile/pages/my_profile.dart';

class ProfilesNavigator extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;
  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  ProfilesNavigator({Key key, this.dynamicFabKey, this.bottomScaffoldKey}) : super(key: key);

  GlobalKey<MyProfileState> myProfileKey = new GlobalKey();

  @override
  ProfilesNavigatorState createState() => ProfilesNavigatorState();
}

class ProfilesNavigatorState extends State<ProfilesNavigator> {

  @override
  Widget build(BuildContext context) {
    return TabNavigator(
      routesToPagesMap: getProfileRoutes(widget.myProfileKey, widget.dynamicFabKey, widget.bottomScaffoldKey),
    );
  }
}