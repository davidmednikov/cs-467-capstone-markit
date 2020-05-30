import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatusIcon extends StatelessWidget {

  final int userReputation;

  StatusIcon({Key key, this.userReputation});

  @override
  Widget build(BuildContext context) {
    if (userReputation != null) {
      if (userReputation < 10) {
        return FaIcon(FontAwesomeIcons.award, color: Colors.deepOrange, size: 14);
      } else if (userReputation < 25) {
        return FaIcon(FontAwesomeIcons.medal, color: Colors.deepOrange, size: 14);
      } else if (userReputation < 50) {
        return FaIcon(FontAwesomeIcons.trophy, color: Colors.deepOrange, size: 14);
      }
      return FaIcon(FontAwesomeIcons.crown, color: Colors.deepOrange, size: 14);
    }
    return FaIcon(FontAwesomeIcons.user, color: Colors.deepOrange, size: 14);
  }
}