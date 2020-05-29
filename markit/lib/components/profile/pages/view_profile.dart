import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/markit_user_model.dart';
import 'package:markit/components/profile/components/user_profile.dart';
import 'package:markit/components/service/auth_service.dart';

class ViewProfile extends StatefulWidget {
  AuthService authService = new AuthService();

  GlobalKey<DynamicFabState> dynamicFabKey;
  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  ViewProfile({Key key, this.dynamicFabKey, this.bottomScaffoldKey}) : super(key: key);

  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<ViewProfile> {

  MarkitUserModel user;

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;
    return TopScaffold(
      title: user == null ? 'My Profile' : 'View Profile',
      noPadding: true,
      noDropShadow: true,
      view: UserProfile(userProp: user, bottomScaffoldKey: widget.bottomScaffoldKey),
    );
  }

  void logout() {
    widget.authService.logout();
    Navigator.of(widget.dynamicFabKey.currentContext).pushReplacementNamed('auth');
  }
}