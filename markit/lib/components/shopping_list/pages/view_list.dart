import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/list_tag_model.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/service/notification_service.dart';
import 'package:markit/components/shopping_list/components/list_tag_tile.dart';
import 'package:markit/components/shopping_list/pages/my_lists.dart';

class ViewList extends StatefulWidget {

  GlobalKey<DynamicFabState> dynamicFabKey;
  GlobalKey<MyListsState> myListsKey;

  ViewList({Key key, this.dynamicFabKey, this.myListsKey}) : super(key: key);

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();
  NotificationService notificationService = new NotificationService();

  @override
  ViewListState createState() => ViewListState();
}

class ViewListState extends State<ViewList> {

  ShoppingListModel shoppingList;

  bool tagAddedOrDeleted = false;

  final formKey = GlobalKey<FormState>();

  String notes;

  @override
  Widget build(BuildContext context) {
    if (!tagAddedOrDeleted) {
      shoppingList = ModalRoute.of(context).settings.arguments;
    }
    return WillPopScope(
      child: TopScaffold(
        title: shoppingList.name,
        view: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            notesField(),
            showListOrIcon(context),
          ],
        ),
      ),
      onWillPop: notifyFabOfPop,
    );
  }

  Widget notesField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              initialValue: shoppingList.description,
              minLines: 2,
              maxLines: 4,
              onSaved: (value) {
                notes = value;
              },
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.solidSave),
              onPressed: () async {
                formKey.currentState.save();
                await saveNotes();
                setState( () {
                  shoppingList.description = notes;
                } );
                showNotification('Notes updated.');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget showListOrIcon(BuildContext context) {
    if (shoppingList.listTags.length == 0) {
      return Expanded(
        child:Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: Opacity(
              opacity: 0.35,
              child: FaIcon(FontAwesomeIcons.shoppingBasket, size: 125, color: Colors.grey),
            ),
          ),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: shoppingList.listTags.length,
        itemBuilder: (context, index) {
          ListTagModel tag = shoppingList.listTags[index];
          return ListTagTile(listTag: tag, dynamicFabKey: widget.dynamicFabKey, viewListKey: widget.key);
        },
      ),
    );
  }

  void showNotification(String message) {
    widget.notificationService.showSuccessNotification(message);
  }

  void showError(String error) {
   widget.notificationService.showErrorNotification(error);
  }

  void addTag(ListTagModel newTag) {
    setState(() {
      shoppingList.listTags.add(newTag);
      tagAddedOrDeleted = true;
    });
    showNotification('Tag added.');
  }

  void updateTag(ListTagModel updatedTag) {
    int index = shoppingList.listTags.indexWhere((listTag) => listTag.id == updatedTag.id);
    setState(() {
      shoppingList.listTags[index] = updatedTag;
      tagAddedOrDeleted = true;
    });
    showNotification('Tag updated.');
  }

  Future<bool> notifyFabOfPop() {
    widget.myListsKey.currentState.refreshList();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    widget.dynamicFabKey.currentState.changePage('myLists');
    return Future.value(true);
  }

  Future<Map> saveNotes() async {
    int userId = await widget.authService.getUserIdFromStorage();
    String url = 'https://markit-api.azurewebsites.net/list/${shoppingList.id}';
    var body = {
      'userId': userId,
      'description': notes
    };
    return widget.apiService.patchResponseMap(url, body);
  }

  Future<int> deleteTag(int listTagId) async {
    String url = 'https://markit-api.azurewebsites.net/list/${shoppingList.id}/listTag/$listTagId';
    int statusCode = await widget.apiService.deleteResponseCode(url);
    if (statusCode == 200) {
      setState(() {
        shoppingList.listTags.removeWhere((listTag) => listTag.id == listTagId);
        tagAddedOrDeleted = true;
      });
      showNotification('Tag removed.');
    }
    return statusCode;
  }
}