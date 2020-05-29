import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/profile/components/user_profile.dart';
import 'package:markit/components/mark_price/pages/mark_price.dart';
import 'package:markit/components/service/auth_service.dart';

class MyProfile extends StatefulWidget {

  String thisUser;
  AuthService authService = new AuthService();

  GlobalKey<DynamicFabState> dynamicFabKey;

  MyProfile({Key key, this.dynamicFabKey}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'View Profile',
      // view: FutureBuilder(
      //   future: getUserInfo(),
      //   builder: (context, snapshot) {
      //     print('userId: $snapshot.data');
      //     if (snapshot.hasData) {
      //       return UserProfile(userId: snapshot.data);
      //     } else {
      //       return CircularProgressIndicator();
      //     }
      //   }
      // )
      view: UserProfile()
    );
  }
    // return FutureBuilder(
    //   future: getUserInfo(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return UserProfile(userId: snapshot.data);
    //     } else {
    //       return CircularProgressIndicator();
    //     }
    //   }
    // );
    // return RaisedButton(
    //   onPressed: () => logout(),
    //   child: const Text('Logout', style: TextStyle(fontSize: 20)),
    // );
    // return MarkPrice();
}