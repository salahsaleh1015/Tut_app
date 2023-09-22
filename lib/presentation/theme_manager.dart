import 'package:flutter/material.dart';
import 'package:tut_app/presentation/color_maneger.dart';
import 'package:tut_app/presentation/values_maneger.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
    primaryColor:ColorManager.primary ,
    primaryColorDark:ColorManager.darkPrimary ,
    primaryColorLight:ColorManager.lightPrimary ,
    disabledColor:ColorManager.grey1,
    cardTheme: CardTheme(
      color: ColorManager.white,
      elevation:AppSize.s4,
      shadowColor:ColorManager.grey ,
    )
  );
}