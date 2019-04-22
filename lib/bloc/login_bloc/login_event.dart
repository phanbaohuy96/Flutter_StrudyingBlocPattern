import 'package:equatable/equatable.dart';
import '../../models/user.dart';


abstract class LoginEvent extends Equatable {}

class AccessLogin extends LoginEvent{
  final User user;
  AccessLogin(this.user); 

  @override
  String toString() => 'AccessLogin';
}

class LoginFailedCallback extends LoginEvent{
  @override
  String toString() => 'LoginFailedCalback';
}

class LoginSuccessfullyCallback extends LoginEvent{
  @override
  String toString() => 'LoginSuccessfullyCalback';
}

