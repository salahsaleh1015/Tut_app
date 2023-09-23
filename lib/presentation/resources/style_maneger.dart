import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(
    {required Color color,
    required double fontSize,
    required FontWeight fontWeight}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: FontConstants.fontFamily,
  );
}

TextStyle getRegularTextStyle({
  required Color color,
  double fontSize = FontSize.s12,
}) {
  return _getTextStyle(
      color: color, fontSize: fontSize, fontWeight: FontWightManager.regular);
}

TextStyle getLightTextStyle({
  required Color color,
  double fontSize = FontSize.s12,
}) {
  return _getTextStyle(
      color: color, fontSize: fontSize, fontWeight: FontWightManager.light);
}

TextStyle getBoldTextStyle({
  required Color color,
  double fontSize = FontSize.s12,
}) {
  return _getTextStyle(
      color: color, fontSize: fontSize, fontWeight: FontWightManager.bold);
}

TextStyle getSemiBoldTextStyle({
  required Color color,
  double fontSize = FontSize.s12,
}) {
  return _getTextStyle(
      color: color, fontSize: fontSize, fontWeight: FontWightManager.semiBold);
}

TextStyle getMediumTextStyle({
  required Color color,
  double fontSize = FontSize.s12,
}) {
  return _getTextStyle(
      color: color, fontSize: fontSize, fontWeight: FontWightManager.medium);
}
