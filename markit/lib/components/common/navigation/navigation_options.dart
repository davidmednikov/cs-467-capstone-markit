import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../live_feed/live_feed.dart';
import '../../profile/my_profile.dart';
import '../../shopping_list/add_list.dart';
import '../../shopping_list/add_tag.dart';
import '../../shopping_list/my_lists.dart';
import '../../store/view_stores.dart';

import 'lists_navigator.dart';
import 'live_feed_navigator.dart';
import 'stores_navigator.dart';
import 'profiles_navigator.dart';

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

List<Widget> getNavigators(GlobalKey listsNav, GlobalKey liveFeedNav, GlobalKey storesNav, GlobalKey profilesNav) {
  return [
    ListsNavigator(
      key: listsNav,
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

Map<String, Map<String, Widget>> getListsRoutes(GlobalKey myListsKey, GlobalKey addListKey) {
  return {
    '/': {
      'title' : Text('My Lists'),
      'page'  : MyLists(key: myListsKey),
    },
    'addList': {
      'title' : Text('Add List'),
      'page'  : AddList(key: addListKey),
    },
    'addTag': {
      'title' : Text('Add Tag'),
      'page'  : AddTag(),
    },
    // 'viewList'  : ViewList(),
    // 'viewTag'   : ViewTag(),
  };
}

Map<String, Map<String, Widget>> getLiveFeedRoutes() {
  return {
    '/':{
      'title' : Text('Live Feed'),
      'page'  : LiveFeed(),
    }
  };
}

Map<String, Map<String, Widget>> getStoresRoutes() {
  return {
    '/':{
      'title' : Text('Live Feed'),
      'page'  : ViewStores(),
    }
    // 'viewStore' : ViewStore(),
  };
}

Map<String, Map<String, Widget>> getProfileRoutes() {
  return {
    '/': {
        'title' : Text('My Profile'),
        'page'  : MyProfile(),
      },
    // 'userProfile' : UserProfile()
  };
}

List<Map<String, String>> getTitles() {
  return [
    {
      '/': 'My Lists',
      'addList': 'Add List',
      'addTag'    : 'Add Tag',
      // 'viewList'  : ViewList(),
      // 'viewTag'   : ViewTag(),
    },
    {
      '/': 'Live Feed',
    },
    {
      '/': 'View Stores',
      'viewStore': 'View Store',
    },
    {
      '/': 'My Profile',
      // 'userProfile' : 'User Profile',
    },
  ];
}