import 'package:flutter/material.dart';

class PetTextField extends StatelessWidget {
  PetTextField(
      {this.controller,
      this.hintText,
      this.readOnly = false,
      this.onTap,
      this.suffixIcon});

  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        readOnly: readOnly!,
        onTap: onTap,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Color(0xFFDFE2E9))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color(0xFFDFE2E9))),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Color(0xFFDFE2E9))),
            hintText: hintText));
  }
}
