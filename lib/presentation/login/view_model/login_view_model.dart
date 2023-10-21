import 'dart:async';

import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../common/freezed_data_classes.dart';

class LoginViewModel
    implements BaseViewModel, LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();


  LoginObject loginObject = LoginObject("","");
  @override
  void dispose() {
    _passwordStreamController.close();
    _userNameStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  setPassword(String password) {
   inputPassword.add(password);
   loginObject = loginObject.copyWith(
     password: password,
   );
  }

  @override
  setUserName(String userName) {
  inputUserName.add(userName);
  loginObject = loginObject.copyWith(
    userName: userName,
  );
  }

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  // TODO: implement outputPassword
  Stream<bool> get outIsPassword => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  @override
  // TODO: implement outputUserName
  Stream<bool> get outIsUserName => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));
}

bool _isUserNameValid(String userName) {
  return userName.isNotEmpty;
}

abstract class LoginViewModelInput {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;

  Sink get inputPassword;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outIsUserName;
  Stream<bool> get outIsPassword;
}