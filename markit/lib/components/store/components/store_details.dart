import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/location_service.dart';

class StoreDetails extends StatelessWidget {

  StoreModel store;

  Position location;

  int totalReviews;

  int totalPrices;

  StoreDetails({Key key, this.store, this.location, this.totalReviews, this.totalPrices}) : super(key: key);

  LocationService locationService = new LocationService();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(store.name,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                            ),
                          ),
                        ),
                      ]
                    )
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10, top: 5),
                                      child: FaIcon(FontAwesomeIcons.mapPin, size: 18, color: Colors.deepOrange),
                                    ),
                                    Expanded(
                                      child: Text('${store.streetAddress}\n${store.city}, ${store.state} ${store.postalCode}',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: FaIcon(FontAwesomeIcons.locationArrow, size: 12, color: Colors.deepOrange),
                                      ),
                                    ),
                                    getDistanceOrPlaceholder(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: getRatingBar(),
                        ),
                      ]
                    )
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        showReviewsCountOrSkeleton(),
                      ]
                    )
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        showPricesCountOrSkeleton(),
                      ]
                    )
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getDistanceOrPlaceholder() {
    if (location == null) {
      return Flexible(
        child: LayoutBuilder(
          builder: (context, constraints) => getSkeletonText(constraints, Alignment.centerLeft),
          ),
      );
    }
    return Flexible(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('${locationService.locationBetweenInMiles(location.latitude, location.longitude, store.latitude, store.longitude).toStringAsFixed(2)} mi away',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey)
        ),
      ),
    );
  }

  Widget getRatingBar() {
    double rating = store.averageRating == null ? 0 : store.averageRating;
    return Padding(
      padding: EdgeInsets.only(right: 5, top: 10,),
      child: RatingBar.readOnly(
        initialRating: (rating * 2).roundToDouble() / 2.0,
        isHalfAllowed: true,
        emptyIcon: FontAwesomeIcons.star,
        filledIcon: FontAwesomeIcons.solidStar,
        halfFilledIcon: FontAwesomeIcons.starHalfAlt,
        size: 20,
        align: Alignment.topRight,
      ),
    );
  }

  Widget showReviewsCountOrSkeleton() {
    if (totalReviews == null) {
      return Flexible(
        child: LayoutBuilder(
          builder: (context, constraints) => getSkeletonText(constraints, Alignment.centerRight),
          ),
      );
    }
    String reviewsString;
    if (totalReviews == 1) {
      reviewsString = 'Review';
    } else {
      reviewsString = 'Reviews';
    }
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text('$totalReviews  ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Flexible(
            child: Text(reviewsString, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          )
        ],
      ),
    );
  }

  Widget showPricesCountOrSkeleton() {
    if (totalPrices == null) {
      return Flexible(
        child: LayoutBuilder(
          builder: (context, constraints) => getSkeletonText(constraints, Alignment.centerRight),
          ),
      );
    }
    String pricesString;
    if (totalPrices == 1) {
      pricesString = 'Price Added';
    } else {
      pricesString = 'Prices Added';
    }
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Text('$totalPrices  ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Flexible(
            flex: 4,
            child: Text(pricesString, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          )
        ],
      ),
    );
  }

  Widget getSkeletonText(BoxConstraints constraints, Alignment align) {
    return Align(
      alignment: align,
      child: SkeletonAnimation(
        child: Container(
          width: constraints.maxWidth * .9,
          height: constraints.maxHeight * .75,
          decoration: BoxDecoration(
              color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}