import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'bottom_nav_bar.dart';
import 'dynamic_fab.dart';
import '../navigation/lists_navigator.dart';
import '../navigation/live_feed_navigator.dart';
import '../navigation/stores_navigator.dart';
import '../navigation/profiles_navigator.dart';
import '../navigation/navigation_options.dart';
import '../scan_barcode.dart';

class BottomScaffold extends StatefulWidget {
  BottomScaffold({Key key }) : super(key: key);

  List<Map<String, String>> pages = getPages();

  @override
  _BottomScaffoldState createState() => _BottomScaffoldState();
}

class _BottomScaffoldState extends State<BottomScaffold> {

  int _selectedIndex = 0;

  final List<BottomNavigationBarItem> _navOptions = getNavTabOptions();

  List<Widget> _navigators;

  final GlobalKey<ListsNavigatorState> listsNavigatorState = GlobalKey<ListsNavigatorState>();
  final GlobalKey<LiveFeedNavigatorState> liveFeedNavigatorState = GlobalKey<LiveFeedNavigatorState>();
  final GlobalKey<StoresNavigatorState> storesNavigatorState = GlobalKey<StoresNavigatorState>();
  final GlobalKey<ProfilesNavigatorState> profilesNavigatorState = GlobalKey<ProfilesNavigatorState>();

  final GlobalKey<DynamicFabState> dynamicFabState = GlobalKey<DynamicFabState>();

  @override
  void initState() {
    super.initState();
    _navigators =  getNavigators(listsNavigatorState, liveFeedNavigatorState, storesNavigatorState, profilesNavigatorState, dynamicFabState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigators[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        navOptions: _navOptions,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: DynamicFab(
        key: dynamicFabState,
        page: getPage(),
        onSpeedDialAction: _onSpeedDialAction,
        onBarcodeButtonPressed: _onBarcodeButtonPressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTapped(int index) {
    dynamicFabState.currentState.tabChanged();
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSpeedDialAction(int actionIndex) {
    if (actionIndex == 0) {
      _onBarcodeButtonPressed();
    } else {
      listsNavigatorState.currentState.navigate();
    }
  }

  void _onBarcodeButtonPressed() async {
    // could be a save button - not necessarily barcode
    Future<String> barcode = scanBarcode();
    barcode.then((String upc) {
      // _onItemTapped(null); // how to select none of the tabs?
      print(upc);
    });
  }

  String getPage() {
    GlobalKey theKey;
    switch (_selectedIndex) {
      case 0:
        if (listsNavigatorState.currentContext == null) {
          return 'myLists';
        }
        theKey = listsNavigatorState;
        break;
      case 1:
        if (liveFeedNavigatorState.currentContext == null) {
          return 'liveFeed';
        }
        theKey = liveFeedNavigatorState;
        break;
      case 2:
        if (storesNavigatorState.currentContext == null) {
          return 'viewStores';
        }
        theKey = storesNavigatorState;
        break;
      case 3:
        if (profilesNavigatorState.currentContext == null) {
          return 'myProfile';
        }
        theKey = profilesNavigatorState;
        break;
      default:
        return 'markit';
    }
    String route = ModalRoute.of(theKey.currentContext).settings.name;
    String title = widget.pages[_selectedIndex][route];
    return title;
  }
}