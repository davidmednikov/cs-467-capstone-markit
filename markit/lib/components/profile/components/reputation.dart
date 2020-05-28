import 'package:flutter/material.dart';

import 'package:markit/components/profile/components/total_marks.dart';

class ReputationMarks extends StatelessWidget {

  int reputation;
  int totalMarks;

  ReputationMarks({Key key, this.reputation, this.totalMarks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015
        ),
        Text(
          'Reputation:',
          style: TextStyle(
            fontSize: 18,
          )
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01
        ),
        Text(
          reputation.toString(),
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