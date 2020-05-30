import 'package:flutter/material.dart';

import 'package:markit/components/profile/components/total_marks.dart';

class RatingMarks extends StatelessWidget {

  int rating;
  int totalMarks;

  RatingMarks({Key key, this.rating, this.totalMarks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015
        ),
        Text(
          'Store rating:',
          style: TextStyle(
            fontSize: 18,
          )
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01
        ),
        Text(
          rating.toString(),
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02
        ),
        Text(
          'Total marks:',
          style: TextStyle(
            fontSize: 18,
          )
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01
        ),
        TotalMarks(totalMarks: totalMarks),
      ],
    );
  }
}