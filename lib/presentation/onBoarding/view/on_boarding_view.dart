import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/onBoarding/view_model/onBoarding_view_model.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_maneger.dart';
import 'package:tut_app/presentation/resources/constants_maneger.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/values_maneger.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark),
          backgroundColor: ColorManager.white,
        ),
        body: PageView.builder(
            controller: _pageController,
            itemCount: sliderViewObject.numOfSlides,
            onPageChanged: (index) {
              _viewModel.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return OnBoardingPage(sliderViewObject.sliderObject);
            }),
        bottomSheet: Container(
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.loginRoute);
                    },
                    child: Text(StringManager.skip,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleMedium),
                  )),
              Container(
                color: ColorManager.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p14),
                      child: GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(_viewModel.goPrevious(),
                              duration: const Duration(
                                  milliseconds:
                                      AppConstant.animationSliderTime),
                              curve: Curves.bounceInOut);
                        },
                        child: SizedBox(
                          height: AppSize.s20,
                          width: AppSize.s20,
                          child: SvgPicture.asset(ImageAssets.leftArrowIc),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                          Padding(
                            padding: const EdgeInsets.all(AppPadding.p10),
                            child: _getProperWidget(
                                i, sliderViewObject.currentIndex),
                          )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p14),
                      child: GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(_viewModel.goNext(),
                              duration: const Duration(
                                  milliseconds:
                                      AppConstant.animationSliderTime),
                              curve: Curves.bounceInOut);
                        },
                        child: SizedBox(
                          height: AppSize.s20,
                          width: AppSize.s20,
                          child: SvgPicture.asset(ImageAssets.rightArrowIc),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget _getProperWidget(int index, int currentIndex) {
    if (index == currentIndex) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: SvgPicture.asset(ImageAssets.hollowCircleIc),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: SvgPicture.asset(ImageAssets.solidCircleIc),
      );
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
  const OnBoardingPage(this._sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSize.s40,
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(
              _sliderObject.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(
              _sliderObject.subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(
            height: AppSize.s60,
          ),
          SvgPicture.asset(_sliderObject.image),
        ],
      ),
    );
  }
}
