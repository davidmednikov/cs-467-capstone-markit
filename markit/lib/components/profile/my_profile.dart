import 'package:flutter/material.dart';

import '../common/page.dart';

class MyProfile extends StatelessWidget {

  var user;

  MyProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MarkitPage(
      title: 'My Profile',
      view: Placeholder(),
    );
  }
}