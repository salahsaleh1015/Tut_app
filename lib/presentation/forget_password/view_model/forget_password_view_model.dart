import 'dart:async';

import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/state_renderer/state_rendrer_impl.dart';

class ForgetPasswordViewModel
    implements
        BaseViewModel,
        ForgetPasswordViewModelInput,
        ForgetPasswordViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();

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
  Stream<bool> get outputUserName =>
      _userNameStreamController.stream.map((userName) =>_isUserNameValid (userName));
  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }


  @override
  reset() {
    // TODO: implement reset
    throw UnimplementedError();
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    throw UnimplementedError();
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
  Stream<bool> get outputUserName;
}
