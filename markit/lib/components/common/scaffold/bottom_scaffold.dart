import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'package:markit/components/common/navigation/lists_navigator.dart';
import 'package:markit/components/common/navigation/live_feed_navigator.dart';
import 'package:markit/components/common/navigation/profiles_navigator.dart';
import 'package:markit/components/common/navigation/navigation_options.dart';
import 'package:markit/components/common/navigation/stores_navigator.dart';
import 'package:markit/components/common/scaffold/bottom_nav_bar.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scan_barcode.dart';
import 'package:markit/components/service/location_service.dart';
import 'package:markit/components/service/tutorial_service.dart';
import 'package:markit/components/service/tag_service.dart';

class BottomScaffold extends StatefulWidget {
  BottomScaffold({Key key }) : super(key: key);

  List<Map<String, String>> pages = getPages();

  @override
  BottomScaffoldState createState() => BottomScaffoldState();

  LocationService locationService = new LocationService();
  TagService tagService = new TagService();
  TutorialService tutorialService = new TutorialService();
}

class BottomScaffoldState extends State<BottomScaffold> {

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
    WidgetsBinding.instance.addPostFrameCallback((_) => showTutorialIfFirstTime());
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
        onPriceCheckButtonPressed: _onPriceCheckButtonPressed,
        onAddRatingButtonPressed: _onAddRatingButtonPressed,
        onCancelButtonPressed: _onCancelButtonPressed,
        onCheckmarkButtonPressed: _onCheckmarkButtonPressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      dynamicFabState.currentState.tabChanged();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSpeedDialAction(int actionIndex) {
    if (listsNavigatorState.currentState.widget.viewListKey.currentState == null) {
      if (actionIndex == 0) {
        _onBarcodeButtonPressed();
      } else {
        dynamicFabState.currentState.changePage('newList');
        listsNavigatorState.currentState.navigateToNewList();
      }
    } else if (actionIndex == 0) {
      listsNavigatorState.currentState.navigateToPriceCheck(false);
    } else {
      dynamicFabState.currentState.changePage('addTag');
      listsNavigatorState.currentState.navigateToAddTag();
    }
  }

  void _onBarcodeButtonPressed() async {
    String barcode = await scanBarcode();
    if (barcode != null) {
      String currentPage = dynamicFabState.currentState.currentPage;
      final ProgressDialog dialog = ProgressDialog(context);
      await dialog.show();
      Position position = await widget.locationService.getLocation();
      List<Map> tags = List<Map>.from(await widget.tagService.getTagsForUpc(barcode));
      await dialog.hide();
      dynamicFabState.currentState.changePage('markit');
      Navigator.of(context).pushNamed('markit', arguments: {
        'upc': barcode,
        'tags': tags,
        'latitude': position.latitude,
        'longitude': position.longitude,
        'dynamicFabKey': dynamicFabState,
        'pushedFrom': currentPage,
      });
    }
  }

  void _onPriceCheckButtonPressed() {
    listsNavigatorState.currentState.navigateToPriceCheck(true);
  }

  void _onAddRatingButtonPressed() {
    listsNavigatorState.currentState.navigateToAddRating();
  }

  void _onCancelButtonPressed() {
    listsNavigatorState.currentState.popBackToPriceCheck();
  }

  void _onCheckmarkButtonPressed() {
    print('checkmark');
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

  Future<void> showTutorialIfFirstTime() async {
    if (await widget.tutorialService.shouldShowHomeTutorial()) {
      widget.tutorialService.homeTutorialWatched();
      await new Future.delayed(const Duration(seconds : 1));
      showTutorial();
    }
  }

  void showTutorial() {
    TutorialCoachMark(
      context,
      targets: getTargets(),
      colorShadow: Colors.deepOrange,
      finish: (){},
      clickTarget: (target){},
      clickSkip: (){}
    )..show();
  }

  List<TargetFocus> getTargets() {
    return <TargetFocus>[
      TargetFocus(
        keyTarget: dynamicFabState,
        contents: [
          ContentTarget(
            align:AlignContent.top,
            child: Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Welcome to Markit',
                          style: GoogleFonts.lato(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'There\'s more than 1 way to Markit. Tap the button to get started.',
                          style: GoogleFonts.lato(fontStyle: FontStyle.italic, fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      TargetFocus(
        keyTarget: dynamicFabState,
        contents: [
          ContentTarget(
            align:AlignContent.top,
            child: Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Tap this icon to scan a barcode.',
                          style: GoogleFonts.lato(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.075,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: ClipOval(
                            child: Container(
                              color: Colors.white,
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8, left: 12),
                                  child: FaIcon(FontAwesomeIcons.qrcode, color: Colors.deepOrange, size: 30),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.075,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Climb the ranks by getting points for each price you add.',
                          style: GoogleFonts.lato(fontStyle: FontStyle.italic, fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      TargetFocus(
        keyTarget: dynamicFabState,
        contents: [
          ContentTarget(
            align:AlignContent.top,
            child: Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Or, tap this icon to create a new shopping list.',
                          style: GoogleFonts.lato(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.075,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: ClipOval(
                            child: Container(
                              color: Colors.white,
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8, left: 12),
                                  child: FaIcon(FontAwesomeIcons.plus, color: Colors.deepOrange, size: 30),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.075,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Add tags and start saving money now.',
                          style: GoogleFonts.lato(fontStyle: FontStyle.italic, fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];
  }
}