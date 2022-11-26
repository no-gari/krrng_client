import 'package:flutter/material.dart';

class SizedDivider extends StatelessWidget {
  const SizedDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.5,
        width: double.maxFinite,
        color: Colors.black12,
        margin: EdgeInsets.symmetric(vertical: 30));
  }
}
