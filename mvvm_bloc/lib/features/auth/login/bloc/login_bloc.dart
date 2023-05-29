import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_bloc/features/auth/login/bloc/login_event.dart';
import 'package:mvvm_bloc/features/auth/login/bloc/login_state.dart';
import 'package:mvvm_bloc/features/auth/login/models/login_request_model.dart';
import 'package:mvvm_bloc/features/auth/login/service/login_service.dart';
import 'package:mvvm_bloc/product/model/error/service_error.dart';
import 'package:mvvm_bloc/product/model/user/user.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ILoginService service;

  LoginBloc({required this.service}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is SignInEvent) {
        emit(LoginLoadingState());
        final response = await _postUserModel(
            LoginRequestModel(username: event.email, password: event.password));
        if (response is User) {
          emit(LoginComplete(response));
        } else if (response is ServiceError) {
          emit(LoginFailedState(response));
        }
      } else if (event is NavigateToRegisterEvent) {
        emit(NavigateToRegisterState());
      }
    });
  }

  Future<dynamic> _postUserModel(LoginRequestModel loginRequestModel) async {
    try {
      return await service.login(loginRequestModel);
    } on ServiceError catch (e) {
      return e;
    }
  }
}
