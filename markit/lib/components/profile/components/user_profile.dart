import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:markit/components/common/widgets/status_avatar.dart';
import 'package:markit/components/models/markit_user_model.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:tuple/tuple.dart';

import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/profile/components/level.dart';
import 'package:markit/components/profile/components/recent_marks.dart';
import 'package:markit/components/profile/components/reputation.dart';
import 'package:markit/components/service/location_service.dart';

class UserProfile extends StatelessWidget {

  Position location;

  MarkitUserModel userProp;

  List ratings;
  List prices;

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();
  LocationService locationService = new LocationService();

  UserProfile({Key key, this.userProp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserActivity(),
      builder: (context, snapshot) => showUserProfileOrBaseTemplate(context, snapshot),
    );
  }

  Future<Map<String, Object>> getUserActivity() async {
    if (location == null) {
      location = await locationService.getLocation();
    }
    if (userProp == null) {
      userProp = await getUserInfo();
    }
    Tuple2<List, int> ratingsResponse = await getRatings();
    Tuple2<List, int> pricesResponse = await getPrices();
    ratings = ratingsResponse.item1;
    prices = pricesResponse.item1;
    Map<String, Object> userData = new Map();
    userData['user'] = userProp;
    userData['totalRatings'] = ratingsResponse.item2;
    userData['totalprices'] = pricesResponse.item2;
    userData['activity'] = sortMarks(ratings, prices);
    return userData;
  }

  Widget showUserProfileOrBaseTemplate(BuildContext context, AsyncSnapshot<Map> snapshot) {
    print('user data: $snapshot');
    if (snapshot.hasData) {
      Map<String, Object> userData = snapshot.data;
      MarkitUserModel markitUser = userData['user'];
      return getBlankTemplate(context);
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            color: Colors.deepOrange,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Center(
                child: getAvatar(context),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(
          //     MediaQuery.of(context).size.height * 0.025,
          //     MediaQuery.of(context).size.height * 0.01,
          //     MediaQuery.of(context).size.height * 0.025,
          //     MediaQuery.of(context).size.height * 0.01,
          //     ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Expanded(
          //         flex: 2,
          //         child: Level(level: snapshot.data['level'])
          //       ),
          //       Expanded(
          //         flex: 1,
          //         child: SizedBox(width: MediaQuery.of(context).size.width * 0.1)
          //       ),
          //       Expanded(
          //         flex: 2,
          //         child: ReputationMarks(
          //           reputation: snapshot.data['reputation'],
          //           totalMarks: snapshot.data['totalMarks']
          //         )
          //       ),
          //     ],
          //   )
          // ),
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
            child: RecentMarks(marks: userData['activity'], location: location)
          )
        ],
      );
    }
    return getBlankTemplate(context);
  }

  Widget getBlankTemplate(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              color: Colors.deepOrange,
              child: getAvatar(context),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.175,
              child: getUsernameBanner(context),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              height: MediaQuery.of(context).size.height * 0.2,
              child: getSummaryBox(),
            ),
          ],
        ),
      ],
    );
  }

  Widget getSummaryBox({String level, int prices, int reviews}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Flexible(
                    child: LayoutBuilder(
                      builder: (context, constraints) => getSkeletonText(constraints),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text('Reviews',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                                  ),
                                ),
                              ),
                            ]
                          )
                        ),
                        Flexible(
                          flex: 2,
                          child: Row(
                            children: [
                              Flexible(
                                child: LayoutBuilder(
                                  builder: (context, constraints) => getSkeletonText(constraints),
                                  ),
                              ),
                            ]
                          )
                        )
                      ]
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text('Prices',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                                  ),
                                ),
                              ),
                            ]
                          )
                        ),
                        Flexible(
                          flex: 2,
                          child: Row(
                            children: [
                              Flexible(
                                child: LayoutBuilder(
                                  builder: (context, constraints) => getSkeletonText(constraints),
                                ),
                              ),
                            ]
                          )
                        )
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAvatar(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: AvatarGlow(
        endRadius: MediaQuery.of(context).size.height * 0.11,
        showTwoGlows: true,
        child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.deepOrange[100],
            child: getAvatarContent(),
            radius: MediaQuery.of(context).size.height * 0.075,
            // radius: 50,
          ),
        ),
      ),
    );
  }

  Widget getAvatarContent() {
    if (userProp == null) {
      return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange));
    }
    return StatusAvatar(userReputation: userProp.reputation);
  }

  Widget getUsernameBanner(BuildContext context) {
    String username = '';
    if (userProp != null) {
      username = userProp.username;
    }
    return Center(
      child: Card(
        elevation: 5,
        shape: StadiumBorder(),
        color: Colors.deepOrange[100],
        child: Container(
          width: MediaQuery.of(context).size.width * 0.667,
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Center(
            child: Text(username,
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget getSkeletonText(BoxConstraints constraints) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SkeletonAnimation(
        child: Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight * .9,
          decoration: BoxDecoration(
              color: Colors.grey[300],
          ),
        ),
      ),
    );
  }

  Future<MarkitUserModel> getUserInfo() async {
    final int userId = await apiService.getUserId();
    String url = 'https://markit-api.azurewebsites.net/user/$userId';
    return MarkitUserModel.fromJsonForProfile(await apiService.getMap(url));
  }

  Future<Tuple2<List, int>> getRatings() async {
    String ratingsUrl = 'https://markit-api.azurewebsites.net/user/${userProp.id}/ratings';
    final Map ratingsResponse = await apiService.getMap(ratingsUrl);
    return Tuple2(List.from(ratingsResponse['ratings']), ratingsResponse['totalRecords']);
  }

  Future<Tuple2<List, int>> getPrices() async {
    String pricesUrl = 'https://markit-api.azurewebsites.net/user/${userProp.id}/prices';
    final Map pricesResponse = await apiService.getMap(pricesUrl);
    return Tuple2(List.from(pricesResponse['userPrices']), pricesResponse['totalRecords']);
  }

  List sortMarks(List ratings, List prices) {
    List marksList = ratings + prices;
    marksList.sort((b, a) => a['createdAt'].compareTo(b['createdAt']));
    return marksList;
  }
}