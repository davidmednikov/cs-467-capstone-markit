import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
    }
    return [];
  }

  void selectedInPopup(var value) {
    print(value);
  }
}