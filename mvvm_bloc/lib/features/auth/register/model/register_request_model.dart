import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequestModel {
  final String email;
  final String password;
  RegisterRequestModel(this.email, this.password);

  factory RegisterRequestModel.fromJson(Map<String, Object?> json) =>
      _$RegisterRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
