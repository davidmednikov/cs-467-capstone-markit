import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/list_tag_model.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/shopping_list/components/list_tag_tile.dart';

class PriceCheckStore extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;

  PriceCheckStore({Key key, this.dynamicFabKey}) : super(key: key);

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();

  @override
  PriceCheckStoreState createState() => PriceCheckStoreState();
}

class PriceCheckStoreState extends State<PriceCheckStore> {

  ShoppingListModel shoppingList;

  StoreModel store;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: TopScaffold(
        title: 'Price Check - ${store.name}',
        view: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            notesField(),
            itemList(context),
          ],
        ),
      ),
      onWillPop: notifyFabOfPop,
    );
  }

  Widget notesField() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Notes',
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      initialValue: shoppingList.description,
      minLines: 2,
      maxLines: 4,
      enabled: false,
    );
  }

  Widget itemList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: shoppingList.listTags.length,
        itemBuilder: (context, index) {
          ListTagModel tag = shoppingList.listTags[index];
          return ListTagTile(listTag: tag, dynamicFabKey: widget.dynamicFabKey, viewListKey: widget.key);
        },
      ),
    );
  }

  Future<bool> notifyFabOfPop() {
    widget.dynamicFabKey.currentState.changePage('priceCheck');
    return Future.value(true);
  }
}