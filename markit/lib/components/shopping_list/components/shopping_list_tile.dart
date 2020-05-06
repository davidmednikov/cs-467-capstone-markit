import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/shopping_list/pages/my_lists.dart';

class ShoppingListTile extends StatelessWidget {

  ShoppingListModel shoppingList;

  GlobalKey<DynamicFabState> dynamicFabKey;

  GlobalKey<MyListsState> myListsKey;

  ShoppingListTile({Key key, this.shoppingList, this.dynamicFabKey, this.myListsKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableStrechActionPane(),
      actionExtentRatio: 0.2,
      child: ListTile(
        title: Text(
          shoppingList.name,
          // style: TextStyle(fontSize: 22),
        ),
        subtitle: Text(
          shoppingList.description,
        ),
        trailing: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 0.5,
              child: FaIcon(FontAwesomeIcons.shoppingBasket, color: Colors.grey, size: 36),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Text(
                getQuantityString(),
                style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        onTap: () {
          dynamicFabKey.currentState.changePage('viewList');
          Navigator.of(context).pushNamed('viewList', arguments: shoppingList);
        },
      ),
      secondaryActions: [
        IconSlideAction(
          caption: 'Rename',
          color: Colors.black45,
          icon: Icons.edit,
          onTap: () => renameList(),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => deleteList(),
        ),
      ],
    )
    ;
  }

  String getQuantityString() {
    int quantity = 0;
    for (int i = 0; i < shoppingList.listTags.length; i++) {
      quantity += shoppingList.listTags[i].quantity;
    }
    return quantity.toString();
  }

  void deleteList() {
    myListsKey.currentState.deleteList(shoppingList.id);
  }

  void renameList() {
    myListsKey.currentState.showRenameDialog(shoppingList.id, shoppingList.name);
  }
}