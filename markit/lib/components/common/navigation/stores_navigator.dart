import 'package:flutter/material.dart';

import 'package:markit/components/common/navigation/navigation_options.dart';
import 'package:markit/components/common/navigation/tab_navigator.dart';
import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/store/pages/view_store.dart';
import 'package:markit/components/store/pages/view_store_map.dart';
import 'package:markit/components/store/pages/view_stores.dart';

class StoresNavigator extends StatefulWidget {

  StoreModel storeArg;

  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  StoresNavigator({Key key, this.storeArg, this.bottomScaffoldKey}) : super(key: key);

  GlobalKey<ViewStoresState> viewStoresKey = new GlobalKey();
  GlobalKey<ViewStoreState> viewStoreKey = new GlobalKey();
  GlobalKey<ViewStoreMapState> viewStoreMapKey = new GlobalKey();

  @override
  StoresNavigatorState createState() => StoresNavigatorState();
}

class StoresNavigatorState extends State<StoresNavigator> {

  @override
  Widget build(BuildContext context) {
    return TabNavigator(
      deepLinkInitRoute: widget.storeArg == null ? '/' : 'view',
      routesToPagesMap: getStoresRoutes(widget.viewStoresKey, widget.viewStoreKey, widget.viewStoreMapKey, widget.bottomScaffoldKey, storeArg: widget.storeArg),
    );
  }

  void navigateToAddRating() async {
    if (widget.viewStoreKey.currentState == null) {
      StoreModel store = await widget.viewStoresKey.currentState.widget.viewStoresPageKey.currentState.promptForStore();
      if (store != null) {
        widget.bottomScaffoldKey.currentState.dynamicFabState.currentState.changePage('addRating');
        Map arguments = {
          'store': store,
          'pickedFromList': true,
        };
        Navigator.of(widget.viewStoresKey.currentState.widget.viewStoresPageKey.currentContext).pushNamed('addRating', arguments: arguments);
      }
    } else {
      StoreModel store = widget.viewStoreKey.currentState.store;
      widget.bottomScaffoldKey.currentState.dynamicFabState.currentState.changePage('addRating');
      Map arguments = {
        'store': store,
        'pickedFromList': false,
      };
      Navigator.of(widget.viewStoreKey.currentContext).pushNamed('addRating', arguments: arguments);
    }
  }

  void popBackToStorePage() async {
    if (widget.viewStoreKey.currentState == null) {
      widget.bottomScaffoldKey.currentState.dynamicFabState.currentState.changePage('viewStores');
      Navigator.of(widget.viewStoresKey.currentContext).pop();
    } else if (widget.viewStoreMapKey.currentState == null) {
      widget.bottomScaffoldKey.currentState.dynamicFabState.currentState.changePage('viewStore');
      Navigator.of(widget.viewStoreKey.currentContext).pop();
    } else {
      widget.bottomScaffoldKey.currentState.dynamicFabState.currentState.changePage('viewStoreMap');
      Navigator.of(widget.viewStoreMapKey.currentContext).pop();
    }
  }
}