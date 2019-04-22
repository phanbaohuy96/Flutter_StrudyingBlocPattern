import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:studying_bloc_pattern/models/user.dart';
import 'package:studying_bloc_pattern/pages/infinity_list.dart';

import '../bloc.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState>
{
  @override
  // TODO: implement initialState
  get initialState => LoginInitialization();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    // TODO: implement mapEventToState
    if(event is AccessLogin)
    {
      yield LoginProcessing(); 
      yield accessLogin(event.user);
    } else if(event is LoginFailedCallback)
    {
      yield LoginFailed();  
    } else if(event is LoginSuccessfullyCallback)
    {
      yield LoginSuccessfully();  
    }

  }

  accessLogin(User user) async{
    print('AccessLogin');
    await Future.delayed(Duration(seconds: 2));
    if(user.userName.toString().toLowerCase() == "admin" && user.password.toString().toLowerCase() == "admin")
    {
      print("LoginSuccessfullyCalback");
      this.dispatch(LoginSuccessfullyCallback());
    }else{
      print("LoginFailedCalback");
      this.dispatch(LoginFailedCallback());
    }
  }
  
}