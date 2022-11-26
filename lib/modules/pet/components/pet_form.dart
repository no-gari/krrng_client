import 'package:flutter/widgets.dart';
import 'package:krrng_client/support/style/theme.dart';

Widget PetFormHeader(String text) {
  return Text.rich(
      TextSpan(text: text, style: font_17_w900,
          children: [
            TextSpan(text: "*", style: font_17_w900.copyWith(color: primaryColor))
          ]
      )
  );
}