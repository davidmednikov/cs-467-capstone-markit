import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/authentication/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);
  AuthService authService = new AuthService();
  authService.logout();
  authService.storeUsername('test3');
  authService.storePassword('password');
  String token = await authService.getToken();
  runApp(Markit(token: token));
}

class Markit extends StatelessWidget {
  String token;

  Markit({Key key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Markit',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        routes: getRoutes(),
        initialRoute: getInitialRoute(),
      ),
    );
  }

  String getInitialRoute() {
    if (token != 'NOT_AUTHENTICATED') {
      return 'home';
    }
    return 'auth';
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      'auth': (context) => LoginScreen(),
      'home': (context) => BottomScaffold(),
    };
  }
}
