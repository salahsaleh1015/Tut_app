import 'dart:async';
import 'dart:ffi';

import 'package:tut_app/domain/usecase/home_details_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../../domain/entities/entities.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_rendrer_impl.dart';

class HomeDetailsViewModel extends BaseViewModel
    implements HomeViewModelInputs, HomeViewModelOutputs {
  final _homeDetailsStreamController =
      StreamController<HomeDetails>.broadcast();

  final HomeDetailsUseCase _homeDetailsUseCase;

  HomeDetailsViewModel(this._homeDetailsUseCase);

  @override
  void start() {
    _loadData();
  }

  _loadData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeDetailsUseCase.execute(Void)).fold(
      (failure) {
        inputState.add(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message));
      },
      (homeDetails) async {
        inputState.add(ContentState());
        inputHomeDetails.add(homeDetails);
      },
    );
  }

  @override
  Sink get inputHomeDetails => _homeDetailsStreamController.sink;

  @override
  Stream<HomeDetails> get outputHomeDetails =>
      _homeDetailsStreamController.stream.map((details) => details);



  @override
  void dispose() {
    _homeDetailsStreamController.close();
    super.dispose();
  }
}

abstract class HomeViewModelInputs {
  Sink get inputHomeDetails;
}

abstract class HomeViewModelOutputs {
  Stream<HomeDetails> get outputHomeDetails;
}
