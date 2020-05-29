import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:markit/components/common/scaffold/live_feed_app_bar_buttons.dart';
import 'package:markit/components/common/scaffold/price_check_app_bar_buttons.dart';
import 'package:markit/components/common/scaffold/view_stores_app_bar_buttons.dart';
import 'package:markit/components/live_feed/pages/live_feed.dart';
import 'package:markit/components/profile/pages/my_profile.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/shopping_list/components/price_check_list.dart';
import 'package:markit/components/store/pages/view_stores.dart';

class MarkitAppBar extends StatefulWidget implements PreferredSizeWidget {

  String titleProp;

  GlobalKey<LiveFeedState> liveFeedKey;
  GlobalKey<PriceCheckListState> priceCheckListKey;
  GlobalKey<ViewStoresState> viewStoresKey;
  GlobalKey<PriceCheckAppBarButtonsState> priceCheckAppBarButtonsKey;
  GlobalKey<MyProfileState> myProfileKey;

  MarkitAppBar({Key key, this.titleProp, this.liveFeedKey, this.priceCheckListKey, this.viewStoresKey, this.priceCheckAppBarButtonsKey, this.myProfileKey}) : super(key: key);

  AuthService authService = new AuthService();

  @override
  _MarkitAppBarState createState() => _MarkitAppBarState();

  @override
  Size get preferredSize => calcAppBarSize();

  Size calcAppBarSize() {
    if (titleProp == 'Price Check' || titleProp == 'View Stores' || titleProp == 'Live Feed') {
      return Size.fromHeight(AppBar().preferredSize.height + TabBar(tabs: []).preferredSize.height);
    }
    return AppBar().preferredSize;
  }
}

class _MarkitAppBarState extends State<MarkitAppBar> {

  String _title;

  @override
  void initState() {
    super.initState();
    _title = widget.titleProp;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_title),
      centerTitle: true,
      bottom: getBottomButtons(),
      actions: getActions(),
    );
  }

  Widget getBottomButtons() {
    if (_title == 'Price Check') {
      return PriceCheckAppBarButtons(
        key: widget.priceCheckAppBarButtonsKey,
        priceCheckListKey: widget.priceCheckListKey,
      );
    } else if (_title == 'Live Feed') {
      return LiveFeedAppBarButtons(
        liveFeedKey: widget.liveFeedKey,
      );
    } else if (_title == 'View Stores') {
      return ViewStoresAppBarButtons(
        viewStoresKey: widget.viewStoresKey,
      );
    }
    return null;
  }

  List<Widget> getActions() {
    if (_title == 'My Profile' || _title == 'View Profile') {
      return [
        PopupMenuButton(
          icon: FaIcon(FontAwesomeIcons.ellipsisV),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: ListTile(
                title: Text('Logout'),
                trailing: FaIcon(FontAwesomeIcons.signOutAlt),
              ),
              value: 'logout',
            )
          ],
          onSelected: (result) => popupItemTapped(result, context),
        ),
      ];
    }
    return [];
  }

  void popupItemTapped(String result, BuildContext context) {
    if (result == 'logout') {
      widget.authService.logout();
      widget.myProfileKey.currentState.logout();
    }
  }
}