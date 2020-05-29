import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/profile/components/user_profile.dart';
import 'package:markit/components/service/auth_service.dart';

class MyProfile extends StatefulWidget {
  AuthService authService = new AuthService();

  GlobalKey<DynamicFabState> dynamicFabKey;
  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  MyProfile({Key key, this.dynamicFabKey, this.bottomScaffoldKey}) : super(key: key);

  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'My Profile',
      myProfileKey: widget.key,
      noPadding: true,
      noDropShadow: true,
      view: UserProfile(bottomScaffoldKey: widget.bottomScaffoldKey),
    );
  }

  void logout() {
    widget.authService.logout();
    Navigator.of(widget.dynamicFabKey.currentContext).pushReplacementNamed('auth');
  }
}