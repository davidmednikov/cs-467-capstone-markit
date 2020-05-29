import 'package:flutter/material.dart';

import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/profile/components/total_marks.dart';

class TotalMarks extends StatelessWidget {

  int totalMarks;

  ApiService apiService = new ApiService();

  TotalMarks({Key key, this.totalMarks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$totalMarks',
      style: TextStyle(
        color: Colors.deepOrange,
        fontSize: 20,
        fontWeight: FontWeight.bold
      )
    );
  }
}

//   Future<int> getMarks() async {
//     final int userId = await apiService.getUserId();
//     String ratingsUrl = 'https://markit-api.azurewebsites.net/user/$userId/ratings';
//     final Map ratingsResponse = await apiService.getMap(ratingsUrl);
//     final int ratings = ratingsResponse['totalRecords'];
//     String pricesUrl = 'https://markit-api.azurewebsites.net/user/$userId/prices';
//     final Map pricesResponse = await apiService.getMap(pricesUrl);
//     final int prices = pricesResponse['totalRecords'];
//     return ratings + prices;
//   }

//   Widget showMarksOrLoading(AsyncSnapshot<int> snapshot) {
//     if (snapshot.hasData) {
//       return Text(
//         snapshot.data.toString(),
//         style: TextStyle(
//           color: Colors.deepOrange,
//           fontSize: 20,
//           fontWeight: FontWeight.bold
//         )
//       );
//     }
//     return Center(
//       child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange)),
//     );
//   }
// }