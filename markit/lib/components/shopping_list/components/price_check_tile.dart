import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/store_model.dart';

class PriceCheckTile extends StatelessWidget {

  StoreModel storePriceRun;

  GlobalKey<DynamicFabState> dynamicFabKey;

  // GlobalKey<MyListsState> myListsKey;

  PriceCheckTile({Key key, this.dynamicFabKey, this.storePriceRun}) : super(key: key);

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
        children: [
          // Opacity(
          //   opacity: 0.5,
          //   child: FaIcon(FontAwesomeIcons.shoppingBasket, color: Colors.grey, size: 36),
          // ),
          Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Text(
              '\$${storePriceRun.priceRunTotal}',
              style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}