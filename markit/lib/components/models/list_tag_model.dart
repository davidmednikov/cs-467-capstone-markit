class ListTagModel {
  int id;
  int tagId;
  String tagName;
  int quantity;
  String comment;

  ListTagModel({this.id, this.tagId, this.tagName, this.comment, this.quantity});

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
