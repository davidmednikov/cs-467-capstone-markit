import 'package:flutter/material.dart';

class MarkPrice extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mark Price'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Placeholder(),
        ),
      ),
    );
  }
}