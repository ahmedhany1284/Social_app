import 'package:equatable/equatable.dart';

abstract class LoginStates extends Equatable {}

class LoginInitialState extends LoginStates {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginStates {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginStates {
  final String uId;

  LoginSuccessState(this.uId);

  @override
  List<Object?> get props => [uId];
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class LoginChangePasswordState extends LoginStates {
  @override
  List<Object?> get props => [];
}

class LoginRefreshState extends LoginStates {
  @override
  List<Object?> get props => [];
}
