import 'package:markit/components/models/markit_user_model.dart';

class PriceCheckTagModel {
  int tagId;
  List<String> tagNames;
  double price;
  bool isSalePrice;
  MarkitUserModel priceSubmittedBy;

  PriceCheckTagModel({this.tagId, this.tagNames, this.price, this.isSalePrice, this.priceSubmittedBy});

  factory PriceCheckTagModel.fromJson(Map<String, dynamic> json) {
    return PriceCheckTagModel(
      tagId: json['tagId'],
      tagNames: List<String>.from(json['tagNames']),
      price: json['price'],
      isSalePrice: json['isSalePrice'],
      priceSubmittedBy: MarkitUserModel.fromJsonForPriceCheck(json['priceSubmittedBy']),
    );
  }
}