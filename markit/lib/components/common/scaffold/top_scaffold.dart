import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/markit_app_bar.dart';
import 'package:markit/components/live_feed/pages/live_feed.dart';
import 'package:markit/components/shopping_list/components/price_check_list.dart';
import 'package:markit/components/store/pages/view_stores.dart';

class TopScaffold extends StatelessWidget {

  String title;

  Widget view;

  GlobalKey<LiveFeedState> liveFeedKey;
  GlobalKey<PriceCheckListState> priceCheckListKey;
  GlobalKey<ViewStoresState> viewStoresKey;

  TopScaffold({Key key, this.title, this.view, this.liveFeedKey, this.priceCheckListKey, this.viewStoresKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MarkitAppBar(
        titleProp: title,
        priceCheckListKey: priceCheckListKey,
        viewStoresKey: viewStoresKey,
        liveFeedKey: liveFeedKey,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: view,
        ),
      ),
    );
  }
}