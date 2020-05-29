import 'package:flutter/material.dart';

import 'package:markit/components/store/components/store.dart';
import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';

class ViewStore extends StatefulWidget {

  int storeId;

  GlobalKey<DynamicFabState> dynamicFabKey;

  ViewStore({Key key, this.storeId, this.dynamicFabKey}) : super(key: key);

  @override
  _ViewStoreState createState() => _ViewStoreState();
}

class _ViewStoreState extends State<ViewStore> {
  @override
  Widget build(BuildContext context) {
    return TopScaffold(
      title: 'View Store',
      view: Store(storeId: widget.storeId)
    );
  }
}