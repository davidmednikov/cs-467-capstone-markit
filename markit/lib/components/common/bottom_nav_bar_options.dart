import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../live_feed/live_feed.dart';
import '../profile/my_profile.dart';
import '../shopping_list/my_lists.dart';
import '../store/view_stores.dart';

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

List<Widget> getNavTabViews(GlobalKey key) {
  return [
    MyLists(key: key),
    LiveFeed(),
    ViewStores(),
    MyProfile()
  ];
}