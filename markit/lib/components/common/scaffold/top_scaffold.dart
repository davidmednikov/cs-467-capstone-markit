import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/markit_app_bar.dart';
import 'package:markit/components/common/scaffold/price_check_app_bar_buttons.dart';
import 'package:markit/components/live_feed/pages/live_feed.dart';
import 'package:markit/components/profile/pages/my_profile.dart';
import 'package:markit/components/shopping_list/components/price_check_list.dart';
import 'package:markit/components/store/pages/view_stores.dart';

class TopScaffold extends StatelessWidget {

  String title;

  Widget view;

  GlobalKey<LiveFeedState> liveFeedKey;
  GlobalKey<PriceCheckListState> priceCheckListKey;
  GlobalKey<ViewStoresState> viewStoresKey;
  GlobalKey<PriceCheckAppBarButtonsState> priceCheckAppBarButtonsKey;
  GlobalKey<MyProfileState> myProfileKey;

  TopScaffold({Key key, this.title, this.view, this.liveFeedKey, this.priceCheckListKey, this.viewStoresKey, this.priceCheckAppBarButtonsKey, this.myProfileKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MarkitAppBar(
        titleProp: title,
        priceCheckListKey: priceCheckListKey,
        viewStoresKey: viewStoresKey,
        liveFeedKey: liveFeedKey,
        priceCheckAppBarButtonsKey: priceCheckAppBarButtonsKey,
        myProfileKey: myProfileKey,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(3),
          child: view,
        ),
      ),
    );
  }
}