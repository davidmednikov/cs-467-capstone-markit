import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:markit/components/mark_price/components/item_form.dart';
import 'package:markit/components/service/api_service.dart';

class MarkPrice extends StatefulWidget {

  final int upc;

  MarkPrice({Key key, this.upc}) : super(key: key);

  @override
  _MarkPriceState createState() => _MarkPriceState();
}

class _MarkPriceState extends State<MarkPrice> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ApiService apiService = new ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mark Your Price'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ItemForm(),
        ),
      ),
    );
  }
}

void showNotification(String message) {
  showSimpleNotification(
    Text(message),
    background: Color(0xff22cbff),
  );
}