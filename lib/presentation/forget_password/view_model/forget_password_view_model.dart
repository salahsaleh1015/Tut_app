import 'dart:async';

import 'package:tut_app/domain/usecase/forget_password_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';
import 'package:tut_app/presentation/common/state_renderer/state_rendrer_impl.dart';

import '../../common/state_renderer/state_renderer.dart';

class ForgetPasswordViewModel extends BaseViewModel
    implements ForgetPasswordViewModelInput, ForgetPasswordViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController isUserResetStreamController = StreamController<bool>();

  var forgetPasswordObject = ForgetPasswordObject("");

  final ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    isUserResetStreamController.close();
  }

  @override

  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Stream<bool> get isOutUserName => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  @override
  reset() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgetPasswordUseCase
            .execute(ResetUseCaseInput(forgetPasswordObject.userName)))
        .fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, failure.message));
      // failure
    }, (data) {
      inputState.add(SuccessState(data.supportMessage));

      // navigate to main screen
      isUserResetStreamController.add(true);
      // data (success)
    });
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    forgetPasswordObject = forgetPasswordObject.copyWith(userName: userName);
  }

  @override
  Sink get inputEmailValid => isUserResetStreamController.sink;

  @override
  Stream<bool> get isEmailValid =>
      isUserResetStreamController.stream.map((_) => _isAllInputValid());

  bool _isAllInputValid() {
    return _isUserNameValid(forgetPasswordObject.userName);
  }
}

abstract class ForgetPasswordViewModelInput {
  setUserName(String userName);
  reset();

  Sink get inputUserName;
  Sink get inputEmailValid;
}

abstract class ForgetPasswordViewModelOutput {
  Stream<bool> get isOutUserName;
  Stream<bool> get isEmailValid;
}
