import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/service/notification_service.dart';


class NewList extends StatefulWidget {
  GlobalKey<DynamicFabState> dynamicFabKey;

  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();
  NotificationService notificationService = new NotificationService();

  NewList({Key key, this.dynamicFabKey}) : super(key: key);

  @override
  _NewListState createState() => _NewListState();
}

class _NewListState extends State<NewList> {

  final formKey = GlobalKey<FormState>();

  String name;
  String notes;
  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: TopScaffold(
        title: 'New List',
        view: Form(
          key: formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'List Name',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          name = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        }
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Notes',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        onSaved: (value) {
                          notes = value;
                        },
                        minLines: 4,
                        maxLines: 6,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: RaisedButton(
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            setState( () => buttonPressed = true);
                            Map<String, Object> listObject =await saveList();
                            ShoppingListModel list = ShoppingListModel(
                              id: listObject['id'],
                              name: listObject['name'],
                              description: listObject['description'],
                              listTags: [],
                            );
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                            widget.dynamicFabKey.currentState.changePage('viewList');
                            Navigator.of(context).pushReplacementNamed('viewList', arguments: list);
                            widget.notificationService.showSuccessNotification('List created.');
                          }
                        },
                        color: Colors.deepOrange,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                          child: showIconOrLoading(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onWillPop: notifyFabOfPop,
    );
  }

  Widget showIconOrLoading() {
    if (buttonPressed) {
      return SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      );
    }
    return Center(
      child: Icon(Icons.cloud_upload, size: 50, color: Colors.white),
    );
  }

  Future<Map> saveList() async {
    int userId = await widget.authService.getUserIdFromStorage();
    String url = 'https://markit-api.azurewebsites.net/list';
    var body = {
      'userId': userId,
      'name': name,
      'description': notes
    };
    return widget.apiService.postResponseMap(url, body);
  }

  Future<bool> notifyFabOfPop() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    widget.dynamicFabKey.currentState.changePage('myLists');
    return Future.value(true);
  }
}