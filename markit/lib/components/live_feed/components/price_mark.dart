import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/common/widgets/status_icon.dart';
import 'package:markit/components/models/markit_user_model.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/date_service.dart';
import 'package:markit/components/service/location_service.dart';

class PriceMark extends StatelessWidget {
  final List<String> tags;
  final StoreModel store;
  final double price;
  final MarkitUserModel user;
  final DateTime submittedDate;
  final Position location;

  bool hideUser;
  bool hideStore;

  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  PriceMark({
    Key key,
    this.tags,
    this.price,
    this.store,
    this.user,
    this.submittedDate,
    this.location,
    this.bottomScaffoldKey,
    this.hideUser = false,
    this.hideStore = false,
  }) : super(key: key);

  final DateFormat formatter = new DateFormat.yMd();
  final LocationService locationService = new LocationService();

  @override
  Widget build(BuildContext context) {
    String strDate = formatter.format(submittedDate);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      '${DateService.getTimeString(submittedDate).item1}',
                      style: TextStyle(
                        color: Colors.grey
                      )
                    ),
                  )
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      '$strDate',
                      style: TextStyle(
                        color: Colors.grey
                      )
                    ),
                  )
                ),
              ),
            ],
          ),
          Row(
            children:[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 5, bottom: 5, top: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Text('Tags:',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(getTagsList(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 5, top: 5, right: 15, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text('\$${price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
          getBottomRow(),
        ],
      ),
    );
  }

  Widget getBottomRow() {
    return Row(
      children: [
        getStoreAddressWidget(),
        getSubmittingUserWidget()
      ],
    );
  }

  Widget getStoreAddressWidget() {
    if (hideStore) {
      return Expanded(
        child: Container(),
      );
    }
    double distance = locationService.locationBetweenInMiles(location.latitude, location.longitude, store.latitude, store.longitude);
    return Expanded(
      child: GestureDetector(
        onTap: () => viewStore(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      '$store',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text('${distance.toStringAsFixed(2)} mi away',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      // overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget getSubmittingUserWidget() {
    if (hideUser) {
      return Expanded(
        child: Container(),
      );
    }
    return Expanded(
      child: GestureDetector(
        onTap: () => viewUser(),
        child: Padding(
          padding: EdgeInsets.only(left: 5, top: 5, right: 15, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text('${user.username}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: StatusIcon(userReputation: user.reputation),
              ),
            ],
          ),
        ),
      ),
    );
   }

  String getTagsList() {
    String returnString = '';
    for (int i = 0; i < tags.length; i++) {
      if (i != tags.length - 1 && tags.length != 1) {
        returnString += '${tags[i]} ,\n';
      } else {
        returnString += '${tags[i]}';
      }
    }
    return returnString;
  }

  void viewStore() {
    bottomScaffoldKey.currentState.navigateToStore(store);
  }

  void viewUser() {
    bottomScaffoldKey.currentState.navigateToUser(user);
  }
}