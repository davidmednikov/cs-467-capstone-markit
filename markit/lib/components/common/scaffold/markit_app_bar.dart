import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/price_check_app_bar_bottom_buttons.dart';
import 'package:markit/components/shopping_list/components/price_check_list.dart';

class MarkitAppBar extends StatefulWidget implements PreferredSizeWidget {

  String titleProp;

  GlobalKey<PriceCheckListState> priceCheckListKey;

  MarkitAppBar({Key key, this.titleProp, this.priceCheckListKey }) : super(key: key);

  @override
  _MarkitAppBarState createState() => _MarkitAppBarState();

  @override
  Size get preferredSize => calcAppBarSize();

  Size calcAppBarSize() {
    if (titleProp == 'Price Check') {
      return Size.fromHeight(AppBar().preferredSize.height + TabBar(tabs: []).preferredSize.height);
    }
    return AppBar().preferredSize;
  }
}

class _MarkitAppBarState extends State<MarkitAppBar> {

  String _title;

  bool _mapView = false;

  @override
  void initState() {
    super.initState();
    _title = widget.titleProp;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_title),
      centerTitle: true,
      actions: getActions(context),
      bottom: getBottomButtons(),
    );
  }

  /*
  / This switch will go into the ViewStoresAppBarButtons widget
  */
  List<Widget> getActions(context) {
    if (_title == 'View Stores') {
      return [
        Switch(
          value: _mapView,
          onChanged: mapViewToggled,
          activeColor: Color(0xff225dff),
          activeTrackColor: Color(0xffffc422),
          inactiveTrackColor: Colors.deepOrange[900],
          inactiveThumbColor: Color(0xffffc422),
          activeThumbImage: AssetImage('assets/img/pin.png'),
          inactiveThumbImage: AssetImage('assets/img/list.png'),
        )
      ];
    }
    return [];
  }

  Widget getBottomButtons() {
    if (_title == 'Price Check') {
      return PriceCheckAppBarButtons(
        priceCheckListKey: widget.priceCheckListKey,
      );
    } else if (_title == 'Live Feed') {
      // return LiveFeedAppBarButtons();
      return null;
    } else if (_title == 'View Stores') {
      // return ViewStoresAppBarButtons();
      return null;
    }
    return null;
  }

  void mapViewToggled(bool isMapView) {
    print(isMapView);
    setState(() {
      _mapView = isMapView;
    });
  }
}