class PriceCheckTagModel {
  int tagId;
  List tagNames;
  double price;
  bool isSalePrice;

  PriceCheckTagModel({this.tagId, this.tagNames, this.price, this.isSalePrice});

  factory PriceCheckTagModel.fromJson(Map<String, dynamic> json) {
    return PriceCheckTagModel(
      tagId: json['tagId'],
      tagNames: json['tagNames'],
      price: json['price'],
      isSalePrice: json['isSalePrice'],
    );
  }
}
