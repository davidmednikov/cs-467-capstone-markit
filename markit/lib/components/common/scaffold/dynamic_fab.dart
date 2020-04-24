import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:google_fonts/google_fonts.dart';

class DynamicFab extends StatelessWidget {

  String page;

  var onSpeedDialAction;
  var onBarcodeButtonPressed;

  DynamicFab({Key key, this.page, this.onSpeedDialAction, this.onBarcodeButtonPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(page);
    if (page == 'My Lists') {
      return _getSpeedDialFab();
    }
    return _getBarcodeScannerFab();
  }

  Widget _getSpeedDialFab() {
    final icons = _getSpeedDialIcons();

    return SpeedDialFloatingActionButton(
      actions: icons,
      childOnFold: Text('M', style: GoogleFonts.lato(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 40)),
      childOnUnfold: FaIcon(FontAwesomeIcons.times),
      onAction: onSpeedDialAction,
    );
  }

  Widget _getBarcodeScannerFab() {
    return FloatingActionButton(
      child: FaIcon(FontAwesomeIcons.qrcode),
      onPressed: onBarcodeButtonPressed,
    );
  }

  List<SpeedDialAction> _getSpeedDialIcons() {
    return [
      SpeedDialAction(
        child: FaIcon(FontAwesomeIcons.qrcode),
      ),
      SpeedDialAction(
        child: FaIcon(FontAwesomeIcons.plus),
      ),
    ];
  }
}