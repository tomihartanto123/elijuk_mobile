import 'package:flutter/material.dart';

class ResendButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ResendButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text("Kirim ulang"),
    );
  }
}
