import 'package:flutter/material.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:markit/components/common/scaffold/my_lists_speed_dial_fab.dart';
import 'package:markit/components/common/scaffold/view_list_speed_dial_fab.dart';

class DynamicFab extends StatefulWidget {

  String page;

  var onSpeedDialAction;
  var onBarcodeButtonPressed;
  var onPriceCheckButtonPressed;
  var onAddRatingButtonPressed;
  var onCancelButtonPressed;
  var onCheckmarkButtonPressed;

  DynamicFab({Key key, this.page, this.onSpeedDialAction, this.onBarcodeButtonPressed, this.onPriceCheckButtonPressed, this.onAddRatingButtonPressed, this.onCancelButtonPressed, this.onCheckmarkButtonPressed }) : super(key: key);

  @override
  DynamicFabState createState() => DynamicFabState();
}

class DynamicFabState extends State<DynamicFab> {

  String currentPage;

  bool stateChangedManually = false;

  SpeedDialController _controller = SpeedDialController();

  @override
  Widget build(BuildContext context) {
    if (!stateChangedManually) {
      currentPage = widget.page;
    }
    if (currentPage == 'myLists') {
      return MyListsSpeedDialFab(
        page: currentPage,
        controller: _controller,
        onSpeedDialAction: widget.onSpeedDialAction,
        getSpeedDialLabelWidget: getSpeedDialLabelWidget,
      );
    } else if (currentPage == 'viewList') {
      return ViewListSpeedDialFab(
        page: currentPage,
        controller: _controller,
        onSpeedDialAction: widget.onSpeedDialAction,
        getSpeedDialLabelWidget: getSpeedDialLabelWidget,
      );
    } else if (currentPage == 'viewTag' || currentPage == 'addTag') {
      return _getPriceCheckFab();
    } else if (currentPage == 'priceCheck' || currentPage == 'priceCheckStore') {
      return _getAddFeedbackFab();
    } else if (currentPage == 'addRating') {
      return _getCancelFab();
    } else if (currentPage == 'markit') {
      return Container(width: 0, height: 0);
    }
    return _getBarcodeScannerFab();
  }

  void changePage(String newPage) {
    _controller.unfold();
    setState(() {
      stateChangedManually = true;
      currentPage = newPage;
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
      onPressed: widget.onBarcodeButtonPressed,
    );
  }

  Widget _getPriceCheckFab() {
    return FloatingActionButton(
      child: FaIcon(FontAwesomeIcons.searchDollar),
      onPressed: widget.onPriceCheckButtonPressed,
    );
  }

  Widget _getAddFeedbackFab() {
    return FloatingActionButton(
      child: Icon(Icons.add_comment, size: 32),
      onPressed: widget.onAddRatingButtonPressed,
    );
  }

  Widget _getCancelFab() {
    return FloatingActionButton(
      child: FaIcon(FontAwesomeIcons.times),
      onPressed: widget.onCancelButtonPressed,
    );
  }

  Widget _getCheckmarkFab() {
    return FloatingActionButton(
      child: FaIcon(FontAwesomeIcons.check),
      onPressed: widget.onCheckmarkButtonPressed,
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