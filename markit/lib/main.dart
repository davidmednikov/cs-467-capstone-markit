import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/live_feed/live_feed.dart';
import 'components/mark_price/mark_price.dart';
import 'components/profile/my_profile.dart';
import 'components/shopping_list/my_lists.dart';
import 'components/store/view_stores.dart';

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
        primarySwatch: Colors.deepPurple,
      ),
      routes: getRoutes(),
      initialRoute: '/',
    );
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => MyLists(),
      // 'addList': (context) => AddList(),
      // 'viewList': (context) => ViewLists(),
      'markPrice': (context) => MarkPrice(),
      'liveFeed': (context) => LiveFeed(),
      'stores': (context) => ViewStores(),
      // 'store': (context) => ViewStore(),
      'profile': (context) => MyProfile(),
    };
  }
}
