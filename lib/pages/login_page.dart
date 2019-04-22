import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_bloc_pattern/models/user.dart';
import 'package:studying_bloc_pattern/pages/common/AppBackground.dart';
import 'package:studying_bloc_pattern/pages/common/submit_button.dart';
import 'package:studying_bloc_pattern/pages/infinity_list.dart';
import 'package:flutter/scheduler.dart';
import '../bloc/bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  final _loginBloc = LoginBloc();
  Size _buttonLoginSize = Size(0, 0);

  onLogin(User user){
    _loginBloc.dispatch(AccessLogin(user));
  }

  @override
  Widget build(BuildContext context) {    
    Size contextSize = MediaQuery.of(context).size;
    _buttonLoginSize = Size(contextSize.width * 0.7, 50);
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
                child: BlocBuilder(
                  bloc: _loginBloc,
                  builder: (BuildContext blocContext, LoginState state){
                    if(state is LoginInitialization)
                    {             
                      return SubmitButton(
                        size: _buttonLoginSize,
                        text: Text("Sign in",style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w300, letterSpacing: 0.3,)),
                        status: ButtonStatus.original,
                        onTap: (){
                          onLogin(User("abc", "abc"));
                        },
                      );
                    } else if (state is LoginSuccessfully){ 
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfinityList()));                    
                      return SubmitButton(
                        size: _buttonLoginSize,
                        text: Text("Sign in",style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w300, letterSpacing: 0.3,)),
                        status: ButtonStatus.original,
                        onTap: (){
                          onLogin(User("abc", "abc"));
                        },
                      );

                      
                    } else if (state is LoginFailed){
                      return SubmitButton(
                        size: _buttonLoginSize,
                        text: Text("Sign in",style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w300, letterSpacing: 0.3,)),
                        status: ButtonStatus.rollback,
                        onTap: (){
                          onLogin(User("admin", "admin"));
                        },
                      );
                    } else if(state is LoginProcessing)
                    {
                      return SubmitButton(
                        size: _buttonLoginSize,
                        text: Text("Sign in",style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w300, letterSpacing: 0.3,)),
                        status: ButtonStatus.tranform,
                      );
                    }

                    return null;                    
                  },
                )
              )
            ],
          )
        ],
      ),      
    );
  }
}