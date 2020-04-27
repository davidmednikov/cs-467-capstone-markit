import 'list_tag_model.dart';
import 'markit_user_model.dart';

class ShoppingListModel {
  int id;
  MarkitUserModel user;
  String name;
  String description;
  DateTime createdDate;
  DateTime updatedDate;
  List<ListTagModel> listTags;

  ShoppingListModel({this.id, this.user, this.name, this.description,
      this.createdDate, this.updatedDate, this.listTags});
}

ShoppingListModel getTestList(int id) {
  return ShoppingListModel(id: id, name: 'BBQ', description: 'Super bomb', listTags: getTestListTags());
}

List<ShoppingListModel> getTestLists() {
  return new List.of([getTestList(1), getTestList(2), getTestList(3), getTestList(4), getTestList(5)]);
}