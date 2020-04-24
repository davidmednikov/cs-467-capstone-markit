import 'package:flutter/material.dart';

import '../navigation/navigation_options.dart';

class TopScaffold extends StatelessWidget {

  String title;

  Widget view;

  TopScaffold({Key key, this.title, this.view }) : super(key: key);

  // @override
  // void initState() {
  //   super.initState();
  //   _title = _navOptions[_selectedIndex].title;
  //   _navTabs = getNavTabViews(_myListsState);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(title),
        ),
        // leading: BackButton(
        //   onPressed: () => {
        //     print(ModalRoute.of(_myListsState.currentState.context).settings.name)
        //     // print(Navigator.of(_myListsState.currentState.context))
        //     // Navigator.of(_myListsState.currentState.context).pop();
        //   }),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: view,
        ),
      ),
    );
  }
}