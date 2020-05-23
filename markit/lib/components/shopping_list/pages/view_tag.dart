import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/list_tag_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/tag_service.dart';

class ViewTag extends StatefulWidget {

  final String postUrl = 'https://markit-api.azurewebsites.net/tag';

  GlobalKey<DynamicFabState> dynamicFabKey;

  ViewTag({Key key, this.dynamicFabKey}) : super(key: key);

  ApiService apiService = new ApiService();
  TagService tagService = new TagService();

  @override
  _ViewTagState createState() => _ViewTagState();
}

class _ViewTagState extends State<ViewTag> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ListTagModel listTag;

  int quantity;
  String notes;

  bool buttonPressed;

  @override
  void initState() {
    super.initState();
    buttonPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    listTag = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      child: TopScaffold(
        title: listTag.tagName,
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
                          labelText: 'Notes',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        initialValue: listTag.tagName,
                        enabled: false,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          quantity = int.parse(value);
                        },
                        initialValue: listTag.quantity.toString(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a quantity';
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
                        initialValue: listTag.comment,
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
                            Map savedTag = await saveTag();
                            ListTagModel listTagModel = ListTagModel.fromJsonWithListId(savedTag, listTag.listId);
                            notifyFabOfPop();
                            Navigator.of(context).pop(listTagModel);
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

   Future<Map> saveTag() async {
    return widget.tagService.updateTag(listTag.listId, listTag.id, listTag.tagId, listTag.tagName, quantity, notes);
  }

  Future<bool> notifyFabOfPop() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    widget.dynamicFabKey.currentState.changePage('viewList');
    return Future.value(true);
  }
}