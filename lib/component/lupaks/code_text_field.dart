import 'package:flutter/material.dart';
import 'package:e_lijuk/widget/style.dart';

class CodeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final int? maxLength;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const CodeTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.contentPadding,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength,
      textAlign: textAlign,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.green), // Border color
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.green), // Border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.green), // Border color
        ),
      ),
    );
  }
}
