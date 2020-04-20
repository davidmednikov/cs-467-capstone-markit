import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/common/scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);
  runApp(Markit());
}

class Markit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markit',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MarkitScaffold(),
    );
  }
}
