import 'package:flutter/material.dart';

class ReputationMarks extends StatelessWidget {

  int reputation;
  int marks;

  ReputationMarks({Key key, this.reputation, this.marks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
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
        // Text(
        //   'Total Marks:',
        //   style: TextStyle(
        //     fontSize: 18,
        //   )
        // ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.01
        // ),
        // Text(
        //   marks.toString(),
        //   style: TextStyle(
        //     fontSize: 20,
        //     color: Colors.deepOrange,
        //     fontWeight: FontWeight.bold
        //   )
        // )
      ],
    );
  }
}