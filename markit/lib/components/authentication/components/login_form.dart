import 'package:flutter/material.dart';

import 'package:markit/components/models/markit_user_model.dart';
import 'package:markit/components/service/api_service.dart';
import 'package:markit/components/service/auth_service.dart';
import 'package:markit/components/service/notification_service.dart';


class LoginForm extends StatefulWidget {

  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  MarkitUserModel currentUser = MarkitUserModel();
  ApiService apiService = new ApiService();
  AuthService authService = new AuthService();
  NotificationService notificationService = new NotificationService();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: TextFormField(
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username",
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your username";
                }
                return null;
              },
              onSaved: (value) {
                currentUser.username = value.trim();
              }
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0)
            ),
            child:  TextFormField(
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
              onSaved: (value) {
                currentUser.password = value.trim();
              },
              obscureText: true,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.075,
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                String token = await authService.getTokenFromServer(currentUser.username, currentUser.password);
                if (token != null) {
                  authService.storeToken(token);
                  int userId = await apiService.getUserId();
                  authService.login(currentUser.username, currentUser.password, userId);
                  Navigator.pushReplacementNamed(context, 'home');
                }
                else {
                  notificationService.showErrorNotification('Invalid credentials.');
                }
              }
            },
            shape: StadiumBorder(),
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
            child: Text(
              "Log in",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange
              )
            )
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'register');
              },
              child: Text(
                "Create account",
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                )
              )
            )
          )
        ])
      )
    );
  }
}