import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_maneger.dart';
import 'package:tut_app/presentation/resources/constants_maneger.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';

import '../../application/app_prfs.dart';
import '../../application/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  Timer? _timer;
  _splashDelay() {
    _timer = Timer(const Duration(seconds: AppConstant.splashDelay), () {
      _goNext();
    });
  }

  _goNext() {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn){
      if(isUserLoggedIn){
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      }else{
        _appPreferences.isOnBoardingScreenViewed().then((isOnBoardingScreenViewed){
          if(isOnBoardingScreenViewed){
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          }else{
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          }
        });
      }
    });


  }

  @override
  void initState() {
    super.initState();
    _splashDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(image: AssetImage(ImageAssets.splashLogo)),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
