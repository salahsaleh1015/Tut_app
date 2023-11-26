import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
    String userName,
    String countryCode,
    String phoneNumber,
    String email,
    String password,
    String profilePicture,
  ) = _RegisterObject;
}

@freezed
class ForgetPasswordObject with _$ForgetPasswordObject {
  factory ForgetPasswordObject(String userName) = _ForgetPasswordObject;
}
