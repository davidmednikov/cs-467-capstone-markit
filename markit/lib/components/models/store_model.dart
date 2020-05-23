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
      streetAddress: json['streetAddress'],
      city: json['city'],
      state: json['state'],
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