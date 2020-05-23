import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markit/components/service/google_maps_api_service.dart';
import 'package:overlay_support/overlay_support.dart'; // still need to display post-scan notification

import 'package:markit/components/models/item_price_model.dart';
import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/mark_price/components/tags.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/location_service.dart';
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

  String mapsApiKey;

// how should item/store internal ids be generated - is this done automatically by the API?
  ApiService apiService = new ApiService();
  GoogleMapsApiService googleMapsApiService = new GoogleMapsApiService();
  LocationService locationService = new LocationService();
  TagService tagService = new TagService();

  ItemPriceModel newItem = ItemPriceModel(tags: [], isSalePrice: false);

  bool changedStore = false;
  StoreModel selectedStore;

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
                    child: MarkPriceTags(tagStateKey: _tagStateKey, existingTags: widget.matchingTags.map((tag) => tag['name'].toString()).toList()),
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
                    )
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.05,
              child: RaisedButton(
                onPressed: () async {
// Google Places API autocomplete implemented using flutter_google_places plugin at https://pub.dev/packages/flutter_google_places
                  print('hi');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  "Enter a store",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  )),
                color: Colors.deepOrange
              )
            ),
            SizedBox(
              height: 30
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter a price",
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0)
                    ),
                    validator: (value) {
// may need to add more validation here
                      if (value.isEmpty) {
                        return "Please add the listed item price.";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      newItem.price = double.parse(value.trim());
                    }
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CheckboxListTile(
                    title: Text(
                      "On sale?",
                      style: TextStyle(
                        color: Colors.grey[600]
                      )),
                    value: newItem.isSalePrice,
                    onChanged: (value) => setState(() => newItem.isSalePrice = value)
                  )
                )
              ],
            ),
            SizedBox(
              height: 30
            ),
            // RaisedButton(
            //   onPressed: () async {
            //     if (_formKey.currentState.validate()) {
            //       _formKey.currentState.save();
            //       int userId = await apiService.getUserId();
            //       List<String> tagsToSubmit = createTagsForSubmittal(createdTags);
            //       setState(() {
            //         newItem.userId = userId;
            //         newItem.tags = tagsToSubmit;
            //       });

            //       const url = "https://markit-api.azurewebsites.net/item";
            //       final Map<String, Object> itemPost = {
            //         "userId": newItem.userId,
            //         "storeId": newItem.storeId,
            //         "upc": "123456789123",
            //         "price": newItem.price,
            //         "isSalePrice": newItem.isSalePrice,
            //         "tags": newItem.tags
            //       };
            //       final Map<String, Object> response = await addItem(itemPost);
            //       if (response.isNotEmpty) {
            //         Navigator.pushNamed(context, '/'); // need to navigate to correct route
            //       } else {
            //         showSimpleNotification(
            //           Text('An error occurred when saving the item. Please try again!'),
            //           background: Color(0xfffff2226),
            //         );
            //       }
            //     }
            //   },
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(10))
            //   ),
            //   color: Colors.deepOrange,
            //   padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
            //   child: Text(
            //     "Markit!",
            //     style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white,
            //     )
            //   )
            // ),
          ])
      )
    );
  }

  static List<String> createTagsForSubmittal(tags) {
    List<String> createdTags = [];
    tags.forEach((tag) => createdTags.add(tag.title));
    return createdTags;
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse details = await GoogleMapsPlaces(apiKey: mapsApiKey).getDetailsByPlaceId(p.placeId);
      StoreModel store = googleMapsApiService.castPlaceDetailsToStoreModel(details.result);
      Map<String, Object> storeMap = {
        'googlePlaceId': store.googlePlaceId,
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