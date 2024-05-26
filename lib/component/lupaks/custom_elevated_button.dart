import 'package:flutter/material.dart';
import 'package:e_lijuk/widget/style.dart';

class CustomElevatedButton extends StatelessWidget {
  final double width;
  final String text;
  final VoidCallback onPressed;
  final MaterialColor backgroundColor;

  const CustomElevatedButton({
    required this.width,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          // primary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Atur tepi melengkung di sini
          ),
        ),
      ),
    );
  }
}
