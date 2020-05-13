import 'package:flutter/material.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewListSpeedDialFab extends StatefulWidget {

  String page;
  SpeedDialController controller;
  var onSpeedDialAction;
  var getSpeedDialLabelWidget;

  ViewListSpeedDialFab({Key key, this.page, this.controller, this.onSpeedDialAction, this.getSpeedDialLabelWidget }) : super(key: key);

  @override
  ViewListSpeedDialFabState createState() => ViewListSpeedDialFabState();
}


class ViewListSpeedDialFabState extends State<ViewListSpeedDialFab> {

  @override
  Widget build(BuildContext context) {
    return SpeedDialFloatingActionButton(
      actions: _getViewListIcons(),
      controller: widget.controller,
      childOnFold: Text('M', style: GoogleFonts.lato(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 40)),
      childOnUnfold: FaIcon(FontAwesomeIcons.times),
      onAction: widget.onSpeedDialAction,
    );
  }

  List<SpeedDialAction> _getViewListIcons() {
    return [
      SpeedDialAction(
        child: FaIcon(FontAwesomeIcons.searchDollar),
        label: widget.getSpeedDialLabelWidget('Price Check'),
      ),
      SpeedDialAction(
        child: FaIcon(FontAwesomeIcons.cartPlus),
        label: widget.getSpeedDialLabelWidget('Add Tag'),
      ),
    ];
  }
}