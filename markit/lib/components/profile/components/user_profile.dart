import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/profile/components/level.dart';
import 'package:markit/components/profile/components/recent_marks.dart';
import 'package:markit/components/profile/components/reputation.dart';
import 'package:markit/components/service/location_service.dart';

class UserProfile extends StatelessWidget {

  Position location;

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();
  LocationService locationService = new LocationService();

  UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserInfo(),
      builder: (context, snapshot) {
        print('user data: $snapshot');
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Level(level: snapshot.data['level'])
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(width: MediaQuery.of(context).size.width * 0.1)
                    ),
                    Expanded(
                      flex: 2,
                      child: ReputationMarks(
                        reputation: snapshot.data['reputation'],
                        totalMarks: snapshot.data['totalMarks']
                      )
                    ),
                  ],
                )
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.025),
                  child: Text(
                    'Recent marks',
                    style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.underline
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

  Future<Map<String, Object>> getUserInfo() async {
    if (location == null) {
      location = await locationService.getLocation();
    }
    Map<String, Object> userData;
    userData = await getLevelAndRep(userData);
    userData = await getMarks(userData);
    return userData;
  }

  Future<Map<String, Object>> getLevelAndRep(Map<String, Object> userData) async {
    final int userId = await apiService.getUserId();
    String url = 'https://markit-api.azurewebsites.net/user/$userId';
    userData = await apiService.getMap(url);
    return userData;
  }

  Future<Map<String, Object>> getMarks(Map<String, Object> userData) async {
    final int userId = await apiService.getUserId();
    String ratingsUrl = 'https://markit-api.azurewebsites.net/user/$userId/ratings';
    final Map ratingsResponse = await apiService.getMap(ratingsUrl);
    final int numRatings = ratingsResponse['totalRecords'];
    String pricesUrl = 'https://markit-api.azurewebsites.net/user/$userId/prices';
    final Map pricesResponse = await apiService.getMap(pricesUrl);
    final int numPrices = pricesResponse['totalRecords'];
    userData['totalMarks'] = numRatings + numPrices;
    // userData['testResp'] = pricesResponse;
    userData['marks'] = sortMarks(ratingsResponse['ratings'], pricesResponse['userPrices']);
    return userData;
  }

  List sortMarks(List ratings, List prices) {
    List marksList = ratings + prices;
    marksList.sort((b, a) => a['createdAt'].compareTo(b['createdAt']));
    return marksList;
  }
}