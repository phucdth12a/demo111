import 'package:dio/dio.dart';
import 'package:mvvm_bloc/features/auth/login/models/login_request_model.dart';
import 'package:mvvm_bloc/features/auth/register/model/register_request_model.dart';
import 'package:mvvm_bloc/product/model/error/service_error.dart';
import 'package:mvvm_bloc/product/model/user/user.dart';
import 'package:mvvm_bloc/product/network/network_manager.dart';
import 'package:mvvm_bloc/product/utility/service_paths.dart';

abstract class IAuthService {
  final ProjectNetworkManager networkManager;
  IAuthService(this.networkManager);
  Future<User?> postUserLogin(LoginRequestModel model);
  Future<User?> postUserRegister(RegisterRequestModel model);
}

class AuthService extends IAuthService {
  AuthService() : super(ProjectNetworkManager.instance);

  @override
  Future<User?> postUserLogin(LoginRequestModel model) async {
    try {
      final response = await networkManager.service
          .post(ServicePaths.login.path, data: model.toJson());
      final jsonBody = response.data;
      if (jsonBody is Map<String, dynamic>) {
        return User.fromJson(jsonBody);
      }
    } on DioError {
      throw ServiceError('User not found or bad connection');
    }

    return null;
  }

  @override
  Future<User?> postUserRegister(RegisterRequestModel model) async {
    try {
      final response = await networkManager.service
          .post(ServicePaths.register.path, data: model.toJson());
      final jsonBody = response.data;
      if (jsonBody is Map<String, dynamic>) {
        return User.fromJson(jsonBody);
      }
    } on DioError {
      throw ServiceError('User not created');
    }
    return null;
  }
}
