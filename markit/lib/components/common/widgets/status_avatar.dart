import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatusAvatar extends StatelessWidget {

  final int userReputation;

  StatusAvatar({Key key, this.userReputation});

  @override
  Widget build(BuildContext context) {
    if (userReputation != null) {
      if (userReputation < 25) {
        return FaIcon(FontAwesomeIcons.solidUserCircle, size: 40);
      } else if (userReputation < 100) {
        return FaIcon(FontAwesomeIcons.award, size: 36);
      } else if (userReputation < 250) {
        return FaIcon(FontAwesomeIcons.medal, size: 36);
      } else if (userReputation < 1000) {
        return FaIcon(FontAwesomeIcons.trophy, size: 36);
      }
      return FaIcon(FontAwesomeIcons.crown, size: 36);
    }
    return FaIcon(FontAwesomeIcons.solidUserCircle, size: 40);
  }
}