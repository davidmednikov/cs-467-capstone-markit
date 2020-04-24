import 'package:flutter/material.dart';
import 'package:markit/components/common/navigation/navigation_options.dart';

import 'navigator.dart';

class ProfilesNavigator extends StatefulWidget {

  ProfilesNavigator({Key key}) : super(key: key);

  @override
  ProfilesNavigatorState createState() => ProfilesNavigatorState();
}

class ProfilesNavigatorState extends State<ProfilesNavigator> {

  @override
  Widget build(BuildContext context) {
    return MarkitNavigator(
      routesToPagesMap: getProfileRoutes(),
    );
  }
}