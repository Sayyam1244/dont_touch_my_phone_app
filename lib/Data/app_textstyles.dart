import 'package:dont_touch_phone/Data/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle circularStdBold(
          {double? fontSize,
          Color? color,
          FontWeight? fontWeight,
          double? letterSpacing,
          TextDecoration? decoration,
          Color? decorationColor}) =>
      TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? AppColors.blackColor,
        fontFamily: "circularStd Bold",
      );
  static TextStyle circularStdRegular(
          {double? fontSize,
          Color? color,
          FontWeight? fontWeight,
          double? letterSpacing,
          TextDecoration? decoration,
          Color? decorationColor}) =>
      TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.blackColor,
        fontFamily: "circularStd Regular",
      );
  static TextStyle circularStdMedium(
          {double? fontSize,
          Color? color,
          FontWeight? fontWeight,
          double? letterSpacing,
          TextDecoration? decoration,
          Color? decorationColor}) =>
      TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.blackColor,
        fontFamily: "circularStd Medium",
      );
  static TextStyle sfProRegular(
          {double? fontSize,
          Color? color,
          FontWeight? fontWeight,
          double? letterSpacing,
          TextDecoration? decoration,
          Color? decorationColor}) =>
      TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.blackColor,
        fontFamily: "SF Pro Regular",
      );
  static TextStyle sfProLight(
          {double? fontSize,
          Color? color,
          FontWeight? fontWeight,
          double? letterSpacing,
          TextDecoration? decoration,
          Color? decorationColor}) =>
      TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w200,
        color: color ?? AppColors.blackColor,
        fontFamily: "SF Pro Light",
      );
}
