import 'package:flutter/material.dart';
import 'package:krrng_client/support/style/theme.dart';

OutlineInputBorder outline = OutlineInputBorder(
    borderRadius:BorderRadius.circular(12.0),
    borderSide: BorderSide(color: dividerColor)
);

OutlineInputBorder outline_focus = OutlineInputBorder(
    borderRadius:BorderRadius.circular(12.0),
    borderSide: BorderSide(color: primaryColor)
);


InputDecoration baseInputDecoration(String placeHolder) {
  return InputDecoration(
      isCollapsed: true,
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 13),
      enabledBorder: outline,
      focusedBorder: outline_focus,
      border: outline,
      hintText: placeHolder
  );
}

BoxDecoration thumbnailDecoration = BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: dividerColor), color: Color(0xfffbfbfb));
