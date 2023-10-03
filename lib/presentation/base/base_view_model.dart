abstract class BaseViewModel
    implements BaseViewModelInputs, BaseViewModelOutPuts {}

abstract class BaseViewModelInputs {
  void start(); // when view model start

  void dispose(); // when view model gonna die
}

abstract class BaseViewModelOutPuts {}
