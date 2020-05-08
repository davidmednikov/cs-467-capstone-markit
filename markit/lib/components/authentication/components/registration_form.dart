import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:markit/components/models/markit_user_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/service/tutorial_service.dart';


class RegistrationForm extends StatefulWidget {

  RegistrationForm({Key key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  MarkitUserModel newUser = MarkitUserModel();
  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();
  TutorialService tutorialService = new TutorialService();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
        child: ListView(
          children: <Widget>[

        Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "First Name",
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your first name";
                }
                return null;
              },
              onSaved: (value) {
                newUser.firstName = value.trim();
              }
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Last Name",
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your last name";
                }
                return null;
              },
              onSaved: (value) {
                newUser.lastName = value.trim();
              }
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username",
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter a username";
                }
                return null;
              },
              onSaved: (value) {
                newUser.username = value.trim();
              }
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter a password";
                }
                return null;
              },
              onSaved: (value) {
                newUser.password = value.trim();
              },
              obscureText: true,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                int userId = await authService.postUserToServer(newUser.firstName, newUser.lastName, newUser.username, newUser.password);
                if (userId != null) {
                  String token = await authService.getTokenFromServer(newUser.username, newUser.password);
                  if (token != null) {
                    authService.storeToken(token);
                    authService.login(newUser.username, newUser.password, userId);
                    tutorialService.storeAllTutorialsUnwatched(userId);
                    Navigator.pushReplacementNamed(context, 'home');
                  } else {
                    showNotification('Registration error.');
                  }
                } else {
                  showNotification('Registration error.');
                }
              }
            },
            shape: StadiumBorder(),
            color: Colors.white,
            hoverColor: Colors.deepOrange,
            padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
            child: Text(
              "Register",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange
              )
            )
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                )
              )
            )
          )
        ])
          ],
        )
      )
    );
  }

  void showNotification(String message) {
    showSimpleNotification(
      Text(message),
      background: Color(0xfffff2226),
    );
  }
}