import 'package:us_states/us_states.dart';

class StoreModel {
  int id;
  String name;
  String streetAddress;
  String city;
  String state;
  String postalCode;
  double averageRating;

  double latitude;
  double longitude;
  String googleId;

  StoreModel({this.id, this.name, this.streetAddress, this.city, this.state, this.postalCode, this.averageRating, this.latitude, this.longitude, this.googleId});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    StoreModel theStore = StoreModel(
      id: json['id'],
      name: json['name'],
      streetAddress: shortenAddress(json['streetAddress']),
      city: json['city'],
      state: getStateAbbreviation(json['state']),
      postalCode: json['postalCode'],
      averageRating: json['averageRating'],
      googleId: json['googleId'],
    );
    if (json['coordinate'] != null) {
      theStore.latitude = json['coordinate']['latitude'];
      theStore.longitude = json['coordinate']['longitude'];
    }
    return theStore;
  }

  @override
  String toString() => name;

  @override
  operator ==(o) => o is StoreModel && o.id == id;

  @override
  int get hashCode => id.hashCode^name.hashCode;
}

String shortenAddress(String streetAddress) {
  if (streetAddress.contains('Boulevard')) {
    return streetAddress.replaceAll('Boulevard', 'Blvd.');
  } else if (streetAddress.contains('Avenue')) {
    return streetAddress.replaceAll('Avenue', 'Ave.');
  } else if (streetAddress.contains('Highway')) {
    return streetAddress.replaceAll('Highway', 'Hwy');
  }
  return streetAddress;
}

String getStateAbbreviation(String stateString) {
  if (stateString.length > 3) {
    return USStates.getAbbreviation(stateString);
  }
  return stateString;
}