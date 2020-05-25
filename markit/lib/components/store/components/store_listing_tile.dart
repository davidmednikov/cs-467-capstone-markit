import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rating_bar/rating_bar.dart';

import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/location_service.dart';

class StoreListingTile extends StatelessWidget {
  final StoreModel store;
  final String letter;
  final Position position;

  LocationService locationService = new LocationService();

  StoreListingTile({Key key, this.store, this.letter, this.position});

  @override
  Widget build(BuildContext context) {
    double distance = locationService.locationBetweenInMiles(store.latitude, store.longitude, position.latitude, position.longitude);
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: ListTile(
          leading: FractionallySizedBox(
            child: Align(
              child: Text(letter),
              alignment: Alignment.centerLeft
            ),
            heightFactor: 1,
            widthFactor: 0.1,
          ),
          title: Text(store.name, style: TextStyle(fontSize: 16)),
          subtitle: Text('${store.streetAddress}\n${store.city}, ${store.state}', style: TextStyle(fontSize: 13)),
          trailing: getDistanceAndRatingWidget(distance),
        ),
      ),
    );
  }

  Widget getDistanceAndRatingWidget(double distance) {
    return FractionallySizedBox(
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
    );
  }
}