class ListTagModel {
  int id;
  int listId;
  int tagId;
  String tagName;
  int quantity;
  String comment;

  ListTagModel({this.id, this.listId, this.tagId, this.tagName, this.comment, this.quantity});

  factory ListTagModel.fromJson(Map<String, dynamic> json) {
    return ListTagModel(
      id: json['id'],
      tagId: json['tag']['id'],
      tagName: json['tag']['name'],
      quantity: json['quantity'],
      comment: json['comment'],
    );
  }

  factory ListTagModel.fromJsonWithListId(Map<String, dynamic> json, int listId) {
    return ListTagModel(
      id: json['id'],
      listId: listId,
      tagId: json['tag']['id'],
      tagName: json['tag']['name'],
      quantity: json['quantity'],
      comment: json['comment'],
    );
  }
}
