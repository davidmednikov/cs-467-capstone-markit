import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationService {
  Color _errorColor =  Color(0xfffff2226);
  Color _warningColor = Color(0xffffc422);
  Color _successColor =  Color(0xff22cbff);

  void showSuccessNotification(String message) {
    showSimpleNotification(
      Text('Success'),
      subtitle: Text(message),
      leading: Padding(
        padding: EdgeInsets.only(top: 6),
        child: FaIcon(FontAwesomeIcons.check),
      ),
      background: _successColor,
      foreground: Colors.white,
      slideDismiss: true,
    );
  }

  void showWarningNotification(String warning) {
    showSimpleNotification(
      Text('Warning'),
      subtitle: Text(warning),
      leading: Padding(
        padding: EdgeInsets.only(top: 6),
        child: FaIcon(FontAwesomeIcons.exclamation),
      ),
      background: _warningColor,
      foreground: Colors.black,
      slideDismiss: true,
    );
  }

  void showErrorNotification(String error) {
    showSimpleNotification(
      Text('Error'),
      subtitle: Text(error),
      leading: Padding(
        padding: EdgeInsets.only(top: 6),
        child: FaIcon(FontAwesomeIcons.times),
      ),
      background: _errorColor,
      foreground: Colors.white,
      slideDismiss: true,
    );
  }
}
