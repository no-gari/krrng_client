import 'dart:ui';
import 'package:flutter/material.dart';

export 'custom_property.dart';

final Color primaryColor = const Color(0xFF6656B7);
final Color dividerColor = const Color(0xFFDFE2E9);
final Color listViewDividerColor = const Color(0xFFf3f3f3);
final Color subtitleColor = const Color(0xFF999999);

final TextStyle font_24_w900 = const TextStyle(fontFamily: 'NanumSquareRound', fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black);
final TextStyle font_22_w900 = const TextStyle(fontFamily: 'NanumSquareRound', fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black);
final TextStyle font_20_w900 = const TextStyle(fontFamily: 'NanumSquareRound', fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black);
final TextStyle font_16_w900 = const TextStyle(fontFamily: 'NanumSquareRound', fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black);
final TextStyle font_17_w900 = const TextStyle(fontFamily: 'NanumSquareRound', fontSize: 17, fontWeight: FontWeight.w900, color: Colors.black);
final TextStyle font_18_w900 = const TextStyle(fontFamily: 'NanumSquareRound', fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black);
final TextStyle font_16_w700 = const TextStyle(fontFamily: 'NanumSquareRound', fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black);
final TextStyle font_14_w700 = const TextStyle(fontFamily: 'NanumSquareRound', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black);
final TextStyle font_12_w700 = const TextStyle(fontFamily: 'NanumSquareRound', fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black);
final TextStyle font_15_w500 = const TextStyle(fontFamily: 'NanumSquareRound', fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black);
final TextStyle font_14_w500 = const TextStyle(fontFamily: 'NanumSquareRound', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black);
final TextStyle font_12_w500 = const TextStyle(fontFamily: 'NanumSquareRound', fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black);

final theme = ThemeData(
    appBarTheme: const AppBarTheme(
        color: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black)),
    dividerColor: Colors.black,
    fontFamily: 'NanumSquareRound',
    backgroundColor: const Color(0xFFF2EFF6),
    focusColor: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    accentColor: primaryColor,
    primaryColor: primaryColor,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
    textTheme: TextTheme(
        headline1: font_24_w900,
        headline2: font_20_w900,
        headline3: font_18_w900,
        headline4: font_16_w700,
        headline5: font_14_w700,
        headline6: font_12_w700,
        subtitle1: font_16_w700,
        subtitle2: font_14_w700,
        bodyText1: font_15_w500,
        bodyText2: font_12_w500,
        button: font_14_w700)
);
