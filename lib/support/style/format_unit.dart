import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

String currencyFromString(String value) {
  return toCurrencyString(value, mantissaLength: 0, trailingSymbol: "P");
}

String currencyFromStringWon(String value) {
  return toCurrencyString(value, mantissaLength: 0, leadingSymbol: "₩");
}

double maxWidth(context) {
  return MediaQuery.of(context).size.width;
}

double maxHeight(context) {
  return MediaQuery.of(context).size.height;
}
