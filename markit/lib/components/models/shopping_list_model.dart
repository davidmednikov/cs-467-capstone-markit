import 'list_tag_model.dart';

class ShoppingListModel {
  int id;
  int userId;
  String name;
  String description;
  List<ListTagModel> listTags;

  ShoppingListModel({this.id, this.userId, this.name, this.description, this.listTags});

  factory ShoppingListModel.fromJson(Map<String, dynamic> json) {
    return ShoppingListModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      description: json['description'],
      listTags: getListTagsFromObjects(json['listTags'], json['id']),
    );
  }
}

List<ListTagModel> getListTagsFromObjects(List<Object> listTags, int listId) {
  return listTags.map((tag) => ListTagModel.fromJsonWithListId(tag, listId)).toList();
}
