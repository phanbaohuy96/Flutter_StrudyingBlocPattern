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
  TextEditingController _editingUserNameController, _editingPassController;
  

  onLogin(){
    _loginBloc.dispatch(AccessLogin(User(_editingUserNameController.text, _editingPassController.text)));
  }

  _genLoginBtnByStatus(ButtonStatus status, Function onTap)
  {
    return SubmitButton(
      size: _buttonLoginSize,
      text: Text("Sign in",style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w300, letterSpacing: 0.3,)),
      status: status,
      onTap: onTap,
    );
  }

  @override
  void initState() {
    _editingUserNameController = TextEditingController();
    _editingPassController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
    Size contextSize = MediaQuery.of(context).size;
    _buttonLoginSize = Size(contextSize.width * 0.7, 50);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackground(),
          GestureDetector(
            onTap:(){
              FocusScope.of(context).requestFocus(new FocusNode());
            }
          ),
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
                  controller: _editingUserNameController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 25, left: 25),
                child: TextFormField(                  
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.5),
                    labelText: "Password",
                  ),
                  controller: _editingPassController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 100),
                child: BlocBuilder(
                  bloc: _loginBloc,
                  builder: (BuildContext context, LoginState state){
                    if(state is LoginInitialization)
                    {        
                      return _genLoginBtnByStatus(ButtonStatus.original, onLogin);
                    } else if (state is LoginSuccessfully){ 
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        print("Navigator.push!");
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => InfinityList())
                        );
                        return;
                      });
                      _loginBloc.dispatch(LoginInit());
                      return Container();

                    } else if (state is LoginFailed){
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        print("Show error!");
                        Scaffold.of(context).showSnackBar( SnackBar( content: Text('Username or password is incorrect.'), backgroundColor: Colors.red, duration: Duration(seconds: 2),));
                      });
                      return _genLoginBtnByStatus(ButtonStatus.rollback, onLogin);

                    } else if(state is LoginProcessing)
                    {
                      return _genLoginBtnByStatus(ButtonStatus.tranform, null);
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