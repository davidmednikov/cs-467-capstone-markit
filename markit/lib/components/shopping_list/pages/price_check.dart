import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/price_check_app_bar_buttons.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/shopping_list/components/price_check_list.dart';

class PriceCheck extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;
  GlobalKey<PriceCheckListState> priceCheckListKey;
  GlobalKey<PriceCheckAppBarButtonsState> priceCheckAppBarButtonsKey = new GlobalKey();

  PriceCheck({Key key, this.priceCheckListKey, this.dynamicFabKey}) : super(key: key);

  @override
  PriceCheckState createState() => PriceCheckState();
}

class PriceCheckState extends State<PriceCheck> {

  ShoppingListModel shoppingList;

  String sortBy = 'Price Only';

  @override
  Widget build(BuildContext context) {
    shoppingList = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      child: TopScaffold(
        title: 'Price Check',
        priceCheckListKey: widget.priceCheckListKey,
        priceCheckAppBarButtonsKey: widget.priceCheckAppBarButtonsKey,
        view: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PriceCheckList(
              key: widget.priceCheckListKey,
              shoppingList: shoppingList,
              dynamicFabKey: widget.dynamicFabKey,
              priceCheckAppBarButtonsKey: widget.priceCheckAppBarButtonsKey,
            )
          ],
        ),
      ),
      onWillPop: notifyFabOfPop,
    );
  }

  Future<bool> notifyFabOfPop() {
    widget.dynamicFabKey.currentState.changePage('viewList');
    widget.priceCheckListKey.currentState.stopShowingNotifications();
    return Future.value(true);
  }
}