import 'package:flutter/material.dart';
import 'package:markit/components/common/scaffold/live_feed_app_bar_buttons.dart';

import 'package:markit/components/common/scaffold/price_check_app_bar_buttons.dart';
import 'package:markit/components/common/scaffold/view_stores_app_bar_buttons.dart';
import 'package:markit/components/live_feed/pages/live_feed.dart';
import 'package:markit/components/shopping_list/components/price_check_list.dart';
import 'package:markit/components/store/pages/view_stores.dart';

class MarkitAppBar extends StatefulWidget implements PreferredSizeWidget {

  String titleProp;

  GlobalKey<LiveFeedState> liveFeedKey;
  GlobalKey<PriceCheckListState> priceCheckListKey;
  GlobalKey<ViewStoresState> viewStoresKey;

  MarkitAppBar({Key key, this.titleProp, this.liveFeedKey, this.priceCheckListKey, this.viewStoresKey }) : super(key: key);

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
    );
  }

  Widget getBottomButtons() {
    if (_title == 'Price Check') {
      return PriceCheckAppBarButtons(
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
}