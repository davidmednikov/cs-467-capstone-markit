import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatusIcon extends StatelessWidget {

  final int userReputation;

  StatusIcon({Key key, this.userReputation});

  @override
  Widget build(BuildContext context) {
    if (userReputation != null) {
      if (userReputation < 25) {
        return FaIcon(FontAwesomeIcons.solidUserCircle, color: Colors.deepOrange, size: 14);
      } else if (userReputation < 100) {
        return FaIcon(FontAwesomeIcons.award, color: Colors.deepOrange, size: 14);
      } else if (userReputation < 250) {
        return FaIcon(FontAwesomeIcons.medal, color: Colors.deepOrange, size: 14);
      } else if (userReputation < 1000) {
        return FaIcon(FontAwesomeIcons.trophy, color: Colors.deepOrange, size: 14);
      } else if (userReputation < 5000) {
        return FaIcon(FontAwesomeIcons.chessQueen, color: Colors.deepOrange, size: 14);
      }
      return FaIcon(FontAwesomeIcons.crown, color: Colors.deepOrange, size: 14);
    }
    return FaIcon(FontAwesomeIcons.solidUserCircle, color: Colors.deepOrange, size: 14);
  }
}