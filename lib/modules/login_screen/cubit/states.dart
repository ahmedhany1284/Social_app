import 'package:shop_pp/models/login_model.dart';
import 'package:shop_pp/models/on_boarding_model.dart';

abstract class LoginStates {}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates
{
  final String error;

  LoginErrorState(this.error);
}
class LoginChangePasswordState extends LoginStates{}
