import 'package:flutter/material.dart';
import 'package:studying_bloc_pattern/pages/common/AppBackground.dart';
import 'package:studying_bloc_pattern/pages/common/submit_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size contextSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 25, left: 25),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.5),
                    labelText: "User name",
                    
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 25, left: 25),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.5),
                    labelText: "Password",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 100),
                child: SubmitButton(
                  size: new Size(contextSize.width * 0.7, 50), 
                  text: Text("Sign in",style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300, letterSpacing: 0.3,)),
                ),
              )
            ],
          )
        ],
      ),      
    );
  }
}