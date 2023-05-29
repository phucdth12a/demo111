import 'package:mvvm_bloc/product/model/error/service_error.dart';
import 'package:mvvm_bloc/product/model/user/user.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginComplete extends LoginState {
  final User model;

  LoginComplete(this.model);
}

class LoginFailedState extends LoginState {
  ServiceError error;
  LoginFailedState(this.error);

  @override
  String toString() {
    return error.message;
  }
}

class LoginLoadingState extends LoginState {
  LoginLoadingState();
}

class NavigateToRegisterState extends LoginState {}
