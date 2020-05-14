import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';


class AddRating extends StatefulWidget {
  GlobalKey<DynamicFabState> dynamicFabKey;

  AddRating({Key key, this.dynamicFabKey}) : super(key: key);

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();

  @override
  AddRatingState createState() => AddRatingState();
}

class AddRatingState extends State<AddRating> {

  final formKey = GlobalKey<FormState>();

  ShoppingListModel shoppingList;
  StoreModel store;

  double stars;
  String details;

  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    shoppingList = arguments['shoppingList'];
    store = arguments['store'];
    return WillPopScope(
      child: TopScaffold(
        title: '${store.name}',
        view: Form(
          key: formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Opacity(
                      opacity: 0.7,
                      child: Text('Rating:', style: GoogleFonts.lato(fontSize: 20, color: Colors.black)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[600])),
                        ),
                        child: RatingBar(
                          initialRating: 0,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          ratingWidget: RatingWidget(
                            empty: FaIcon(FontAwesomeIcons.star, color: Color(0xffffc422)),
                            half: FaIcon(FontAwesomeIcons.solidStar, color: Color(0xffffc422)),
                            full: FaIcon(FontAwesomeIcons.solidStar, color: Color(0xffffc422))
                          ),
                          onRatingUpdate: (rating) {
                            stars = rating;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Opacity(
                      opacity: 0.7,
                      child: Text('Tell us about your visit:', style: GoogleFonts.lato(fontSize: 20, color: Colors.black)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Details',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        onSaved: (value) {
                          details = value;
                        },
                        minLines: 4,
                        maxLines: 6,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: RaisedButton(
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            buttonPressed = true;
                            setState( () {} );
                            Map response = await saveComment();
                            if (response['statusCode'] == 200) {
                              notifyFabOfPop();
                              Navigator.of(context).pop();
                              showSimpleNotification(
                                Text('Rating added.'),
                                background: Color(0xff22cbff),
                              );
                            }
                          }
                        },
                        color: Colors.deepOrange,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                          child: Center(
                            child: Icon(Icons.cloud_upload, size: 50, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onWillPop: notifyFabOfPop,
    );
  }

  Future<Map> saveComment() async {
    int userId = await widget.apiService.getUserId();
    String url = 'https://markit-api.azurewebsites.net/rating';
    var body = {
      'userId': userId,
      'store': {
        'id': store.id, // change to an int to make it work. ALso support multiple ratins per user
      },
      'comment': details,
      'points': stars.floor(),
    };
    return widget.apiService.postResponseMap(url, body);
  }

  Future<bool> notifyFabOfPop() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    widget.dynamicFabKey.currentState.changePage('priceCheck');
    return Future.value(true);
  }
}