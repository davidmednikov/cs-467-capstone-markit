import 'package:flutter/material.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:markit/components/common/scaffold/my_lists_speed_dial_fab.dart';
import 'package:markit/components/common/scaffold/view_list_speed_dial_fab.dart';

class DynamicFab extends StatefulWidget {

  String page;

  var onSpeedDialAction;
  var onMainFabPressed;

  DynamicFab({Key key, this.page, this.onSpeedDialAction, this.onMainFabPressed }) : super(key: key);

  @override
  DynamicFabState createState() => DynamicFabState();
}

class DynamicFabState extends State<DynamicFab> {

  String _currentPage;

  bool stateChangedManually = false;

  SpeedDialController _controller = SpeedDialController();

  @override
  Widget build(BuildContext context) {
    if (!stateChangedManually) {
      _currentPage = widget.page;
    }
    if (_currentPage == 'myLists') {
      return MyListsSpeedDialFab(
        page: _currentPage,
        controller: _controller,
        onSpeedDialAction: widget.onSpeedDialAction,
        getSpeedDialLabelWidget: getSpeedDialLabelWidget,
      );
    } else if (_currentPage == 'viewList') {
      return ViewListSpeedDialFab(
        page: _currentPage,
        controller: _controller,
        onSpeedDialAction: widget.onSpeedDialAction,
        getSpeedDialLabelWidget: getSpeedDialLabelWidget,
      );
    } else if (_currentPage == 'viewTag' || _currentPage == 'addTag') {
      return _getPriceRunFab();
    } else if (_currentPage == 'markit') {
      return _getCheckmarkFab();
    }
    return _getBarcodeScannerFab();
  }

  void changePage(String newPage) {
    _controller.unfold();
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

  Widget _getBarcodeScannerFab() {
    return FloatingActionButton(
      child: FaIcon(FontAwesomeIcons.qrcode),
      onPressed: widget.onMainFabPressed,
    );
  }

  Widget _getPriceRunFab() {
    return FloatingActionButton(
      child: FaIcon(FontAwesomeIcons.searchDollar),
      onPressed: widget.onMainFabPressed,
    );
  }

  Widget _getCheckmarkFab() {
    return FloatingActionButton(
      child: FaIcon(FontAwesomeIcons.check),
      onPressed: widget.onMainFabPressed,
    );
  }

  Widget getSpeedDialLabelWidget(String label) {
    return SizedBox(
      child:  FittedBox(
        fit: BoxFit.scaleDown,
        child: Material(
          child: Text(
            label,
            style: GoogleFonts.lato(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 15, color: Colors.deepOrange),
          ),
        ),
      ),
      height: 20,
    );
  }
}