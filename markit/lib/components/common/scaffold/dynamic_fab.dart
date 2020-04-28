import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:google_fonts/google_fonts.dart';

class DynamicFab extends StatefulWidget {

  String page;

  var onSpeedDialAction;
  var onBarcodeButtonPressed;

  DynamicFab({Key key, this.page, this.onSpeedDialAction, this.onBarcodeButtonPressed }) : super(key: key);

  @override
  DynamicFabState createState() => DynamicFabState();
}

class DynamicFabState extends State<DynamicFab> {

  String _currentPage;

  bool stateChangedManually = false;

  @override
  Widget build(BuildContext context) {
    if (!stateChangedManually) {
      _currentPage = widget.page;
    }
    if (_currentPage == 'myLists' || _currentPage == 'viewList') {
      return _getSpeedDialFab(_currentPage);
    } else if (_currentPage == 'viewTag' || _currentPage == 'addTag') {
      return _getPriceRunFab();
    } else if (_currentPage == 'markit') {
      return _getCheckmarkFab();
    }
    return _getBarcodeScannerFab();
  }

  void changePage(String newPage) {
    setState(() {
      stateChangedManually = true;
      _currentPage = newPage;
    });
  }

  void tabChanged() {
    setState(() {
      stateChangedManually = false;
    });
  }

  Widget _getSpeedDialFab(String currentPage) {
    List<SpeedDialAction> actions;
    if (currentPage == 'viewList') {
      actions = _getViewListIcons();
    } else {
      actions = _getMyListsIcons();
    }

    return SpeedDialFloatingActionButton(
      actions: actions,
      childOnFold: Text('M', style: GoogleFonts.lato(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 40)),
      childOnUnfold: FaIcon(FontAwesomeIcons.times),
      onAction: widget.onSpeedDialAction,
    );
  }

  Widget _getBarcodeScannerFab() {
    return FloatingActionButton(
      child: FaIcon(FontAwesomeIcons.qrcode),
      onPressed: widget.onBarcodeButtonPressed,
    );
  }

  Widget _getPriceRunFab() {
    return FloatingActionButton(
      child: FaIcon(FontAwesomeIcons.searchDollar),
      onPressed: widget.onBarcodeButtonPressed,
    );
  }

  Widget _getCheckmarkFab() {
    return FloatingActionButton(
      child: FaIcon(FontAwesomeIcons.check),
      onPressed: widget.onBarcodeButtonPressed,
    );
  }

  List<SpeedDialAction> _getMyListsIcons() {
    return [
      SpeedDialAction(
        child: FaIcon(FontAwesomeIcons.qrcode),
      ),
      SpeedDialAction(
        child: FaIcon(FontAwesomeIcons.plus),
      ),
    ];
  }

  List<SpeedDialAction> _getViewListIcons() {
    return [
      SpeedDialAction(
        child: FaIcon(FontAwesomeIcons.searchDollar),
      ),
      SpeedDialAction(
        child: FaIcon(FontAwesomeIcons.plus),
      ),
    ];
  }
}