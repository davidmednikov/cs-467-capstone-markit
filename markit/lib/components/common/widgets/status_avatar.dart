import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatusAvatar extends StatelessWidget {

  final int userReputation;

  StatusAvatar({Key key, this.userReputation});

  @override
  Widget build(BuildContext context) {
    if (userReputation != null) {
      if (userReputation < 10) {
        return FaIcon(FontAwesomeIcons.award, size: 36);
      } else if (userReputation < 25) {
        return FaIcon(FontAwesomeIcons.medal, size: 36);
      } else if (userReputation < 50) {
        return FaIcon(FontAwesomeIcons.trophy, size: 36);
      }
      return FaIcon(FontAwesomeIcons.crown, size: 36);
    }
    return FaIcon(FontAwesomeIcons.user, size: 36);
  }
}