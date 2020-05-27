import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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
      trailing: showPriceOrPriceAndProgress(),
      onTap: () => viewStoreTags(context),
    );
  }

  Widget showPriceOrPriceAndProgress() {
    if (storePriceCheck.matchedRatio == 1) {
      return getPriceStalenessStack();
    }
    return getPriceWithProgressBar();
  }

  Widget getPriceStalenessStack() {
    return Stack(
      alignment: Alignment.center,
      children: getPriceStalenessChildren(),
    );
  }

  List<Widget> getPriceStalenessChildren() {
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

  Widget getPriceWithProgressBar() {
    return Padding(
      padding: EdgeInsets.only(top: 3),
      child: FractionallySizedBox(
        alignment: Alignment.centerRight,
        widthFactor: 0.3,
        heightFactor: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: getPriceStalenessStack(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: makeProgressBar(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget makeProgressBar() {
    return StepProgressIndicator(
      totalSteps: 100,
      currentStep: (storePriceCheck.matchedRatio * 100).round(),
      selectedColor: Color(0xff22ff56),
      unselectedColor: Color(0xfffff2226),
      size: 7,
      padding: 0,
      roundedEdges: Radius.circular(3),
    );
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
      'userLocation': userLocation,
    };
    Navigator.of(context).pushNamed('priceCheckStore', arguments: arguments);
  }
}