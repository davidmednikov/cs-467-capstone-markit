import 'package:flutter/material.dart';

class Level extends StatelessWidget {

  String level;

  Level({Key key, this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: MediaQuery.of(context).size.width * 0.5,
    //   height: MediaQuery.of(context).size.width * 0.4,
    //   decoration: BoxDecoration(
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey[700],
    //         blurRadius: 2.0,
    //         spreadRadius: 2.0,
    //       )
    //     ],
    //     color: Colors.deepOrange,
    //     shape: BoxShape.circle,
    //   ),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: <Widget>[
    //       SizedBox(
    //         height: MediaQuery.of(context).size.height * 0.055
    //       ),
    //       Text(
    //         'Level:',
    //         style: TextStyle(
    //           color: Colors.white,
    //           fontSize: 20
    //         )
    //       ),
    //       SizedBox(
    //         height: MediaQuery.of(context).size.height * 0.02
    //       ),
    //       Text(
    //         level,
    //         style: TextStyle(
    //           color: Colors.white,
    //           fontSize: 20,
    //           fontWeight: FontWeight.bold
    //         )
    //       )
    //   ],)
    // );
    return Container(
      padding: EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 8.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[700],
            blurRadius: 2.0,
            spreadRadius: 2.0,
          )
        ],
        color: Colors.deepOrange,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.055
          // ),
          Text(
            'Level:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            )
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015
          ),
          Text(
            level,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
      ],)
    );
  }
}