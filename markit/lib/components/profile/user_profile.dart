import 'package:flutter/material.dart';

import '../common/scaffold/top_scaffold.dart';

class UserProfile extends StatelessWidget {

  var user;

  UserProfile({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'View Profile',
      view: Placeholder(),
    );
  }
}