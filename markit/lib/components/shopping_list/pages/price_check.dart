import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/shopping_list/components/price_check_list.dart';

class PriceCheck extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;

  PriceCheck({Key key, this.dynamicFabKey}) : super(key: key);

  GlobalKey<PriceCheckListState> priceCheckListState = GlobalKey<PriceCheckListState>();

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
        view: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PriceCheckList(
              key: widget.priceCheckListState,
              shoppingList: shoppingList,
              dynamicFabKey: widget.dynamicFabKey,
            )
          ],
        ),
        priceCheckListKey: widget.priceCheckListState,
      ),
      onWillPop: notifyFabOfPop,
    );
  }

  Future<bool> notifyFabOfPop() {
    widget.dynamicFabKey.currentState.changePage('viewList');
    return Future.value(true);
  }
}