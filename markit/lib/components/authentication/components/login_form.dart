import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/markit_user_model.dart';
import '../../service/auth_service.dart';


class LoginForm extends StatefulWidget {

  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    
  MarkitUserModel currentUser = MarkitUserModel();
  AuthService authService = new AuthService();

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
                    labelText: "Username"
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter your username";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    currentUser.username = value;
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
                      return "Please enter your password";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    currentUser.password = value;
                  }
                ),
              )
            ])
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                String token = await authService.getTokenFromServer(currentUser.username, currentUser.password);
                if (token != null) {
                  Navigator.pushReplacementNamed(context, 'home');
                }
                else {
                  print("null token");
                }
              }
            },
            shape: StadiumBorder(),
            color: Colors.deepOrange,
            padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
            child: Text(
              "Log in",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
              )
            )
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
                  decoration: TextDecoration.underline
                )
              )
            )
          )
        ])
      )
    );
  }
}