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
  if (id == 1) {
    return ListTagModel(id: id, shoppingListId: 1, tagId: 1, tagName: 'Ribs', quantity: 2, comment: '2 lbs Baby Back');
  } else if (id == 2) {
    return ListTagModel(id: id, shoppingListId: 1, tagId: 2, tagName: 'Heinz BBQ Sauce', quantity: 1, comment: '20 oz');
  } else if (id == 3) {
    return ListTagModel(id: id, shoppingListId: 1, tagId: 6, tagName: 'Cole Slaw', quantity: 1, comment: '16 oz');
  } else if (id == 4) {
    return ListTagModel(id: id, shoppingListId: 1, tagId: 3, tagName: 'Potatoes', quantity: 4, comment: 'Idado if they have it');
  } else if (id == 5) {
    return ListTagModel(id: id, shoppingListId: 1, tagId: 5, tagName: 'Toilet Paper', quantity: 8, comment: 'even generic brand');
  } else if (id == 6) {
    return ListTagModel(id: id, shoppingListId: 1, tagId: 4, tagName: 'Purell Hand Sanitizer', quantity: 5, comment: 'please');
  }
}

List<ListTagModel> getTestListTags() {
  return new List.of([getTestListTag(1), getTestListTag(2), getTestListTag(3), getTestListTag(4), getTestListTag(5), getTestListTag(6)]);
}