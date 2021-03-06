import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/scaffold/top_scaffold.dart';
import 'package:markit/components/models/list_tag_model.dart';
import 'package:markit/components/models/shopping_list_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/tag_service.dart';


class AddTag extends StatefulWidget {

  final String postUrl = 'https://markit-api.azurewebsites.net/list';

  GlobalKey<DynamicFabState> dynamicFabKey;

  AddTag({Key key, this.dynamicFabKey}) : super(key: key);

  ApiService apiService = new ApiService();
  TagService tagService = new TagService();

  @override
  _AddTagState createState() => _AddTagState();
}

class _AddTagState extends State<AddTag> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();

  ShoppingListModel shoppingList;

  int tagId;
  String tagName;
  int quantity;
  String notes;

  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    shoppingList = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      child: TopScaffold(
        title: 'Add Tag',
        view: Form(
          key: formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _typeAheadController,
                          decoration: InputDecoration(
                            labelText: 'Tag',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return getSuggestions(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion['name']),
                          );
                        },
                        transitionBuilder: (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (suggestion) {
                          _typeAheadController.text = suggestion['name'];
                          tagId = suggestion['id'];
                        },
                        onSaved: (value) {
                          tagName = value;
                        },
                        autovalidate: true,
                        hideOnLoading: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a name';
                          } else if (tagId == null) {
                            return 'Tag autocomplete must match an existing tag.';
                          } else if (listAlreadyContainsTag(value)) {
                            return 'This list already contains this tag.';
                          }
                          return null;
                        },
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
                            Map savedTag = await saveTag();
                            ListTagModel listModel = ListTagModel.fromJsonWithListId(savedTag, shoppingList.id);
                            notifyFabOfPop();
                            Navigator.of(context).pop(listModel);
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

  Future<Map> saveTag() async {
    return widget.tagService.addTagToList(shoppingList.id, tagId, tagName, quantity, notes);
  }

  bool listAlreadyContainsTag(String newTag) {
    List<String> listTags = shoppingList.listTags.map((listTag) => listTag.tagName).toList();
    if (listTags.contains(newTag)) {
      return true;
    }
    return false;
  }

  Future<bool> notifyFabOfPop() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    widget.dynamicFabKey.currentState.changePage('viewList');
    return Future.value(true);
  }

  Future<List<Map<String, Object>>> getSuggestions(String pattern) async {
    tagId = null;
    return List<Map<String, Object>>.from(await widget.tagService.getSuggestions(pattern));
  }
}