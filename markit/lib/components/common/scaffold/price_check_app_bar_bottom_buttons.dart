import 'package:flutter/material.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as flutter_rating_bar;
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rating_bar/rating_bar.dart' as rating_bar;

import 'package:markit/components/shopping_list/components/price_check_list.dart';

class PriceCheckAppBarButtons extends StatefulWidget implements PreferredSizeWidget {

  List<Widget> buttons;

  GlobalKey<PriceCheckListState> priceCheckListKey;

  PriceCheckAppBarButtons({Key key, this.buttons, this.priceCheckListKey }) : super(key: key);

  @override
  _PriceCheckAppBarButtonsState createState() => _PriceCheckAppBarButtonsState();

  @override
  Size get preferredSize => TabBar(tabs: []).preferredSize;
}

class _PriceCheckAppBarButtonsState extends State<PriceCheckAppBarButtons> {

  bool starFilterEnabled = false;
  double minStars = 0;

  String sort = 'Price Only';
  List<String> sortOptions = ['Price Only', 'Price & Staleness', 'Staleness Only'];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(accentColor: Colors.white),
      child: Expanded(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: ShapeDecoration(shape: StadiumBorder(), color: Colors.white),
                    margin: EdgeInsets.only(top: 6, left: 15),
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: sort,
                        icon: FaIcon(FontAwesomeIcons.sortAmountDown, color: Colors.deepOrange),
                        onChanged: (String newValue) {
                          widget.priceCheckListKey.currentState.changeSorting(newValue);
                          setState(() {
                            sort = newValue;
                          });
                        },
                        style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                        items: sortOptions.map((option) => DropdownMenuItem(
                          value: option,
                          child: Center(
                            child: Text(
                              option,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )).toList(),
                        isExpanded: true,
                        isDense: true,
                      )
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: starFilter,
                      shape: StadiumBorder(),
                      color: getStarFilterColor(),
                      child: rating_bar.RatingBar.readOnly(
                        initialRating: minStars,
                        isHalfAllowed: false,
                        emptyIcon: FontAwesomeIcons.star,
                        filledIcon: FontAwesomeIcons.solidStar,
                        size: 20,
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

  Color getStarFilterColor() {
    if (starFilterEnabled) {
      return Color(0xffffc422);
    }
    return Colors.white;
  }

  void starFilter() {
    EasyDialog(
      cornerRadius: 15.0,
      fogOpacity: 0.1,
      width: 280,
      height: 180,
      contentPadding: EdgeInsets.only(top: 12.0), // Needed for the button design
      contentList: [
        FaIcon(FontAwesomeIcons.searchDollar, color: Colors.deepOrange),
        SizedBox(height: 10),
        Text('Minimum store rating:', style: GoogleFonts.lato(fontSize: 18, color: Colors.black)),
        SizedBox(height: 10),
        Expanded(
          child: Container(
            child: Builder(
            builder: (context) =>
              flutter_rating_bar.RatingBar(
                initialRating: minStars,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                ratingWidget: flutter_rating_bar.RatingWidget(
                  empty: FaIcon(FontAwesomeIcons.star, color: Color(0xffffc422)),
                  half: FaIcon(FontAwesomeIcons.solidStar, color: Color(0xffffc422)),
                  full: FaIcon(FontAwesomeIcons.solidStar, color: Color(0xffffc422))
                ),
                onRatingUpdate: (rating) {
                  minStars = rating;
                  starFilterEnabled = true;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffff2226),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)
            )
          ),
          child: Builder(
            builder: (context) =>
              FlatButton(
                onPressed: () {
                  minStars = 0;
                  starFilterEnabled = false;
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Text("Cancel",
                  textScaleFactor: 1.3,
                ),
              ),
          ),
        ),
      ],
    ).show(context);
  }
}