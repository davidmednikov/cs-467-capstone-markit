import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/list_tag_model.dart';
import '../../common/scaffold/top_scaffold.dart';

class ViewTag extends StatefulWidget {

  final String postUrl = 'https://markit-api.azurewebsites.net/tag';

  GlobalKey<DynamicFabState> dynamicFabKey;

  ViewTag({Key key, this.dynamicFabKey}) : super(key: key);

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
                            // await saveTag();
                            saveTag();
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

   Future<Response> saveTag() async {
    // var response = await post(widget.postUrl, body: {'listId': '1', 'tagId': '1', 'quantity': quantity, 'notes': notes});
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    print('save');
  }

  Future<bool> notifyFabOfPop() {
    widget.dynamicFabKey.currentState.changePage('viewList');
    return Future.value(true);
  }

  List<String> getSuggestions(String pattern) {
    List<String> allStrings = [
      'a',
      'about',
      'all',
      'also',
      'and',
      'as',
      'at',
      'be',
      'because',
      'but',
      'by',
      'can',
      'come',
      'could',
      'day',
      'do',
      'even',
      'find',
      'first',
      'for',
      'from',
      'get',
      'give',
      'go',
      'have',
      'he',
      'her',
      'here',
      'him',
      'his',
      'how',
      'I',
      'if',
      'in',
      'into',
      'it',
      'its',
      'just',
      'know',
      'like',
      'look',
      'make',
      'man',
      'many',
      'me',
      'more',
      'my',
      'new',
      'no',
      'not',
      'now',
      'of',
      'on',
      'one',
      'only',
      'or',
      'other',
      'our',
      'out',
      'people',
      'say',
      'see',
      'she',
      'so',
      'some',
      'take',
      'tell',
      'than',
      'that',
      'the',
      'their',
      'them',
      'then',
      'there',
      'these',
      'they',
      'thing',
      'think',
      'this',
      'those',
      'time',
      'to',
      'two',
      'up',
      'use',
      'very',
      'want',
      'way',
      'we',
      'well',
      'what',
      'when',
      'which',
      'who',
      'will',
      'with',
      'would',
      'year',
      'you',
      'your'
    ];
    return allStrings.where((string) => string.toLowerCase().contains(pattern.toLowerCase())).toList();
  }
}