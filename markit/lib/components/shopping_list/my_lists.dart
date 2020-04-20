import 'package:flutter/material.dart';

class MyLists extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Lists'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Placeholder(),
        ),
      ),
    );
  }
}