import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:markit/components/common/navigation/lists_navigator.dart';
import 'package:markit/components/common/navigation/live_feed_navigator.dart';
import 'package:markit/components/common/navigation/profiles_navigator.dart';
import 'package:markit/components/common/navigation/stores_navigator.dart';
import 'package:markit/components/live_feed/live_feed.dart';
import 'package:markit/components/profile/my_profile.dart';
import 'package:markit/components/shopping_list/pages/add_tag.dart';
import 'package:markit/components/shopping_list/pages/my_lists.dart';
import 'package:markit/components/shopping_list/pages/new_list.dart';
import 'package:markit/components/shopping_list/pages/price_check.dart';
import 'package:markit/components/shopping_list/pages/view_list.dart';
import 'package:markit/components/shopping_list/pages/view_tag.dart';
import 'package:markit/components/store/view_stores.dart';


List<BottomNavigationBarItem> getNavTabOptions() {
  return [
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.shoppingBasket),
      title: Text('My Lists')
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.rss),
      title: Text('Live Feed')
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.mapMarkedAlt),
      title: Text('Stores')
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.userCircle),
      title: Text('My Profile')
    ),
  ];
}

List<Widget> getNavigators(GlobalKey listsNav, GlobalKey liveFeedNav, GlobalKey storesNav, GlobalKey profilesNav, GlobalKey dynamicFabKey) {
  return [
    ListsNavigator(
      key: listsNav,
      dynamicFabKey: dynamicFabKey,
    ),
    LiveFeedNavigator(
      key: liveFeedNav,
    ),
    StoresNavigator(
      key: storesNav,
    ),
    ProfilesNavigator(
      key: profilesNav,
      dynamicFabKey: dynamicFabKey,
    ),
  ];
}

Map<String, Widget> getListsRoutes(GlobalKey myListsKey, GlobalKey viewListKey, GlobalKey dynamicFab) {
  return {
    '/': MyLists(key: myListsKey, dynamicFabKey: dynamicFab),
    'newList': NewList(dynamicFabKey: dynamicFab),
    'addTag': AddTag(dynamicFabKey: dynamicFab),
    'viewList': ViewList(key: viewListKey, dynamicFabKey: dynamicFab),
    'viewTag': ViewTag(dynamicFabKey: dynamicFab),
    'priceCheck': PriceCheck(dynamicFabKey: dynamicFab),
  };
}

Map<String, Widget> getLiveFeedRoutes() {
  return {
    '/': LiveFeed(),
  };
}

Map<String, Widget> getStoresRoutes() {
  return {
    '/':ViewStores(),
    // 'viewStore' : ViewStore(),
  };
}

Map<String, Widget> getProfileRoutes(GlobalKey dynamicFab) {
  return {
    '/': MyProfile(dynamicFabKey: dynamicFab),
    // 'userProfile' : UserProfile()
  };
}

List<Map<String, String>> getPages() {
  return [
    {
      '/': 'myLists',
      'newList'   : 'newList',
      'addTag'    : 'addTag',
      'viewList'  : 'viewList',
      'viewTag'   : 'viewTag',
    },
    {
      '/': 'liveFeed',
    },
    {
      '/': 'viewStores',
      'viewStore': 'viewStore',
    },
    {
      '/': 'myProfile',
      // 'userProfile' : 'User Profile',
    },
  ];
}