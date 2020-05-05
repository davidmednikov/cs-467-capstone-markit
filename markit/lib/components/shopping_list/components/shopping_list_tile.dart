import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/shopping_list_model.dart';

class ShoppingListTile extends StatelessWidget {

  ShoppingListModel shoppingList;

  GlobalKey<DynamicFabState> dynamicFabKey;

  ShoppingListTile({Key key, this.shoppingList, this.dynamicFabKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        shoppingList.name,
        // style: TextStyle(fontSize: 22),
      ),
      subtitle: Text(
        shoppingList.description,
      ),
      trailing: Container(
        decoration: ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(13),
          child: Text(
            getQuantityString(),
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
      onTap: () {
        dynamicFabKey.currentState.changePage('viewList');
        Navigator.of(context).pushNamed('viewList', arguments: shoppingList);
      },
    );
  }

  String getQuantityString() {
    int quantity = 0;
    for (int i = 0; i < shoppingList.listTags.length; i++) {
      quantity += shoppingList.listTags[i].quantity;
    }
    return quantity.toString();
  }
}