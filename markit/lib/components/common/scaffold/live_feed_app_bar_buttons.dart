import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:markit/components/live_feed/pages/live_feed.dart';

class LiveFeedAppBarButtons extends StatefulWidget implements PreferredSizeWidget {

  GlobalKey<LiveFeedState> liveFeedKey;

  LiveFeedAppBarButtons({Key key, this.liveFeedKey }) : super(key: key);

  @override
  _LiveFeedAppBarButtonsState createState() => _LiveFeedAppBarButtonsState();

  @override
  Size get preferredSize => TabBar(tabs: []).preferredSize;
}

class _LiveFeedAppBarButtonsState extends State<LiveFeedAppBarButtons> {

  static List<String> viewOptions = ['All', 'Prices', 'Reviews'];
  String view = viewOptions[0];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(accentColor: Colors.white),
      child: Expanded(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: () => changeView(viewOptions[0]),
                      shape: StadiumBorder(),
                      color: getButtonColor(viewOptions[0]),
                      child: Row(
                          children: [
                            Expanded(
                              child: Text(viewOptions[0], style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: FaIcon(FontAwesomeIcons.rss),
                              ),
                            ),
                          ],
                        ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: () => changeView(viewOptions[1]),
                      shape: StadiumBorder(),
                      color: getButtonColor(viewOptions[1]),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(viewOptions[1], style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: FaIcon(FontAwesomeIcons.tags)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: () => changeView(viewOptions[2]),
                      shape: StadiumBorder(),
                      color: getButtonColor(viewOptions[2]),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(viewOptions[2], style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.rate_review, size: 28),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeView(String selectedView) async {
    final ProgressDialog dialog = ProgressDialog(context);
    await dialog.show();
    widget.liveFeedKey.currentState.changeSelected(selectedView);
    setState(() {
      view = selectedView;
    });
    await dialog.hide();
  }

  Color getButtonColor(String id) {
    if (id == view) {
      return Color(0xffffc422);
    }
    return Colors.white;
  }
}