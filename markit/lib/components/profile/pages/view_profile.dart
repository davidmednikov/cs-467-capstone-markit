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

  MarkitUserModel userArg;

  ViewProfile({Key key, this.dynamicFabKey, this.bottomScaffoldKey, this.userArg}) : super(key: key);

  @override
  ViewProfileState createState() => ViewProfileState();
}

class ViewProfileState extends State<ViewProfile> {

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'View Profile',
      noPadding: true,
      noDropShadow: true,
      view: UserProfile(userProp: widget.userArg, bottomScaffoldKey: widget.bottomScaffoldKey),
    );
  }

  void logout() {
    widget.authService.logout();
    Navigator.of(widget.dynamicFabKey.currentContext).pushReplacementNamed('auth');
  }
}