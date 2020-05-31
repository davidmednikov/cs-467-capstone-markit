import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/bottom_scaffold.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/store/components/store.dart';

class ViewStore extends StatefulWidget {

  StoreModel storeArg;

  GlobalKey<BottomScaffoldState> bottomScaffoldKey;

  ViewStore({Key key, this.storeArg, this.bottomScaffoldKey}) : super(key: key);

  @override
  _ViewStoreState createState() => _ViewStoreState();
}

class _ViewStoreState extends State<ViewStore> {

  StoreModel store;

  @override
  Widget build(BuildContext context) {
    if (widget.storeArg == null) {
      store = ModalRoute.of(context).settings.arguments;
    } else {
      store = widget.storeArg;
    }
    return TopScaffold(
      title: 'View Store',
      view: Store(store: store, bottomScaffoldKey: widget.bottomScaffoldKey),
      noPadding: true,
    );
  }
}