import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/service/location_service.dart';
import 'package:markit/components/store/components/map_view.dart';
import 'package:markit/components/store/components/rating_marks.dart';
import 'package:markit/components/profile/components/recent_marks.dart';

class Store extends StatelessWidget {

  int storeId;
  Position location;

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();
  LocationService locationService = new LocationService();

  Store({Key key, this.storeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getStoreInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.025,
                  MediaQuery.of(context).size.height * 0.01,
                  MediaQuery.of(context).size.height * 0.025,
                  MediaQuery.of(context).size.height * 0.01,
                  ),
                child: Text(
                  '${snapshot.data['name']}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
                )
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.025,
                  MediaQuery.of(context).size.height * 0.01,
                  MediaQuery.of(context).size.height * 0.025,
                  MediaQuery.of(context).size.height * 0.01,
                  ),
                child: Text(
                  '${snapshot.data['city']}, ${snapshot.data['state']}',
                  style: TextStyle(
                    fontSize: 18,
                  )
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.height * 0.025,
                        MediaQuery.of(context).size.height * 0.01,
                        MediaQuery.of(context).size.height * 0.025,
                        MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: MapView(level: snapshot.data['level']) 
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(width: MediaQuery.of(context).size.width * 0.1)
                  ),
                  Expanded(
                    flex: 2,
                    child: RatingMarks(
                      rating: snapshot.data['averageRating'],
                      totalMarks: snapshot.data['totalMarks']
                    )
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.025, 0, MediaQuery.of(context).size.height * 0.025),
                  child: Text(
                    'Recent marks',
                    style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold
                    )
                  )
                )
              ),
              Expanded(
                child: RecentMarks(marks: snapshot.data['marks'], location: location)
              )
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange)),
          );
        }
      }
    );
  }

  Future<Map<String, Object>> getStoreInfo() async {
    if (location == null) {
      location = await locationService.getLocation();
    }
    Map<String, Object> storeData;
    storeData = await getRating(storeData);
    storeData = await getMarks(storeData);
    return storeData;
  }

  Future<Map<String, Object>> getRating(Map<String, Object> storeData) async {
    String url = 'https://markit-api.azurewebsites.net/store/$storeId';
    storeData = await apiService.getMap(url);
    return storeData;
  }

  Future<Map<String, Object>> getMarks(Map<String, Object> storeData) async {
    String ratingsUrl = 'https://markit-api.azurewebsites.net/store/$storeId/ratings';
    final Map ratingsResponse = await apiService.getMap(ratingsUrl);
    final int numRatings = ratingsResponse['totalRecords'];
    String pricesUrl = 'https://markit-api.azurewebsites.net/store/$storeId/prices';
    final Map pricesResponse = await apiService.getMap(pricesUrl);
    final int numPrices = pricesResponse['totalRecords'];
    storeData['totalMarks'] = numRatings + numPrices;
    storeData['marks'] = sortMarks(ratingsResponse['ratings'], pricesResponse['userPrices']);
    return storeData;
  }

  List sortMarks(List ratings, List prices) {
    List marksList = ratings + prices;
    marksList.sort((b, a) => a['createdAt'].compareTo(b['createdAt']));
    return marksList;
  }
}