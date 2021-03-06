import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:markit/components/common/navigation/lists_navigator.dart';
import 'package:markit/components/common/navigation/live_feed_navigator.dart';
import 'package:markit/components/common/navigation/profiles_navigator.dart';
import 'package:markit/components/common/navigation/stores_navigator.dart';
import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/live_feed/pages/live_feed.dart';
import 'package:markit/components/models/markit_user_model.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/profile/pages/my_profile.dart';
import 'package:markit/components/profile/pages/view_profile.dart';
import 'package:markit/components/shopping_list/pages/add_tag.dart';
import 'package:markit/components/shopping_list/pages/my_lists.dart';
import 'package:markit/components/shopping_list/pages/new_list.dart';
import 'package:markit/components/shopping_list/pages/price_check.dart';
import 'package:markit/components/shopping_list/pages/price_check_store.dart';
import 'package:markit/components/shopping_list/pages/view_list.dart';
import 'package:markit/components/shopping_list/pages/view_tag.dart';
import 'package:markit/components/shopping_list/pages/add_rating.dart';
import 'package:markit/components/store/pages/view_store.dart';
import 'package:markit/components/store/pages/view_store_map.dart';
import 'package:markit/components/store/pages/view_stores.dart';


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
      icon: FaIcon(FontAwesomeIcons.solidUserCircle),
      title: Text('My Profile')
    ),
  ];
}

List<Widget> getNavigators(GlobalKey listsNav, GlobalKey liveFeedNav, GlobalKey storesNav, GlobalKey profilesNav, GlobalKey dynamicFabKey, GlobalKey bottomScaffoldKey, { MarkitUserModel userArg, StoreModel storeArg }) {
  return [
    ListsNavigator(
      key: listsNav,
      dynamicFabKey: dynamicFabKey,
      bottomScaffoldKey: bottomScaffoldKey,
    ),
    LiveFeedNavigator(
      key: liveFeedNav,
      bottomScaffoldKey: bottomScaffoldKey,
    ),
    StoresNavigator(
      key: storesNav,
      storeArg: storeArg,
      bottomScaffoldKey: bottomScaffoldKey,
    ),
    ProfilesNavigator(
      key: profilesNav,
      dynamicFabKey: dynamicFabKey,
      bottomScaffoldKey: bottomScaffoldKey,
      userArg: userArg,
    ),
  ];
}

Map<String, Widget> getListsRoutes(GlobalKey myListsKey, GlobalKey viewListKey, GlobalKey priceCheckListKey, GlobalKey priceCheckStoreKey, GlobalKey dynamicFab, GlobalKey bottomScaffoldKey) {
  return {
    '/': MyLists(key: myListsKey, dynamicFabKey: dynamicFab, bottomScaffoldKey: bottomScaffoldKey),
    'newList': NewList(dynamicFabKey: dynamicFab),
    'addTag': AddTag(dynamicFabKey: dynamicFab),
    'viewList': ViewList(key: viewListKey, dynamicFabKey: dynamicFab, bottomScaffoldKey: bottomScaffoldKey, myListsKey: myListsKey),
    'viewTag': ViewTag(dynamicFabKey: dynamicFab),
    'priceCheck': PriceCheck(priceCheckListKey: priceCheckListKey, dynamicFabKey: dynamicFab),
    'priceCheckStore': PriceCheckStore(key: priceCheckStoreKey, dynamicFabKey: dynamicFab),
    'addRating': AddRating(dynamicFabKey: dynamicFab),
  };
}

Map<String, Widget> getLiveFeedRoutes(GlobalKey liveFeedKey, GlobalKey bottomScaffoldKey) {
  return {
    '/': LiveFeed(key: liveFeedKey, bottomScaffoldKey: bottomScaffoldKey),
  };
}

Map<String, Widget> getStoresRoutes(GlobalKey viewStoresKey, GlobalKey viewStoreKey, GlobalKey viewStoreMapKey, GlobalKey<BottomScaffoldState> bottomScaffoldKey, {StoreModel storeArg}) {
  return {
    '/' : ViewStores(key: viewStoresKey, dynamicFabKey: bottomScaffoldKey.currentState.dynamicFabState),
    'view' : ViewStore(key: viewStoreKey, storeArg: storeArg, bottomScaffoldKey: bottomScaffoldKey),
    'viewMap' : ViewStoreMap(key: viewStoreMapKey, bottomScaffoldKey: bottomScaffoldKey),
    'addRating': AddRating(dynamicFabKey: bottomScaffoldKey.currentState.dynamicFabState),
  };
}

Map<String, Widget> getProfileRoutes(GlobalKey myProfileKey, GlobalKey dynamicFab, GlobalKey bottomScaffoldKey, { MarkitUserModel userArg }) {
  return {
    '/': MyProfile(key: myProfileKey, dynamicFabKey: dynamicFab, bottomScaffoldKey: bottomScaffoldKey),
    'view': ViewProfile(bottomScaffoldKey: bottomScaffoldKey, userArg: userArg),
  };
}

List<Map<String, String>> getPages() {
  return [
    {
      '/'                 : 'myLists',
      'newList'           : 'newList',
      'addTag'            : 'addTag',
      'viewList'          : 'viewList',
      'viewTag'           : 'viewTag',
      'priceCheck'        : 'priceCheck',
      'priceCheckStore'   : 'priceCheckStore',
      'addRating'         : 'addRating',
    },
    {
      '/': 'liveFeed',
    },
    {
      '/': 'viewStores',
      'viewStore': 'viewStore',
      'viewStoreMap': 'viewStoreMap',
      'addRating': 'addRating',
    },
    {
      '/': 'myProfile',
      'view': 'viewProfile',
    },
  ];
}