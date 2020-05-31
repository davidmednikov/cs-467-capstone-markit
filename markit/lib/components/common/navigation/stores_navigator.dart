import 'package:flutter/material.dart';

import 'package:markit/components/common/navigation/navigation_options.dart';
import 'package:markit/components/common/navigation/tab_navigator.dart';
import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/store/pages/view_stores.dart';

class StoresNavigator extends StatefulWidget {

  StoreModel storeArg;

  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  StoresNavigator({Key key, this.storeArg, this.bottomScaffoldKey}) : super(key: key);

  GlobalKey<ViewStoresState> viewStoresKey = new GlobalKey();

  @override
  StoresNavigatorState createState() => StoresNavigatorState();
}

class StoresNavigatorState extends State<StoresNavigator> {

  @override
  Widget build(BuildContext context) {
    return TabNavigator(
      deepLinkInitRoute: widget.storeArg == null ? '/' : 'view',
      routesToPagesMap: getStoresRoutes(widget.viewStoresKey, widget.bottomScaffoldKey, storeArg: widget.storeArg),
    );
  }
}