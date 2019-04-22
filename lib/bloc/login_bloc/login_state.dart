import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
  LoginState([List props = const []]) : super(props);
}

class LoginInitialization extends LoginState{
  @override
  String toString() => 'LoginInilization';
}

class LoginProcessing extends LoginState{
  @override
  String toString() => 'LoginProcessing';
}

class LoginSuccessfully extends LoginState{
  @override
  String toString() => 'LoginSuccessfully';
}

class LoginFailed extends LoginState{
  @override
  String toString() => 'LoginFailed';
}

