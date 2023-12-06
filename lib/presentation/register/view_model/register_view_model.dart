import 'dart:async';
import 'dart:io';
import 'package:tut_app/domain/usecase/register_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../../application/app_prfs.dart';
import '../../../application/di.dart';
import '../../../application/functions.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_rendrer_impl.dart';
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

  StreamController isUserRegisteredSuccessfullyStreamController = StreamController<bool>();


  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);

  var registerObject = RegisterObject(
    "",
    "",
    "",
    "",
    "",
    "",
  );

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    userNameStreamController.close();
    phoneNumberStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputsValidStreamController.close();
    isUserRegisteredSuccessfullyStreamController.close();
  }

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
  Sink get emailInput => emailStreamController.sink;

  @override
  Sink get inPutAreAllInputsValid => areAllInputsValidStreamController.sink;

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _registerUseCase.execute(RegisterUseCaseInput(
      registerObject.userName,
      registerObject.countryCode,
      registerObject.phoneNumber,
      registerObject.email,
      registerObject.password,
      registerObject.profilePicture,
    )))
        .fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, failure.message));
      // failure
    }, (data) {
      inputState.add(ContentState());

      // navigate to main screen
      isUserRegisteredSuccessfullyStreamController.add(true);
      // data (success)
    });
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      // add the value in register object
      registerObject = registerObject.copyWith(countryCode: countryCode);
    } else {
      // reset the value to empty string again
      registerObject = registerObject.copyWith(countryCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    emailInput.add(email);
    if (isEmailValid(email)) {
      // add the value in register object
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset the value to empty string again
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    passwordInput.add(password);
    if (_isPasswordValid(password)) {
      // add the value in register object
      registerObject = registerObject.copyWith(password: password);
    } else {
      // reset the value to empty string again
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setPhoneNumber(String phoneNumber) {
    phoneNumberInput.add(phoneNumber);
    if (_isPhoneNumberValid(phoneNumber)) {
      // add the value in register object
      registerObject = registerObject.copyWith(phoneNumber: phoneNumber);
    } else {
      // reset the value to empty string again
      registerObject = registerObject.copyWith(phoneNumber: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    profilePictureInput.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  @override
  setUserName(String userName) {
    userNameInput.add(userName);
    if (_isUserNameValid(userName)) {
      // add the value in register object
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset the value to empty string again
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  // outputs ---------

  @override
  Stream<File> get outputProfilePicture =>
      profilePictureStreamController.stream.map((file) => file);

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

  @override
  Stream<bool> get outputAreAllInputsValid =>
      areAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

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

  bool _isAllInputsValid() {
    return registerObject.userName.isNotEmpty &&
        registerObject.countryCode.isNotEmpty &&
        registerObject.phoneNumber.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  validate() {
    inPutAreAllInputsValid.add(null);
  }



}

abstract class RegisterViewModelInput {
  Sink get userNameInput;
  Sink get phoneNumberInput;
  Sink get emailInput;
  Sink get passwordInput;
  Sink get profilePictureInput;
  Sink get inPutAreAllInputsValid;

  setUserName(String userName);
  setCountryCode(String countryCode);
  setPhoneNumber(String phoneNumber);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
  register();
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

  Stream<File> get outputProfilePicture;

  Stream<bool> get outputAreAllInputsValid;
}
