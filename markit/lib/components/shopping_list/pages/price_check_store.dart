import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/list_tag_model.dart';
import 'package:markit/components/models/price_check_model.dart';
import 'package:markit/components/models/price_check_tag_model.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/shopping_list/components/price_check_tag_tile.dart';
import 'package:markit/components/store/components/store_listing_tile.dart';

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

  PriceCheckModel priceCheckStore;

  Position userLocation;

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    shoppingList = arguments['shoppingList'];
    priceCheckStore = arguments['priceCheckStore'];
    userLocation = arguments['userLocation'];
    return WillPopScope(
      child: TopScaffold(
        title: 'Price Check - ${priceCheckStore.store.name}',
        view: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            storeTile(),
            markitTotal(),
            itemList(context),
          ],
        ),
      ),
      onWillPop: notifyFabOfPop,
    );
  }

  Widget storeTile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Text('Store:', style: GoogleFonts.lato(fontSize: 19, color: Colors.deepOrange, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                child: StoreListingTile(
                  store: priceCheckStore.store,
                  position: userLocation,
                  dynamicFabKey: widget.dynamicFabKey,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget markitTotal() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Text('Markit Total:', style: GoogleFonts.lato(fontSize: 19, color: Colors.deepOrange, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[600])),
                  ),
                  child: Text('\$${priceCheckStore.totalPrice.toStringAsFixed(2)}', style: GoogleFonts.lato(fontSize: 20, color: Colors.black)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget itemList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: shoppingList.listTags.length,
        itemBuilder: (context, index) {
          ListTagModel tag = shoppingList.listTags[index];
          PriceCheckTagModel priceCheckTag = getMatchingPriceCheckTag(tag);
          return PriceCheckTagTile(listTag: tag, priceCheckTag: priceCheckTag, dynamicFabKey: widget.dynamicFabKey);
        },
      ),
    );
  }

  PriceCheckTagModel getMatchingPriceCheckTag(ListTagModel tag) {
    List<PriceCheckTagModel> matchingTags = priceCheckStore.tagPrices.where((tagPrice) => tagPrice.tagNames.contains(tag.tagName)).toList();
    if (matchingTags.length > 0) {
      return matchingTags[0];
    }
    return null;
  }

  Future<bool> notifyFabOfPop() {
    widget.dynamicFabKey.currentState.changePage('priceCheck');
    return Future.value(true);
  }
}