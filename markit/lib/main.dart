import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markit/components/mark_price/pages/mark_price.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:markit/components/authentication/pages/login.dart';
import 'package:markit/components/authentication/pages/registration.dart';
import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/service/auth_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);
  await DotEnv().load('env/api_key.env'); // API Key
  AuthService authService = new AuthService();
  String token = await authService.getToken();
  runApp(Markit(token: token));
}

class Markit extends StatelessWidget {
  String token;

  GlobalKey<BottomScaffoldState> bottomScaffoldKey = new GlobalKey();

  Markit({Key key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Markit',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routes: getRoutes(),
        initialRoute: getInitialRoute(),
      ),
    );
  }

  String getInitialRoute() {
    if (token != 'NOT_AUTHENTICATED') {
      return '/';
    }
    return 'auth';
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      'auth': (context) => LoginScreen(),
      '/': (context) => BottomScaffold(key: bottomScaffoldKey),
      'register': (context) => RegistrationScreen(),
      'markit': (context) => MarkPrice(),
    };
  }
}
