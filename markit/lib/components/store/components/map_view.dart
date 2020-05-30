import 'package:flutter/material.dart';

class MapView extends StatelessWidget {

  String level;

  MapView({Key key, this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Center(child: Text('Map View'))
    );
  }
}