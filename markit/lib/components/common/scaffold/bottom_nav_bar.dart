import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {

  final int selectedIndex;

  final List<BottomNavigationBarItem> navOptions;

  Function onItemTapped;

  BottomNavBar({Key key, this.selectedIndex, this.navOptions, this.onItemTapped }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: BottomNavigationBar(
        items: navOptions,
        currentIndex: selectedIndex,
        onTap: (index) => onItemTapped(index),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}