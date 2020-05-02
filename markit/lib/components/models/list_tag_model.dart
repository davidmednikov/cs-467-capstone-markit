class ListTagModel {
  int id;
  int tagId; // -> need to access tag name
  String tagName;
  int quantity;
  String comment;
  DateTime createdDate;
  DateTime updatedDate;

  ListTagModel({this.id, this.tagId, this.tagName,
      this.comment, this.quantity, this.createdDate, this.updatedDate});

  factory ListTagModel.fromJson(Map<String, dynamic> json) {
    return ListTagModel(
      id: json['id'],
      tagId: json['tag']['id'],
      tagName: json['tag']['name'],
      quantity: json['quantity'],
      comment: json['comment'],
    );
  }
}
