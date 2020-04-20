import 'package:flutter/material.dart';

class ViewStores extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stores Near Me'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Placeholder(),
        ),
      ),
    );
  }
}