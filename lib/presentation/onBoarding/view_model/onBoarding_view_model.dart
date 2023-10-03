import 'dart:async';

import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../resources/assets_manager.dart';
import '../../resources/string_manager.dart';

class OnBoardingViewModel
    implements
        BaseViewModel,
        OnBoardingViewModelInputs,
        OnBoardingViewModelOutPuts {
  StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _pageCurrentIndex = 0;
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataInView();
  }

  @override
  int goNext() {
    int nextPageIndex = ++_pageCurrentIndex;
    if(nextPageIndex==-1){
      nextPageIndex = _list.length-1;
    }
    return nextPageIndex;
  }

  @override
  int goPrevious() {
    int previousPageIndex =--_pageCurrentIndex;
    if(previousPageIndex==-1){
      previousPageIndex = _list.length-1;
    }
    return previousPageIndex;
  }

  @override
  void onPageChanged(int index) {
    _pageCurrentIndex = index;
    _postDataInView();
  }
  List<SliderObject> _getSliderData() => [
        SliderObject(StringManager.onBoardingTitle1,
            StringManager.onBoardingSubTitle1, ImageAssets.onBoardingLogo1),
        SliderObject(StringManager.onBoardingTitle2,
            StringManager.onBoardingSubTitle2, ImageAssets.onBoardingLogo2),
        SliderObject(StringManager.onBoardingTitle3,
            StringManager.onBoardingSubTitle3, ImageAssets.onBoardingLogo3),
        SliderObject(StringManager.onBoardingTitle4,
            StringManager.onBoardingSubTitle4, ImageAssets.onBoardingLogo4),
      ];

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  _postDataInView(){
    inputSliderViewObject.add(SliderViewObject(_list[_pageCurrentIndex],  _pageCurrentIndex, _list.length));
  }
}

abstract class OnBoardingViewModelInputs {
  int goNext();
  int goPrevious();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutPuts {
  Stream<SliderViewObject> get outputSliderViewObject;
}
