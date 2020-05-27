import 'package:markit/components/models/price_check_tag_model.dart';
import 'package:markit/components/models/store_model.dart';

class PriceCheckModel {
  StoreModel store;
  double totalPrice;
  int staleness;
  int priceRank;
  int stalenessRank;
  int priceAndStalenessRank;
  num matchedRatio;
  bool missingItems;
  List<PriceCheckTagModel> tagPrices;

  PriceCheckModel({this.store, this.totalPrice, this.staleness, this.priceRank, this.stalenessRank, this.priceAndStalenessRank, this.matchedRatio, this.missingItems, this.tagPrices});

  factory PriceCheckModel.fromJson(Map<String, dynamic> json) {
    return PriceCheckModel(
      store: StoreModel.fromJson(json['store']),
      totalPrice: json['totalPrice'],
      staleness: json['staleness'],
      priceRank: json['priceRank'],
      stalenessRank: json['stalenessRank'],
      priceAndStalenessRank: json['priceAndStalenessRank'],
      matchedRatio: json['matchedRatio'],
      missingItems: json['missingItems'],
      tagPrices: getTagPricesFromObjects(json['listItems']),
    );
  }
}

List<PriceCheckTagModel> getTagPricesFromObjects(List<Object> tagPrices) {
  return tagPrices.map((tag) => PriceCheckTagModel.fromJson(tag)).toList();
}
