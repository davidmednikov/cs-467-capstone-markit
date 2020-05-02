import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MarkitAppBar extends StatefulWidget implements PreferredSizeWidget {

  String titleProp;

  MarkitAppBar({Key key, this.titleProp }) : super(key: key);

  @override
  _MarkitAppBarState createState() => _MarkitAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
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
    );
  }

  void _changeTitle(String title) {
    setState(() {
      _title = title;
    });
  }

  List<Widget> getActions(context) {
    String route = ModalRoute.of(context).settings.name;
    if (_title == 'My Lists' || route == 'viewList') {
      return [
        PopupMenuButton(
          onSelected: (value) => selectedInPopup(value),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: 'Rename',
              child: Text('Rename'),
            ),
            const PopupMenuItem(
              value: 'Delete',
              child: Text('Delete'),
            ),
          ],
        ),
      ];
    } else if (_title == 'View Stores') {
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

  void selectedInPopup(var value) {
    print(value);
  }

  void mapViewToggled(bool isMapView) {
    print(isMapView);
    setState(() {
      _mapView = isMapView;
    });
  }
}