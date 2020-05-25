import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:markit/components/service/google_maps_api_service.dart';
import 'package:markit/components/store/pages/view_stores.dart';

class ViewStoresAppBarButtons extends StatefulWidget implements PreferredSizeWidget {

  List<Widget> buttons;

  GlobalKey<ViewStoresState> viewStoresKey;

  ViewStoresAppBarButtons({Key key, this.buttons, this.viewStoresKey }) : super(key: key);

  GoogleMapsApiService google = new GoogleMapsApiService();

  @override
  _ViewStoresAppBarButtonsState createState() => _ViewStoresAppBarButtonsState();

  @override
  Size get preferredSize => TabBar(tabs: []).preferredSize;
}

class _ViewStoresAppBarButtonsState extends State<ViewStoresAppBarButtons> {

  Position location;

  String mapsApiKey;

  String view = 'List View';
  List<String> viewOptions = ['List View', 'Map View'];

  @override
  Widget build(BuildContext context) {
    mapsApiKey = GoogleMapsApiService.mapsKey;
    location = widget.viewStoresKey.currentState.location;
    return Theme(
      data: Theme.of(context).copyWith(accentColor: Colors.white),
      child: Expanded(
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: getNewLocation,
                      shape: StadiumBorder(),
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text('My Location', style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: FaIcon(FontAwesomeIcons.locationArrow, size: 16)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: ShapeDecoration(shape: StadiumBorder(), color: Colors.white),
                    margin: EdgeInsets.only(top: 6, left: 15, right: 10),
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: view,
                        icon: Container(height: 0, width: 0),
                        onChanged: (String newValue) {
                          widget.viewStoresKey.currentState.widget.viewStoresPageKey.currentState.toggleMapView(newValue);
                          setState(() {
                            view = newValue;
                          });
                        },
                        style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                        items: viewOptions.map((option) {
                          Widget icon;
                          if (option == 'List View') {
                            icon = FaIcon(FontAwesomeIcons.listOl);
                          } else {
                            icon = FaIcon(FontAwesomeIcons.mapMarkedAlt);
                          }
                          return DropdownMenuItem(
                            value: option,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(option, textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: icon
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        isExpanded: true,
                        isDense: true,
                      )
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getNewLocation() async {
    if (location == null) {
      location = widget.viewStoresKey.currentState.location;
    }
    double lat = location.latitude;
    double lang =  location.longitude;
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: mapsApiKey,
      mode: Mode.overlay,
      language: 'en',
      location: Location(lat, lang), // why this crashes
    );
    changeLocation(p);
  }

  Future<Null> changeLocation(Prediction p) async {
    if (p != null) {
      final ProgressDialog dialog = ProgressDialog(context);
      await dialog.show();
      PlacesDetailsResponse details = await GoogleMapsPlaces(apiKey: mapsApiKey).getDetailsByPlaceId(p.placeId);
      Position newLocation = Position(latitude: details.result.geometry.location.lat, longitude: details.result.geometry.location.lng);
      widget.viewStoresKey.currentState.changeLocation(newLocation);
      await dialog.hide();
    }
  }
}