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

  // factory ListTagModel.fromJson(Map<String, dynamic> json) {
  //   return ListTagModel(
  //     id: json['id'],
  //     tagId: json['tag']['id'],
  //     tagName: json['tag']['name'],
  //     quantity: json['quantity'],
  //     comment: json['comment'],
  //   );
  // }

  // factory ListTagModel.fromJsonWithListId(Map<String, dynamic> json, int listId) {
  //   return ListTagModel(
  //     id: json['id'],
  //     listId: listId,
  //     tagId: json['tag']['id'],
  //     tagName: json['tag']['name'],
  //     quantity: json['quantity'],
  //     comment: json['comment'],
  //   );
  // }
}