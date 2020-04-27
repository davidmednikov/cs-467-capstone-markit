class ListTagModel {
  int id;
  int shoppingListId;
  int tagId; // -> need to access tag name
  String tagName;
  int quantity;
  String comment;
  DateTime createdDate;
  DateTime updatedDate;

  ListTagModel({this.id, this.shoppingListId, this.tagId, this.tagName,
      this.comment, this.quantity, this.createdDate, this.updatedDate});
}

ListTagModel getTestListTag(int id) {
  return ListTagModel(id: id, shoppingListId: 1, tagId: 1, tagName: 'Ribs', quantity: 2, comment: '2 lbs Baby Back');
}

List<ListTagModel> getTestListTags() {
  return new List.of([getTestListTag(1), getTestListTag(2), getTestListTag(3), getTestListTag(4), getTestListTag(5)]);
}