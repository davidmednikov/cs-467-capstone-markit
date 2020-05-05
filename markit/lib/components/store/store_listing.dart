import 'package:flutter/material.dart';

class StoreListing extends StatelessWidget {
  final String name;
  final String city;
  final String state;

  StoreListing({Key key, this.name, this.city, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Spacer(flex:2),
          Text(name),
          Spacer(flex:1),
          Text(city),
          Text(state),
          Spacer(flex:2)
        ],
      )
    );
  }
}