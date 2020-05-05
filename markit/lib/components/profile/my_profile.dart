import 'package:flutter/material.dart';

import 'package:markit/components/profile/user_profile.dart';

class MyProfile extends StatelessWidget {

  var thisUser;

  MyProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserProfile(
     user: thisUser,
    );
  }
}