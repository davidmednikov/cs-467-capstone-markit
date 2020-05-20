import 'package:google_maps_webservice/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:overlay_support/overlay_support.dart'; // still need to display post-scan notification

import 'package:markit/components/mark_price/credentials/credentials.dart';
import 'package:markit/components/models/item_price_model.dart';
import 'package:markit/components/service/api_service.dart';

class ItemForm extends StatefulWidget {
  final String upc;
  ItemForm({Key key, this.upc}) : super(key: key);

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

// how should item/store internal ids be generated - is this done automatically by the API?
  ApiService apiService = new ApiService();
  ItemPriceModel newItem = ItemPriceModel(tags: [], isSalePrice: false);

  static final storedTags = [
    {
      "id": 239479832742,
      "name": "Dawn Ultra, 28oz"
    },
    {
      "id": 239479832743,
      "name": "Dish soap, 28oz"
    }
  ];
  List<Item> createdTags = createTagsFromStored(storedTags);

// lines 42-50 hold logic for getting tags from database using upc
  // Map<String, Object> storedTags;
  // List<Item> createdTags;

  // @override
  // void initState() {
  //   getTags(widget.upc, storedTags);
  //   createdTags = createTagsFromStored(storedTags);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.025,
          horizontal: MediaQuery.of(context).size.width * 0.05
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
// tags functionality implemented using flutter_tags plugin at https://pub.dev/packages/flutter_tags
                  child: Tags(
                    key: _tagStateKey,
// how to cause text field to turn app theme color (deepOrange) after selection?
                    textField: TagsTextField(
                      textStyle: TextStyle(fontSize: 16),
                      onSubmitted: (newTagStr) {
                        setState(() {
                          createdTags.add(Item(
                            index: createdTags.length,
                            title: newTagStr,
                            active: true,
                            customData: true
                          ));
                        });
                      },
                    ),
                    itemCount: createdTags.length,
                    itemBuilder: (int index) {
                      final item = createdTags[index];
                      if (item.customData == true) {
                        return ItemTags(
                          key: Key(index.toString()),
                          index: index,
                          title: item.title,
                          active: true,
                          textStyle: TextStyle(fontSize: 16),
                          activeColor: Colors.deepOrange,
                          combine: ItemTagsCombine.withTextBefore,
                          removeButton: ItemTagsRemoveButton(
                            onRemoved: () {
                              setState(() {
                                createdTags.removeAt(index);
                              });
                              return true;
                            }
                          ),
                          pressEnabled: false,
                        );
                      } else {
                        return ItemTags(
                          key: Key(index.toString()),
                          index: index,
                          title: item.title,
                          active: true,
                          textStyle: TextStyle(fontSize: 16),
                          activeColor: Colors.deepOrange,
                          combine: ItemTagsCombine.withTextBefore,
                          pressEnabled: false,
                        );
                      }
                    }
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.05,
              child: RaisedButton(
                onPressed: () async {
// Google Places API autocomplete implemented using flutter_google_places plugin at https://pub.dev/packages/flutter_google_places
                  Prediction p = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: PLACES_API_KEY,
                    mode: Mode.overlay,
                    language: 'en',
                  );
                  displayPrediction(p);
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
              children: <Widget>[
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
            RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  int userId = await apiService.getUserId();
                  List<String> tagsToSubmit = createTagsForSubmittal(createdTags);
                  setState(() {
                    newItem.userId = userId;
                    newItem.tags = tagsToSubmit;
                  });

                  const url = "https://markit-api.azurewebsites.net/item";
                  final Map<String, Object> itemPost = {
                    "userId": newItem.userId,
                    "storeId": newItem.storeId,
                    "upc": "123456789123",
                    "price": newItem.price,
                    "isSalePrice": newItem.isSalePrice,
                    "tags": newItem.tags
                  };
                  final Map<String, Object> response = await addItem(itemPost);
                  if (response.isNotEmpty) {
                    Navigator.pushNamed(context, 'home'); // need to navigate to correct route
                  } else {
                    showSimpleNotification(
                      Text('An error occurred when saving the item. Please try again!'),
                      background: Color(0xfffff2226),
                    );
                  }
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              color: Colors.deepOrange,
              padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
              child: Text(
                "Markit!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )
              )
            ),
          ])
      )
    );
  }

  static List<Item> createTagsFromStored(tags) {
    List<Item> createdTags = [];
    int ind = 0;
    tags.forEach((tag) => {
      createdTags.add(
        Item(
          index: ind,
          title: tag["name"].toString(),
          active: true,
          customData: false
        )
      )
    });
    ind++;
    return createdTags;
  }

  static List<String> createTagsForSubmittal(tags) {
    List<String> createdTags = [];
    tags.forEach((tag) => createdTags.add(tag.title));
    return createdTags;
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse details = await GoogleMapsPlaces(apiKey: PLACES_API_KEY).getDetailsByPlaceId(p.placeId);
      var addrData = details.result.addressComponents;
      var returnedStreetAddress, city, state, postalCode;

      if (addrData[0].types[0] == 'floor') {
        returnedStreetAddress = '${addrData[1].longName} ${addrData[2].longName}';
      } else {
        returnedStreetAddress = '${addrData[0].longName} ${addrData[1].longName}';
      }

      addrData.forEach((addrComponent) {
        addrComponent.types.forEach((type) {
          if (type == "locality") {
            city = addrComponent.longName;
          }
          else if (type == "administrative_area_level_1") {
            state = addrComponent.longName;
          }
          else if (type == "postal_code") {
            postalCode = addrComponent.longName;
          }
        });
      });

      Map<String, Object> selectedStore = {
        'googleId': p.placeId,
        'name': details.result.name,
        'streetAddress': returnedStreetAddress,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'coordinate': {
          'latitude': details.result.geometry.location.lat,
          'longitude': details.result.geometry.location.lng,
        }
      };

      Map<String, Object> response = await addStore(selectedStore);
      final int storeId = response['id'];

      setState(() => newItem.storeId = storeId);
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

  void getTags(upc, storedTags) async {
    String url = 'https://markit-api.azurewebsites.net/query?upc=$upc';
     storedTags = await apiService.getMap(url);
  }
}