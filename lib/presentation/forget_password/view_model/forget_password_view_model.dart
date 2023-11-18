import 'dart:async';

import 'package:tut_app/domain/usecase/forget_password_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';
import 'package:tut_app/presentation/common/state_renderer/state_rendrer_impl.dart';

class ForgetPasswordViewModel
    implements
        BaseViewModel,
        ForgetPasswordViewModelInput,
        ForgetPasswordViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();

  var forgetPasswordObject = ForgetPasswordObject("");

  final ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _userNameStreamController.close();
  }

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Stream<bool> get isOutUserName => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));
  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  @override
  reset() async {
    (await _forgetPasswordUseCase
            .execute(ResetUseCaseInput(forgetPasswordObject.userName)))
        .fold((failure) => null, (data) => null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    forgetPasswordObject = forgetPasswordObject.copyWith(userName: userName);
  }

  @override
  // TODO: implement inputState
  Sink get inputState => throw UnimplementedError();

  @override
  // TODO: implement outputState
  Stream<FlowState> get outputState => throw UnimplementedError();
}

abstract class ForgetPasswordViewModelInput {
  setUserName(String userName);
  reset();

  Sink get inputUserName;
}

abstract class ForgetPasswordViewModelOutput {
  Stream<bool> get isOutUserName;
}
