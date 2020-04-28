import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import '../../common/scaffold/top_scaffold.dart';

class AddList extends StatefulWidget {

  int userid;

  final String postUrl = 'https://markit-api.azurewebsites.net/list';

  GlobalKey<DynamicFabState> dynamicFabKey;

  AddList({Key key, this.userid, this.dynamicFabKey}) : super(key: key);

  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {

  final formKey = GlobalKey<FormState>();

  String name;
  String notes;
  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: TopScaffold(
        title: 'Add List',
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
                            buttonPressed = true;
                            setState( () {} );
                            await saveList();
                            Navigator.of(context).pop();
                          }
                        },
                        color: Colors.deepOrange,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                          child: Center(
                            child: Icon(Icons.cloud_upload, size: 50, color: Colors.white),
                          ),
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

  Future<Response> saveList() async {
    var response = await post(widget.postUrl, body: {'userId': '1', 'name': name, 'notes': notes});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future<bool> notifyFabOfPop() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    widget.dynamicFabKey.currentState.changePage('myLists');
    return Future.value(true);
  }
}