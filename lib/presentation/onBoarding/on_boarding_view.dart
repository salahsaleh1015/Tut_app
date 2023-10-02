import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  late final List<SliderObject> _list = _getSliderData();
  final PageController _pageController = PageController();
  int _pageCurrentIndex = 0;
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
  Widget build(BuildContext context) {
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
          itemCount: _list.length,
          onPageChanged: (index) {
            setState(() {
              _pageCurrentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(_list[index]);
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
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child:
                  Text(StringManager.skip, textAlign: TextAlign.end,style: Theme.of(context).textTheme.titleMedium),
                )),
            Container(
              color: ColorManager.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p14),
                    child: GestureDetector(
                      onTap: (){
                        _pageController.animateToPage(_goPreviousPage(), duration: Duration(milliseconds:AppConstant.animationSliderTime ), curve: Curves.bounceInOut);
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
                      for(int i=0; i<_list.length;i++)
                        Padding(padding: EdgeInsets.all(AppPadding.p10),
                          child: _getProperWidget(i),

                        )
                    ],
                  ),



                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p14),
                    child: GestureDetector(
                      onTap: (){
                        _pageController.animateToPage(_goNextPage(), duration: Duration(milliseconds:AppConstant.animationSliderTime ), curve: Curves.bounceInOut);
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
  int  _goPreviousPage(){
    int previousPageIndex =--_pageCurrentIndex;
    if(previousPageIndex==-1){
      previousPageIndex = _list.length-1;
    }
    return previousPageIndex;
  }
  int  _goNextPage(){
    int nextPageIndex = ++_pageCurrentIndex;
    if(nextPageIndex==-1){
      nextPageIndex = _list.length-1;
    }
    return nextPageIndex;
  }

  Widget _getProperWidget(int index){
    if(index==_pageCurrentIndex){
      return Padding(padding: EdgeInsets.all(AppPadding.p8),
      child: SvgPicture.asset(ImageAssets.hollowCircleIc),
      );
    }else{
      return Padding(padding: EdgeInsets.all(AppPadding.p8),
        child: SvgPicture.asset(ImageAssets.solidCircleIc),
      );
    }
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

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}
