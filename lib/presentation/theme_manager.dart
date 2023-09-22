import 'package:flutter/material.dart';
import 'package:tut_app/presentation/color_maneger.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
    primaryColor:ColorManager.primary ,
    primaryColorDark:ColorManager.darkPrimary ,
    primaryColorLight:ColorManager.lightPrimary ,
    disabledColor:ColorManager.grey1,
  );
}