import 'dart:async';

import 'package:tut_app/presentation/common/state_renderer/state_rendrer_impl.dart';

abstract class BaseViewModel
    implements BaseViewModelInputs, BaseViewModelOutPuts {
  final StreamController _inputStreamController =
      StreamController<FlowState>.broadcast();

  @override
  // TODO: implement inputState
  Sink get inputState => _inputStreamController.sink;

  @override
  // TODO: implement outputState
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); // when view model start

  void dispose(); // when view model gonna die

  Sink get inputState;
}

abstract class BaseViewModelOutPuts {
  Stream<FlowState> get outputState;
}
