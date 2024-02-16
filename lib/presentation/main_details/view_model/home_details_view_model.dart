

 import 'package:tut_app/domain/usecase/home_details_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

class HomeDetailsViewModel extends  BaseViewModel
 implements HomeViewModelInputs, HomeViewModelOutputs{

  final HomeDetailsUseCase _homeDetailsUseCase;

  HomeDetailsViewModel(this._homeDetailsUseCase);

  @override
  void start() {
    // TODO: implement start
  }

 }



 abstract class HomeViewModelInputs{}
 abstract class HomeViewModelOutputs{}

