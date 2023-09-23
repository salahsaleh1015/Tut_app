import 'package:flutter/material.dart';
import 'package:tut_app/presentation/color_maneger.dart';
import 'package:tut_app/presentation/font_manager.dart';
import 'package:tut_app/presentation/style_maneger.dart';
import 'package:tut_app/presentation/values_maneger.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      primaryColor: ColorManager.primary,
      primaryColorDark: ColorManager.darkPrimary,
      primaryColorLight: ColorManager.lightPrimary,
      disabledColor: ColorManager.grey1,
      cardTheme: CardTheme(
        color: ColorManager.white,
        elevation: AppSize.s4,
        shadowColor: ColorManager.grey,
      ),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.lightPrimary,
          titleTextStyle: getRegularTextStyle(
              color: ColorManager.white, fontSize: FontSize.s14)),
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
      splashColor: ColorManager.lightPrimary,
      buttonColor: ColorManager.primary,
      disabledColor: ColorManager.grey1,

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularTextStyle(color: ColorManager.white,fontSize: AppSize.s18),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s4),

        )
      )
    )

  );
}
