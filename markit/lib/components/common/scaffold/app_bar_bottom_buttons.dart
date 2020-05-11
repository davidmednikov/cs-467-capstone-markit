import 'package:flutter/material.dart';

class AppBarBottomButtons extends StatefulWidget implements PreferredSizeWidget {

  List<Widget> buttons;

  AppBarBottomButtons({Key key, this.buttons }) : super(key: key);

  @override
  _AppBarBottomButtonsState createState() => _AppBarBottomButtonsState();

  @override
  Size get preferredSize => TabBar(tabs: []).preferredSize;
}

class _AppBarBottomButtonsState extends State<AppBarBottomButtons> {

  bool starFilterEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      // data: Theme.of(context),
      data: Theme.of(context).copyWith(accentColor: Colors.white),
      child: Expanded(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  RaisedButton(
                    onPressed: priceFilter,
                    shape: StadiumBorder(),
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  RaisedButton(
                    onPressed: starFilter,
                    shape: StadiumBorder(),
                    color: getStarFilterColor(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getStarFilterColor() {
    if (starFilterEnabled) {
      return Color(0xffffc422);
    }
    return Colors.white;
  }

  void priceFilter() {
    print('priceFilter');
  }

  void starFilter() {
    print('starFilter');
    setState(() {
      starFilterEnabled = !starFilterEnabled;
    });
  }
}