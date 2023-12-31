import 'dart:async';

import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_rendrer_impl.dart';

import '../../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsStreamController =
      StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyStreamController = StreamController<bool>();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    super.dispose();
    _passwordStreamController.close();
    _userNameStreamController.close();
    _areAllInputsStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view model tell view represent the content
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAllInputsValid => _areAllInputsStreamController.sink;

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
  login() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.password, loginObject.userName)))
        .fold((failure) {
          inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
      // failure
    }, (data) {
          inputState.add(ContentState());

          // navigate to main screen
          isUserLoggedInSuccessfullyStreamController.add(true);
      // data (success)
    });
  }

  @override
  // TODO: implement outputPassword
  Stream<bool> get isOutPassword => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get isOutUserName => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get isAllInputsValid =>
      _areAllInputsStreamController.stream.map((_) => _areAllInputsValid());

  bool _areAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }
}

abstract class LoginViewModelInput {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAllInputsValid;
}

abstract class LoginViewModelOutput {
  Stream<bool> get isOutUserName;
  Stream<bool> get isOutPassword;
  Stream<bool> get isAllInputsValid;
}
