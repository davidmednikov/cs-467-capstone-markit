import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/price_check_model.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/service/location_service.dart';

class PriceCheckStoreTile extends StatelessWidget {

  PriceCheckModel storePriceCheck;

  ShoppingListModel shoppingList;

  Position userLocation;

  GlobalKey<DynamicFabState> dynamicFabKey;

  PriceCheckStoreTile({Key key, this.dynamicFabKey, this.storePriceCheck, this.shoppingList, this.userLocation}) : super(key: key);

  LocationService locationService = new LocationService();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        storePriceCheck.store.name,
        style: TextStyle(fontSize: 22),
      ),
      subtitle: Text(
        '${getDistance()} mi. away',
      ),
      trailing: Stack(
        alignment: Alignment.center,
        children: getChildren(),
      ),
      onTap: () => viewStoreTags(context),
    );
  }

  List<Widget> getChildren() {
    List<Widget> widgets = [
      Padding(
        padding: EdgeInsets.only(bottom: 2),
        child: Text(
          '\$${storePriceCheck.totalPrice.toStringAsFixed(2)}',
          style: getGoogleFont(),
        ),
      ),
    ];
    if (storePriceCheck.staleness >= 10) {
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
    if (storePriceCheck.staleness >= 10) {
      return GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xfffff2226));
    }
    return GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold);
  }

  String getDistance() {
    return locationService.locationBetweenInMiles(
      userLocation.latitude, userLocation.longitude, storePriceCheck.store.latitude, storePriceCheck.store.longitude)
      .toStringAsFixed(2);
  }

  void viewStoreTags(BuildContext context) {
    Map arguments = {
      'shoppingList': shoppingList,
      'priceCheckStore': storePriceCheck,
    };
    Navigator.of(context).pushNamed('priceCheckStore', arguments: arguments);
  }
}