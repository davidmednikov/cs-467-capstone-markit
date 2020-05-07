import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/markit_user_model.dart';
import '../../service/api_service.dart';


class RegistrationForm extends StatefulWidget {

  RegistrationForm({Key key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    
  MarkitUserModel newUser = MarkitUserModel();
  ApiService apiService = new ApiService();

  @override
  Widget build(BuildContext context) {
    
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              ListTile(
                title: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                    labelText: "First name"
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    newUser.firstName = value;
                  } 
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal()
                    ),
                    labelText: "Last name"
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter your last name";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    newUser.lastName = value;
                  }
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal()
                    ),
                    labelText: "Username"
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a username";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    newUser.username = value;
                  }
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal()
                    ),
                    labelText: "Password"
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a password";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    newUser.password = value;
                  }
                ),
              ),
            ])
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                var body = {
                  'firstName': newUser.firstName,
                  'lastName': newUser.lastName,
                  'userName': newUser.username,
                  'password': newUser.password
                };
                print(body);
                Map<String, Object> postedUser = await apiService.postResponseMap('https://markit-api.azurewebsites.net/user', body);
                if (postedUser.isNotEmpty) {
                  Navigator.pushNamed(
                    context,
                    'home',
                    arguments: <String, bool> {
                      'firstLogin': true
                    }
                  );
                }
// do we need to handle cases where request is not successful?
              }
            },
            shape: StadiumBorder(),
            color: Colors.deepOrange,
            hoverColor: Colors.deepOrange,
            padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
            child: Text(
              "Register",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
              )
            )
          ),
        ])
      )
    );
  }
}