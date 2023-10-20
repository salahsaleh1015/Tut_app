import 'package:tut_app/presentation/base/base_view_model.dart';

class LoginViewModel
    implements BaseViewModel, LoginViewModelInput, LoginViewModelOutput {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => throw UnimplementedError();

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => throw UnimplementedError();

  @override
  setPassword(String password) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    throw UnimplementedError();
  }

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  // TODO: implement outputPassword
  Stream<bool> get outputPassword => throw UnimplementedError();

  @override
  // TODO: implement outputUserName
  Stream<bool> get outputUserName => throw UnimplementedError();
}

abstract class LoginViewModelInput {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;

  Sink get inputPassword;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputUserName;
  Stream<bool> get outputPassword;
}
