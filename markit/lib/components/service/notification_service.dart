import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationService {
  Color _errorColor =  Color(0xfffff2226);
  Color _successColor =  Color(0xff22cbff);

  void showSuccessNotification(String message) {
    showSimpleNotification(
      Text(message),
      background: _successColor,
    );
  }

  void showErrorNotification(String error) {
    showSimpleNotification(
      Text(error),
      background: _errorColor,
    );
  }
}
