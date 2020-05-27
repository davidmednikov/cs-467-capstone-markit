import 'package:intl/intl.dart';

import 'package:markit/components/models/markit_user_model.dart';

class PriceCheckTagModel {
  int tagId;
  List<String> tagNames;
  double price;
  bool isSalePrice;
  MarkitUserModel priceSubmittedBy;
  DateTime submittedDate;

  PriceCheckTagModel({this.tagId, this.tagNames, this.price, this.isSalePrice, this.priceSubmittedBy, this.submittedDate});

  static DateFormat formatter = new DateFormat("yyyy-MM-ddTHH:mm:ss");

  factory PriceCheckTagModel.fromJson(Map<String, dynamic> json) {
    return PriceCheckTagModel(
      tagId: json['tagId'],
      tagNames: List<String>.from(json['tagNames']),
      price: json['price'],
      isSalePrice: json['isSalePrice'],
      priceSubmittedBy: MarkitUserModel.fromJsonForPriceCheck(json['priceSubmittedBy']),
      submittedDate: formatter.parse(json['priceSubmittedBy']['submittedDate'], true),
    );
  }
}