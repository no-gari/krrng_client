import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

String currencyFromString(String value) {
  return toCurrencyString(value, mantissaLength: 0, trailingSymbol: "P");
}

String currencyFromStringWon(String value) {
  return toCurrencyString(value, mantissaLength: 0, leadingSymbol: "₩");
}

String distanceFromString(String value) {
  if (value.length > 3) {
    int length = value.length;
    var new_val = '';
    for (var i = 0; i <= length - 3; i++) {
      if (i == length - 3) {
        new_val = new_val + '.' + value[i] + 'km';
      } else {
        new_val = new_val + value[i];
      }
    }
    return new_val;
  } else {
    return toCurrencyString(value, mantissaLength: 0, trailingSymbol: "m");
  }
}

double maxWidth(context) {
  return MediaQuery.of(context).size.width;
}

double maxHeight(context) {
  return MediaQuery.of(context).size.height;
}

bool isValidPhoneNumberFormat(String phone) {
  return RegExp(r'^010?([0-9]{4})?([0-9]{4})$').hasMatch(phone);
}
