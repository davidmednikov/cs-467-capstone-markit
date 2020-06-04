import 'package:flutter/material.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MyListsSpeedDialFab extends StatefulWidget {

  String page;
  SpeedDialController controller;
  Function onSpeedDialAction;
  Function getSpeedDialLabelWidget;

  MyListsSpeedDialFab({Key key, this.page, this.controller, this.onSpeedDialAction, this.getSpeedDialLabelWidget }) : super(key: key);

  @override
  MyListsSpeedDialFabState createState() => MyListsSpeedDialFabState();
}


class MyListsSpeedDialFabState extends State<MyListsSpeedDialFab> {

  @override
  Widget build(BuildContext context) {
    return SpeedDialFloatingActionButton(
      actions: _getMyListsIcons(),
      controller: widget.controller,
      childOnFold: Text('M', style: GoogleFonts.lato(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 40)),
      childOnUnfold: FaIcon(FontAwesomeIcons.times),
      onAction: widget.onSpeedDialAction,
      isDismissible: true,
    );
  }

  @override
  void dispose() {
    // this.dispose();
    super.dispose();
  }

  List<SpeedDialAction> _getMyListsIcons() {
    return [
      SpeedDialAction(
        child: FaIcon(FontAwesomeIcons.qrcode),
        label: widget.getSpeedDialLabelWidget('Markit'),
      ),
      SpeedDialAction(
        child: FaIcon(FontAwesomeIcons.plus),
        label: widget.getSpeedDialLabelWidget('New List'),
      ),
    ];
  }
}