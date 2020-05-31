import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:markit/components/mark_price/components/mark_price_tags.dart';
import 'package:markit/components/models/item_price_model.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/service/google_maps_api_service.dart';
import 'package:markit/components/service/location_service.dart';
import 'package:markit/components/service/notification_service.dart';
import 'package:markit/components/service/tag_service.dart';

class ItemForm extends StatefulWidget {
  final String upc;
  final List<Map> matchingTags;
  final Location location;
  final StoreModel guessedStore;

  ItemForm({Key key, this.upc, this.matchingTags, this.location, this.guessedStore}) : super(key: key);

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final GlobalKey<MarkPriceTagsState> _markPriceTagsStateKey = GlobalKey<MarkPriceTagsState>();

  String mapsApiKey;

// how should item/store internal ids be generated - is this done automatically by the API?
  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();
  GoogleMapsApiService googleMapsApiService = new GoogleMapsApiService();
  LocationService locationService = new LocationService();
  NotificationService notificationService = new NotificationService();
  TagService tagService = new TagService();

  ItemPriceModel newItem = ItemPriceModel(tags: [], isSalePrice: false);

  bool changedStore = false;
  StoreModel selectedStore;

  bool buttonPressed = false;

  @override
  void initState() {
    super.initState();
    mapsApiKey = GoogleMapsApiService.mapsKey;
    if (!changedStore) {
      selectedStore = widget.guessedStore;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.025,
          horizontal: MediaQuery.of(context).size.width * 0.04,
        ),
        child: ListView(
          children: [
            Row(
              children: [
               Opacity(
                    opacity: 0.7,
                    child: Text('Tags for this item:', style: GoogleFonts.lato(fontSize: 20, color: Colors.black)),
                  ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: MarkPriceTags(key: _markPriceTagsStateKey, tagStateKey: _tagStateKey, existingTags: widget.matchingTags.map((tag) => tag['name'].toString()).toList()),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                 padding: EdgeInsets.only(top: 15),
                 child: Opacity(
                    opacity: 0.7,
                    child: Text('Tap to change your store:', style: GoogleFonts.lato(fontSize: 20, color: Colors.black)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.locationArrow, color: Colors.deepOrange),
                            title: Text(selectedStore.name),
                            subtitle: Text(selectedStore.streetAddress),
                            onTap: () async {
                              Prediction p = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: mapsApiKey,
                                mode: Mode.overlay,
                                language: 'en',
                                location: widget.location,
                                types: ['establishment'],
                                radius: 500,
                              );
                              displayPrediction(p);
                            },
                          )
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[100], width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                 padding: EdgeInsets.only(top: 15),
                 child: Opacity(
                    opacity: 0.7,
                    child: Text('Enter the price:', style: GoogleFonts.lato(fontSize: 20, color: Colors.black)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixText: "\$ ",
                        contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Add item price.";
                        } else if (double.tryParse(value.trim()) == null) {
                          return "Price must be a number.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        newItem.price = double.parse(value.trim());
                      },
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                          BlacklistingTextInputFormatter(RegExp("[^0-9.]")),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "On \$ale?",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
                Switch(
                  value: newItem.isSalePrice,
                  onChanged: (value) => setState(() => newItem.isSalePrice = value),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          int userId = await authService.getUserIdFromStorage();
                          List<String> tagsToSubmit = createTagsForSubmittal(_markPriceTagsStateKey.currentState.tags);
                          if (tagsToSubmit.isEmpty) {
                            String input = _markPriceTagsStateKey.currentState.widget.tagStateKey.currentState.lastInput;
                            if (input.length >= 3) {
                              tagsToSubmit = createTagsListFromInput(input);
                            } else {
                              notificationService.showErrorNotification('Need at least 1 tag.');
                            }
                          }
                          if (tagsToSubmit.isNotEmpty) {
                            setState(() {
                              buttonPressed = true;
                              newItem.userId = userId;
                              newItem.tags = tagsToSubmit;
                            });

                            int storeId = newItem.storeId != null ? newItem.storeId : widget.guessedStore.id;

                            final Map<String, Object> itemPost = {
                              "userId": newItem.userId,
                              "storeId": storeId,
                              "upc": widget.upc,
                              "price": newItem.price,
                              "isSalePrice": newItem.isSalePrice,
                              "tags": newItem.tags
                            };
                            final Map<String, Object> response = await addItem(itemPost);
                            setState(() => buttonPressed = false);
                            if (response.isNotEmpty) {
                              Navigator.pop(context);
                              notificationService.showSuccessNotification('Price added.');
                            } else {
                              notificationService.showErrorNotification('Error adding price.');
                            }
                          }
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      color: Colors.deepOrange,
                      padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                      child: showTextOrLoading(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showTextOrLoading() {
    if (buttonPressed) {
      return Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        )
      );
    }
    return Center(
      child: Text(
        "Markit!",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )
      )
    );
  }

  static List<String> createTagsForSubmittal(tags) {
    List<String> createdTags = [];
    tags.forEach((tag) => createdTags.add(tag.title));
    return createdTags;
  }

  static List<String> createTagsListFromInput(String input) {
    return [input];
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse details = await GoogleMapsPlaces(apiKey: mapsApiKey).getDetailsByPlaceId(p.placeId);
      StoreModel store = googleMapsApiService.castPlaceDetailsToStoreModel(details.result);
      Map<String, Object> storeMap = {
        'googleId': store.googleId,
        'name': store.name,
        'streetAddress': store.streetAddress,
        'city': store.city,
        'state': store.state,
        'postalCode': store.postalCode,
        'coordinate': {
          'latitude': store.latitude,
          'longitude': store.longitude,
        }
      };

      Map<String, Object> response = await addStore(storeMap);
      final int storeId = response['id'];

      setState(() {
        newItem.storeId = storeId;
        selectedStore = store;
      });
    }
  }

  Future<Map> addStore(newStore) {
    String url = 'https://markit-api.azurewebsites.net/store';
    return apiService.postResponseMap(url, newStore);
  }

  Future<Map> addItem(newItem) {
    String url = 'https://markit-api.azurewebsites.net/item';
    return apiService.postResponseMap(url, newItem);
  }
}