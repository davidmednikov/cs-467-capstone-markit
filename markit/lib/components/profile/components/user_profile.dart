import 'package:flutter/material.dart';

import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/profile/components/level.dart';
import 'package:markit/components/profile/components/recent_marks.dart';
import 'package:markit/components/profile/components/reputation_marks.dart';

class UserProfile extends StatelessWidget {

  int userId;

  ApiService apiService = new ApiService();

  UserProfile({Key key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserInfo(),
      builder: (context, snapshot) {
        // print('user data: ${snapshot}');
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.025,
                  MediaQuery.of(context).size.height * 0.025,
                  MediaQuery.of(context).size.height * 0.025,
                  MediaQuery.of(context).size.height * 0.015,
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Level(level: snapshot.data['level']),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    ReputationMarks(reputation: snapshot.data["reputation"]),
                  ],
                )
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05
              ),
              Center(
                child: Text(
                  'Recent marks',
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.underline
                  )
                )
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

  Future<Map> getUserInfo() async {
    String url = 'https://markit-api.azurewebsites.net/user/$userId';
    // Map response = await apiService.getMap(url);
    // print('response: $response');
    return await apiService.getMap(url);
  }
}