import 'package:flutter/material.dart';
import 'package:password_generator/controllers/home_controller.dart';

class PasswordType extends StatelessWidget {
  const PasswordType(
      {super.key,
      required this.homeController,
      required this.onPressed,
      required this.text,
      required this.keyType});

  final HomeController homeController;
  final VoidCallback? onPressed;
  final Text text;
  final bool keyType;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 1.0),
            backgroundColor: keyType ? Colors.teal.shade300 : Colors.white),
        child: text);
  }
}
