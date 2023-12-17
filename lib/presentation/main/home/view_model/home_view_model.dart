import 'dart:async';

import 'package:tut_app/domain/entities/entities.dart';
import 'package:tut_app/domain/usecase/home_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel  implements HomeViewModelInputs,HomeViewModelOutputs{
  HomeViewModel(this._homeUseCase);
  final HomeUseCase _homeUseCase;

  final StreamController _bannersStreamController =
      StreamController<List<BannerAd>>.broadcast();

  final StreamController _servicesStreamController =
      StreamController<List<Service>>.broadcast();

  final StreamController _storesStreamController =
      StreamController<List<Store>>.broadcast();

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  //--- InPuts
  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override

  Sink get inputStores =>_storesStreamController.sink;



//---- OutPuts
  @override
  Stream<List<BannerAd>> get outputBanners => _bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices => _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores =>_storesStreamController.stream.map((stores) => stores);
}

abstract class HomeViewModelInputs {
  Sink get inputBanners;
  Sink get inputServices;
  Sink get inputStores;
}

abstract class HomeViewModelOutputs {
  Stream<List<BannerAd>> get outputBanners;
  Stream<List<Service>> get outputServices;
  Stream<List<Store>> get outputStores;
}
