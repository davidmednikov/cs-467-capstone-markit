import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as flutter_location;

import 'package:markit/components/models/store_model.dart';
import 'package:markit/components/service/location_service.dart';

class GoogleMapsApiService {
  static String _googleMapsApiKey = DotEnv().env['KEY'];
  static String get mapsKey => _googleMapsApiKey;

  final LocationService locationService = new LocationService();

  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: mapsKey);

  Future<StoreModel> getClosestStore() async {
    flutter_location.LocationData locationData = await locationService.getLocation();
    PlacesSearchResponse placesResponse = await places.searchNearbyWithRankBy(
      Location(locationData.latitude, locationData.longitude),
      'distance',
      type: 'grocery_or_supermarket',
    );
    print(placesResponse.results);
    if (placesResponse.results.isEmpty) {
      return null;
    }
    PlacesSearchResult store = placesResponse.results[0];
    PlacesDetailsResponse detailsResponse = await places.getDetailsByPlaceId(store.placeId);
    PlaceDetails details = detailsResponse.result;
    return castPlaceDetailsToStoreModel(details);
  }

  StoreModel castPlaceDetailsToStoreModel(PlaceDetails details) {
    var addrData = details.addressComponents;
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

    return StoreModel(
      googlePlaceId: details.placeId,
      name: details.name,
      streetAddress: returnedStreetAddress,
      city: city,
      state: state,
      postalCode: postalCode,
      latitude: details.geometry.location.lat,
      longitude: details.geometry.location.lng,
    );
  }
    
  //   Map<String, Object> selectedStore = {
  //     'googleId': p.placeId,
  //     'name': details.name,
  //     'streetAddress': returnedStreetAddress,
  //     'city': city,
  //     'state': state,
  //     'postalCode': postalCode,
  //     'coordinate': {
  //       'latitude': details.geometry.location.lat,
  //       'longitude': details.geometry.location.lng,
  //     }
  //   };
  // }
}