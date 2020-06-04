class ItemPriceModel {
  int id;
  int userId;
  int storeId;
  String upc;
  double price;
  bool isSalePrice;
  List<String> tags;

// can remove all parameters except tags/isSalePrice if those remain the only data initialized
  ItemPriceModel({this.id, this.userId, this.storeId, this.upc, this.price, this.isSalePrice, this.tags});
}