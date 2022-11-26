import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PetTextField extends StatelessWidget {
  PetTextField(
      {this.controller,
      this.hintText,
      this.readOnly = false,
      this.onTap,
      this.suffixIcon,
      this.validator,
      this.keyboardType
      });

  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
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
            hintText: hintText),
        validator: validator
    );
  }
}
