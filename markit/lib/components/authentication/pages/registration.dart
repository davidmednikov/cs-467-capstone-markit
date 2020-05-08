import 'package:flutter/material.dart';

import '../components/registration_form.dart';

class RegistrationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 25),
          child: Column(children: <Widget>[
            // Spacer(flex: 1),
            Expanded(
              // flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.25,
                child:  Container(
                  margin: EdgeInsets.all(10),
                  child: FractionallySizedBox(
                    widthFactor: 0.75,
                    child: Image.asset('assets/img/splash.png'),
                  ),
                )
              )
            ),
            Expanded(
              flex: 5,
              child: RegistrationForm()
            ),
            // Spacer(flex: 1)
          ]),
        )
      ),
    );
  }
}