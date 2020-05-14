import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/models/store_model.dart';

class PriceCheckTile extends StatelessWidget {

  StoreModel storePriceRun;

  ShoppingListModel shoppingList;

  GlobalKey<DynamicFabState> dynamicFabKey;

  PriceCheckTile({Key key, this.dynamicFabKey, this.storePriceRun, this.shoppingList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        storePriceRun.name,
        // style: TextStyle(fontSize: 22),
      ),
      subtitle: Text(
        storePriceRun.city
      ),
      trailing: Stack(
        alignment: Alignment.center,
        children: getChildren(),
      ),
    );
  }

  List<Widget> getChildren() {
    List<Widget> widgets = [
      Padding(
        padding: EdgeInsets.only(bottom: 2),
        child: Text(
          '\$${storePriceRun.priceRunTotal}',
          style: getGoogleFont(),
        ),
      ),
    ];
    if (storePriceRun.priceRunStaleness >= 10) {
      widgets.insert(0,
        Opacity(
          opacity: 0.5,
          child: FaIcon(FontAwesomeIcons.clock, color: Colors.grey, size: 36),
        )
      );
    }
    return widgets;
  }

  TextStyle getGoogleFont() {
    if (storePriceRun.priceRunStaleness >= 10) {
      return GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xfffff2226));
    }
    return GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold);
  }
}