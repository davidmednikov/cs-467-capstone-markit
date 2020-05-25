import 'package:flutter/material.dart';

class StoreListing extends StatelessWidget {
  final String name;
  final String streetAddress;
  final String city;
  final String state;
  final String postalCode;

  StoreListing({Key key, this.name, this.streetAddress, this.city, this.state, this.postalCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            )),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text('$streetAddress'),
          Text('$city, $state $postalCode'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ],
      )
    );
  }
}