import 'package:flutter/material.dart';

final theme = ThemeData(
    appBarTheme: const AppBarTheme(
        color: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black)),
    dividerColor: Colors.black,
    fontFamily: '',
    backgroundColor: const Color(0xFFFFFFFF),
    focusColor: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    accentColor: const Color(0xFF6656B7),
    primaryColor: const Color(0xFF6656B7),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
    textTheme: const TextTheme(
        headline1: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 35,
            fontWeight: FontWeight.w900),
        headline2: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.black),
        headline3: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: Colors.black),
        headline4: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black),
        headline5: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black),
        headline6: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.black),
        subtitle1: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black),
        subtitle2: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.black),
        bodyText1: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black),
        bodyText2: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black),
        button: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black)));
