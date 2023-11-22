import 'dart:async';
import 'dart:io';
import 'package:tut_app/presentation/base/base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
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

  Stream<bool> get outputIsProfilePictureValid;
  Stream<String?> get outputErrorProfilePicture;
}
