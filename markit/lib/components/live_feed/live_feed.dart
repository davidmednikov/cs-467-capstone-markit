import 'package:flutter/material.dart';

class LiveFeed extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Feed'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Placeholder(),
        ),
      ),
    );
  }
}