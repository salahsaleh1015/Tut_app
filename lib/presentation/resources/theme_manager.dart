import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/color_maneger.dart';
import 'package:tut_app/presentation/resources/font_manager.dart';
import 'package:tut_app/presentation/resources/style_maneger.dart';
import 'package:tut_app/presentation/resources/values_maneger.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor:ColorManager.white ,
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

              textStyle: getRegularTextStyle(

                  color: ColorManager.white, fontSize: FontSize.s18),
              primary: ColorManager.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s4),
              )),
      ),
      textTheme: TextTheme(
        displayLarge: getSemiBoldTextStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s16),
        displayMedium: getRegularTextStyle(color: ColorManager.darkGrey, fontSize: FontSize.s14),
        titleMedium: getMediumTextStyle(
            color: ColorManager.primary, fontSize: FontSize.s16),
        titleSmall: getRegularTextStyle(
            color: ColorManager.white, fontSize: FontSize.s16),
        bodySmall: getRegularTextStyle(color: ColorManager.grey1),
        bodyLarge: getRegularTextStyle(color: ColorManager.grey),
      ),
      inputDecorationTheme: InputDecorationTheme(

        contentPadding: EdgeInsets.all(AppPadding.p8),
        hintStyle: getRegularTextStyle(
            color: ColorManager.grey, fontSize: FontSize.s14),
        labelStyle: getRegularTextStyle(
            color: ColorManager.grey, fontSize: FontSize.s14),
        errorStyle: getRegularTextStyle(
          color: ColorManager.error,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: BorderSide(
              color: ColorManager.grey,
              width: AppSize.s1_5,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: BorderSide(
              color: ColorManager.primary,
              width: AppSize.s1_5,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: BorderSide(
              color: ColorManager.error,
              width: AppSize.s1_5,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: BorderSide(
              color: ColorManager.primary,
              width: AppSize.s1_5,
            )),
      ));
}
