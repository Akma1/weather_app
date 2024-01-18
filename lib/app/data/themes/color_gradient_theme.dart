import 'package:flutter/material.dart';

enum ColorTheme {
  blue,
  sky,
  orange,
  grey,
  red,
  night,
  midNight,
}

const ColorTheme settingTheme = ColorTheme.blue;
const ColorTheme settingButtonTheme = ColorTheme.blue;
const ColorTheme settingAppBarTheme = ColorTheme.blue;

List<Color> buildGradientThemeBackground({ColorTheme? theme = settingTheme}) {
  List<Color> listColor = [];
  switch (theme) {
    case ColorTheme.blue:
      listColor = [
        Colors.blue.shade900,
        Colors.blue.shade700,
        Colors.blue.shade500,
        Colors.blue,
        Colors.blue,
        Colors.blue,
        Colors.blue,
      ];
      break;
    case ColorTheme.red:
      listColor = [
        Colors.red.shade900,
        Colors.red.shade700,
        Colors.red.shade500,
        Colors.red,
        Colors.red,
        Colors.red,
        Colors.red,
      ];
      break;
    case ColorTheme.sky:
      listColor = [
        Colors.blue.shade400,
        Colors.blue.shade200,
        Colors.blue.shade100,
        Colors.blue.shade50,
      ];
      break;
    case ColorTheme.orange:
      listColor = [
        const Color(0xff1f005c),
        const Color(0xff5b0060),
        const Color(0xff870160),
        const Color(0xffac255e),
        const Color(0xffca485c),
        const Color(0xffe16b5c),
        const Color(0xfff39060),
        const Color(0xffffb56b),
      ];
      break;
    case ColorTheme.night:
      listColor = [
        const Color(0xff1f005c),
        const Color(0xff1f005c),
        const Color(0xff1f005c),
        const Color(0xff1f005c),
        const Color(0xff5b0060),
        const Color(0xff5b0060),
        const Color(0xff5b0060),
        const Color(0xff5b0060),
      ];
      break;
    case ColorTheme.midNight:
      listColor = [
        const Color(0xff1f005c),
        const Color(0xff1f005c),
        const Color(0xff1f005c),
        const Color(0xff1f005c),
        const Color(0xff5b0060),
      ];
      break;
    case ColorTheme.grey:
      listColor = [
        Colors.grey.shade900,
        Colors.grey.shade700,
        Colors.grey.shade500,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
      ];
      break;
    default:
      listColor = [
        Colors.blue.shade900,
        Colors.blue.shade700,
        Colors.blue.shade500,
        Colors.blue,
        Colors.blue,
        Colors.blue,
        Colors.blue,
      ];
  }
  return listColor;
}

List<Color> buildGradientThemeAppBar({ColorTheme? theme = settingAppBarTheme}) {
  List<Color> listColor = [];
  switch (theme) {
    case ColorTheme.blue:
      listColor = [
        Colors.blue.shade900,
        Colors.blue.shade700,
      ];
      break;
    case ColorTheme.red:
      listColor = [
        Colors.red.shade900,
        Colors.red.shade700,
      ];
      break;
    case ColorTheme.orange:
      listColor = [
        const Color(0xff1f005c),
        const Color(0xff5b0060),
      ];
      break;
    case ColorTheme.night:
      listColor = [
        const Color(0xff1f005c),
        const Color(0xff1f005c),
      ];
      break;
    case ColorTheme.midNight:
      listColor = [
        const Color(0xff1f005c),
        const Color(0xff1f005c),
      ];
      break;
    case ColorTheme.sky:
      listColor = [
        Colors.blue.shade400,
        Colors.blue.shade300,
      ];
      break;
    case ColorTheme.grey:
      listColor = [
        Colors.grey.shade900,
        Colors.grey.shade700,
      ];
      break;
    default:
      listColor = [
        Colors.blue.shade900,
        Colors.blue.shade700,
      ];
  }
  return listColor;
}

List<Color> buildGradientThemeButton({ColorTheme? theme = settingButtonTheme}) {
  List<Color> listColor = [];
  switch (theme) {
    case ColorTheme.blue:
      listColor = [
        Colors.blue.shade700,
        Colors.blue.shade400,
      ];
      break;
    case ColorTheme.red:
      listColor = [
        Colors.red.shade700,
        Colors.red.shade400,
      ];
      break;
    case ColorTheme.grey:
      listColor = [
        Colors.grey.shade700,
        Colors.grey.shade400,
      ];
      break;
    default:
      listColor = [
        Colors.blue.shade700,
        Colors.blue.shade400,
      ];
  }
  return listColor;
}

//==================================================== WIDGET ============================================================//

buildStreamBackgroundThemeWidget({List<Color>? customGradient, Widget? child, ColorTheme? theme}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: customGradient ??
            buildGradientThemeBackground(
              theme: theme ?? ColorTheme.blue, //Get.find<AuthController>().isBackgroundTheme,
            ),
      ),
    ),
    child: child,
  );
}
