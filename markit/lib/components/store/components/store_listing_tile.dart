import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rating_bar/rating_bar.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/location_service.dart';

class StoreListingTile extends StatelessWidget {
  final StoreModel store;
  final String letter;
  final Position position;

  GlobalKey<DynamicFabState> dynamicFabKey;

  LocationService locationService = new LocationService();

  StoreListingTile({Key key, this.store, this.letter, this.position, this.dynamicFabKey});

  @override
  Widget build(BuildContext context) {
    double distance = locationService.locationBetweenInMiles(store.latitude, store.longitude, position.latitude, position.longitude);
    return GestureDetector(
      onTap: () => navigateToViewStore(context),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: ListTile(
            leading: getLetterWidget(),
            title: Text(store.name, style: TextStyle(fontSize: 16)),
            subtitle: Text('${store.streetAddress}\n${store.city}, ${store.state} ${store.postalCode}', style: TextStyle(fontSize: 13)),
            trailing: getDistanceAndRatingWidget(distance),
          ),
        ),
      ),
    );
  }

  Widget getLetterWidget() {
    if (letter != null) {
      return FractionallySizedBox(
        child: Align(
          child: Image.asset('assets/img/map_markers/letter_${letter.toLowerCase()}.png'),
          alignment: Alignment.centerLeft
        ),
        heightFactor: 1,
        widthFactor: 0.1,
      );
    }
    return null;
  }

  Widget getDistanceAndRatingWidget(double distance) {
    return Padding(
      padding: EdgeInsets.only(top: 3),
      child: FractionallySizedBox(
        alignment: Alignment.centerRight,
        widthFactor: 0.2,
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
                    child: getRatingBar(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('${distance.toStringAsFixed(2)} mi', textAlign: TextAlign.end),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getRatingBar() {
    double rating = store.averageRating == null ? 0 : store.averageRating;
    return RatingBar.readOnly(
      initialRating: (rating * 2).roundToDouble() / 2.0,
      isHalfAllowed: true,
      emptyIcon: FontAwesomeIcons.star,
      filledIcon: FontAwesomeIcons.solidStar,
      halfFilledIcon: FontAwesomeIcons.starHalfAlt,
      size: 12,
      align: Alignment.centerRight,
    );
  }

  void navigateToViewStore(BuildContext context) {
    if (letter != null) {
      dynamicFabKey.currentState.changePage('viewStore');
      Navigator.of(context).pushNamed('view', arguments: store);
    } else {
      dynamicFabKey.currentState.widget.bottomScaffoldKey.currentState.navigateToStore(store);
    }
  }
}