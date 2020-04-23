import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../mark_price/mark_price.dart';
import '../shopping_list/my_lists.dart';
import 'bottom_nav_bar.dart';
import 'navigation_options.dart';
import 'dynamic_fab.dart';
import 'scan_barcode.dart';

class MarkitScaffold extends StatefulWidget {
  MarkitScaffold({Key key }) : super(key: key);

  @override
  _MarkitScaffoldState createState() => _MarkitScaffoldState();
}

class _MarkitScaffoldState extends State<MarkitScaffold> {

  int _selectedIndex = 0;
  Text _title;

  final GlobalKey<MyListsState> _myListsState = GlobalKey<MyListsState>();

  final List<BottomNavigationBarItem> _navOptions = getNavTabOptions();
  final List<Map<String, String>> _routesTitlesMap = getRouteTitlesMap();

  List<Widget> _navTabs;

  @override
  void initState() {
    super.initState();
    _title = _navOptions[_selectedIndex].title;
    _navTabs = getNavTabViews(_myListsState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: _title,
        ),
        // leading: BackButton(
        //   onPressed: () => {
        //     print(ModalRoute.of(_myListsState.currentState.context).settings.name)
        //     // print(Navigator.of(_myListsState.currentState.context))
        //     // Navigator.of(_myListsState.currentState.context).pop();
        //   }),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: _navTabs.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        navOptions: _navOptions,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: DynamicFab(
        page: _title.data,
        onSpeedDialAction: _onSpeedDialAction,
        onBarcodeButtonPressed: _onBarcodeButtonPressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
      _title = Text(_routesTitlesMap[_selectedIndex][ModalRoute.of(context).settings.name]);
    });
  }

  void _onSpeedDialAction(int actionIndex) {
    if (actionIndex == 0) {
      _onBarcodeButtonPressed();
    } else {
      String newRoute = _myListsState.currentState.navigate();
      setState(() {
        _title = Text(_routesTitlesMap[_selectedIndex][newRoute]);
      });
    }
  }

  void _onBarcodeButtonPressed() async {
    Future<String> barcode = scanBarcode();
    barcode.then((String upc) => print(upc));
  }
}