import 'dart:async';
import 'dart:ffi';

import 'package:tut_app/domain/entities/entities.dart';
import 'package:tut_app/domain/usecase/home_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../../common/state_renderer/state_renderer.dart';
import '../../../common/state_renderer/state_rendrer_impl.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInputs, HomeViewModelOutputs {
  HomeViewModel(this._homeUseCase);
  final HomeUseCase _homeUseCase;

  final StreamController _homeDataStreamController =
      StreamController<HomeViewObject>.broadcast();

  @override
  void start() {
    getHomeData();
  }

  getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void)).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message));
      // failure
    }, (homeObject) {
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(homeObject.data.banners,
          homeObject.data.services, homeObject.data.stores));

      // data (success)
    });
  }

  @override
  void dispose() {
    _homeDataStreamController.close();
    super.dispose();
  }

  //--- InPuts
  @override

  Sink get inputHomeData => _homeDataStreamController.sink;

//---- OutPuts

  @override

  Stream<HomeViewObject> get outputHomeData =>
      _homeDataStreamController.stream.map((homeData) => homeData);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}


class HomeViewObject {
  List<BannerAd> banners;
  List<Service> services;
  List<Store> stores;

  HomeViewObject(this.banners, this.services, this.stores);
}
