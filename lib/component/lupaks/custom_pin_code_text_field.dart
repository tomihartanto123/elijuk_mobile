import 'package:flutter/material.dart';

class CustomPinCodeTextField extends StatelessWidget {
  final BuildContext context;
  final Function(String) onChanged;

  const CustomPinCodeTextField({
    required this.context,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Enter OTP',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
