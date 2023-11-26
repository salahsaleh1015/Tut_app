import 'dart:async';
import 'dart:io';
import 'package:tut_app/domain/usecase/register_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../../application/functions.dart';
import '../../common/freezed_data_classes.dart';
import '../../resources/string_manager.dart';

class RegisterViewModel extends BaseViewModel
    implements RegisterViewModelInput, RegisterViewModelOutput {
  StreamController userNameStreamController =
      StreamController<String>.broadcast();
  StreamController phoneNumberStreamController =
      StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController passwordStreamController =
      StreamController<String>.broadcast();
  StreamController profilePictureStreamController =
      StreamController<File>.broadcast();
  StreamController areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);

  var registerObject = RegisterObject("","","","","","",);



  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    userNameStreamController.close();
    phoneNumberStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputsValidStreamController.close();
  }

  @override

  Stream<File> get outputIsProfilePictureValid =>profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputIsPasswordValid => passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPassword) => isPassword ? null : StringManager.invalidPassword);

  @override
  Stream<bool> get outputIsEmailIValid =>
      emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailIValid
      .map((isEmail) => isEmail ? null : StringManager.invalidEmail);

  @override
  Stream<bool> get outputIsPhoneNumberValid =>
      phoneNumberStreamController.stream
          .map((phoneNumber) => _isPhoneNumberValid(phoneNumber));

  @override
  Stream<String?> get outputErrorPhoneNumber =>
      outputIsPhoneNumberValid.map((isPhoneNumber) =>
          isPhoneNumber ? null : StringManager.invalidPhoneNumber);

  @override
  Stream<bool> get outputIsUserNameValid => userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserName) => isUserName ? null : StringManager.invalidUserName);

  // - register inputs
  @override
  Sink get passwordInput => passwordStreamController.sink;

  @override
  Sink get phoneNumberInput => phoneNumberStreamController.sink;

  @override
  Sink get profilePictureInput => profilePictureStreamController.sink;

  @override
  Sink get userNameInput => userNameStreamController.sink;

  @override
  // TODO: implement emailInput
  Sink get emailInput => emailStreamController.sink;

  // -- private functions

  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isPhoneNumberValid(String phoneNumber) {
    return phoneNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length > 5;
  }
}

abstract class RegisterViewModelInput {
  Sink get userNameInput;
  Sink get phoneNumberInput;
  Sink get emailInput;
  Sink get passwordInput;
  Sink get profilePictureInput;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsPhoneNumberValid;
  Stream<String?> get outputErrorPhoneNumber;

  Stream<bool> get outputIsEmailIValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File> get outputIsProfilePictureValid;
}
