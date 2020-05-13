import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/markit_app_bar.dart';
import 'package:markit/components/shopping_list/components/price_check_list.dart';

class TopScaffold extends StatelessWidget {

  String title;

  Widget view;

  GlobalKey<PriceCheckListState> priceCheckListKey;

  TopScaffold({Key key, this.title, this.view, this.priceCheckListKey }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MarkitAppBar(
        titleProp: title,
        priceCheckListKey: priceCheckListKey,
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