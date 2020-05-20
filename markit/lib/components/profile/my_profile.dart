import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
// import 'package:markit/components/profile/user_profile.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/mark_price/pages/mark_price.dart';

class MyProfile extends StatefulWidget {

  var thisUser;

  GlobalKey<DynamicFabState> dynamicFabKey;

  MyProfile({Key key, this.dynamicFabKey}) : super(key: key);

  AuthService authService = new AuthService();

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    // return UserProfile(
    //  user: thisUser,
    // );
    // return RaisedButton(
    //   onPressed: () => logout(),
    //   child: const Text('Logout', style: TextStyle(fontSize: 20)),
    // );
    return MarkPrice();
  }

  void logout() {
    widget.authService.logout();
    Navigator.of(widget.dynamicFabKey.currentContext).pushReplacementNamed('auth');
  }
}