import 'dart:ui';

import 'package:flutter/material.dart';

final Color primaryColor = const Color(0xFF6656B7);
final Color dividerColor = const Color(0xFFDFE2E9);

final theme = ThemeData(
    appBarTheme: const AppBarTheme(
        color: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black)),
    dividerColor: Colors.black,
    fontFamily: '',
    backgroundColor: const Color(0xFFF2EFF6),
    focusColor: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    accentColor: primaryColor,
    primaryColor: primaryColor,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
    textTheme: const TextTheme(
        headline1: TextStyle(
            fontFamily: 'NanumSquareRound',
            fontSize: 24,
            fontWeight: FontWeight.w900),
        headline2: TextStyle(
            fontFamily: 'NanumSquareRound',
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.black),
        headline3: TextStyle(
            fontFamily: 'NanumSquareRound',
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.black),
        headline4: TextStyle(
            fontFamily: 'NanumSquareRound',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black),
        headline5: TextStyle(
            fontFamily: 'NanumSquareRound',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.black),
        headline6: TextStyle(
            fontFamily: 'NanumSquareRound',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.black),
        subtitle1: TextStyle(
            fontFamily: 'NanumSquareRound',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black),
        subtitle2: TextStyle(
            fontFamily: 'NanumSquareRound',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.black),
        bodyText1: TextStyle(
            fontFamily: 'NanumSquareRound',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black),
        bodyText2: TextStyle(
            fontFamily: 'NanumSquareRound',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black),
        button: TextStyle(
            fontFamily: 'NanumSquareRound',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.black)));
