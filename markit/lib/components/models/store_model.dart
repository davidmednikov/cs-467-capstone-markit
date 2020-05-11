import 'list_tag_model.dart';

class StoreModel {
  int id;
  String name;
  String streetAddress;
  String city;
  String state;
  String postalCode;

  double priceRunTotal;
  int priceRunStaleness;
  int priceRunPriceRank;
  int priceRunPriceStalenessRank;

  List<ListTagModel> listTags;


  StoreModel({this.id, this.name, this.streetAddress, this.city, this.state, this.postalCode, this.priceRunTotal, this.priceRunStaleness, this.priceRunPriceRank, this.priceRunPriceStalenessRank, this.listTags});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      streetAddress: json['streetAddress'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
    );
  }

  factory StoreModel.fromJsonForPriceRun(Map<String, dynamic> json) {
    Map storeInfo = json['store'];
    StoreModel theStore = StoreModel(
      id: storeInfo['id'],
      name: storeInfo['name'],
      streetAddress: storeInfo['streetAddress'],
      city: storeInfo['city'],
      state: storeInfo['state'],
      postalCode: storeInfo['postalCode'],
    );
    theStore.priceRunTotal = json['totalPrice'];
    theStore.priceRunStaleness = json['staleness'];
    theStore.priceRunPriceRank = json['priceRank'];
    theStore.priceRunPriceStalenessRank = json['priceAndStalenessRank'];
    return theStore;
  }
}

List<ListTagModel> getListTagsFromObjects(List<Object> listTags, int listId) {
  return listTags.map((tag) => ListTagModel.fromJsonWithListId(tag, listId)).toList();
}
