import 'package:flutter/material.dart';

class SingleDigitCodeTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode nextFocusNode;

  const SingleDigitCodeTextField({
    required this.controller,
    required this.nextFocusNode,
  });

  @override
  _SingleDigitCodeTextFieldState createState() => _SingleDigitCodeTextFieldState();
}

class _SingleDigitCodeTextFieldState extends State<SingleDigitCodeTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty) {
            widget.nextFocusNode.requestFocus();
          }
        },
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
