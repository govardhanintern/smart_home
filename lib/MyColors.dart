import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

class MyColors {
  static Color colorPrimaryDark = Color(0xff3d4493);
  static Color colorPrimaryLight = Color(0x373E4095);
  static Color mDarkGreen = Color(0xff3B8F06);
  static Color wishlistPink = Color(0xffF4B3EA);
  static Color mGray2 = Color(0xffEFEFEF);

  static Color grey10 = Color(0xffe6e6e6);
  static Color grey30 = Color(0xff909090);
  static Color grey60 = Color(0xff666666);
  static Color grey80 = Color(0xff37474F);
  static Color grey90 = Color(0xff263238);

  static Color red300 = Color(0xffE57373);
  static Color red500 = Color(0xffF44336);
  static Color red600 = Color(0xffd00808);
  static Color red700 = Color(0xffD32F2F);
  static Color red800 = Color(0xffC62828);

  static Color mainColor = Color(0xff1A81FB);
  static Color mBackColor = Color(0xffe5edf6);
  static Color secondColor = Color(0xff073156);
  static Color greyColor = Color(0xff8D8D8D);
  static Color backGroundColor = Color(0xffE5E5E5);
  static Color lgrey = Color(0x2fefefef);
  static Color orng = Color(0xffFB6B1A);


  static Color gColor = Color(0xff5383EC);
  static Color fColor = Color(0xff4A66AC);
  static Color appWhite = Color(0xffE5E5E5);
  static Color green = Color(0xff53B175);
  static Color star = Color(0xffF3603F);

  static Color blue300 = Color(0xff64B5F6);
  static Color blue800 = Color(0xff1565C0);
  static Color blue900 = Color(0xff0D47A1);

  // static Color colorPrimaryLight = Color(0x56832343);

  static Color pink600 = Color(0xffD81B60);
  static Color pink800 = Color(0xffAD1457);

  static Color green300 = Color(0xff81C784);
  static Color green400 = Color(0xff66BB6A);
  static Color green500 = Color(0xff4CAF50);
  static Color green600 = Color(0xff43A047);
  static Color green800 = Color(0xff2E7D32);

  static Color purple500 = Color(0xff673AB7);

  static Color yellow300 = Color(0xffFFF176);
  static Color yellow800 = Color(0xffF9A825);

  static Color colorAccent = Color(0xff02a55a);
  static Color white = Color(0xffffffff);
  static Color black = Color(0xff000000);
  static Color black12 = Color(0x1F000000);
  static Color red = Color(0xffFF0F00);
  static Color orange = Color(0xFFFF5722);
  static Color red_d = Color(0xffFF0101);
  static Color grey = Color(0xff545252);
  static Color grey_2 = Color(0xff636060);
  static Color lightGrey = Color(0xffE9E8E8);
  static Color Profile_Grey = Color(0xfffafafa);

  static Color pink1 = Color(0xFFFCE4EC);
  static Color pink2 = Color(0xFFF8BBD0);
  static Color pink3 = Color(0xFFF48FB1);
  static Color pink4 = Color(0xFFF06292);
  static Color pink5 = Color(0xFFEC407A);
  static Color pink6 = Color(0xFFD81B60);
  static Color pink7 = Color(0xFFC2185B);
  static Color pink8 = Color(0xFFAD1457);

  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}
