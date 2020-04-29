import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../live_feed/live_feed.dart';
import '../../profile/my_profile.dart';
import '../../shopping_list/pages/new_list.dart';
import '../../shopping_list/pages/add_tag.dart';
import '../../shopping_list/pages/my_lists.dart';
import '../../shopping_list/pages/view_list.dart';
import '../../shopping_list/pages/view_tag.dart';
import '../../store/view_stores.dart';

import 'lists_navigator.dart';
import 'live_feed_navigator.dart';
import 'stores_navigator.dart';
import 'profiles_navigator.dart';

import '../../models/shopping_list_model.dart';

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
    ),
  ];
}

Map<String, Widget> getListsRoutes(GlobalKey myListsKey, GlobalKey viewListKey, GlobalKey dynamicFab) {
  return {
    '/': MyLists(key: myListsKey, myLists: getTestLists(), dynamicFabKey: dynamicFab),
    'newList': NewList(dynamicFabKey: dynamicFab),
    'addTag': AddTag(dynamicFabKey: dynamicFab),
    'viewList': ViewList(key: viewListKey, dynamicFabKey: dynamicFab),
    'viewTag': ViewTag(dynamicFabKey: dynamicFab),
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

Map<String, Widget> getProfileRoutes() {
  return {
    '/': MyProfile(),
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