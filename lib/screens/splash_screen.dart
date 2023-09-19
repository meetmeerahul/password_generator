import 'package:flutter/material.dart';
import 'package:password_generator/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use a Future.delayed to navigate to the SecondScreen after 3 seconds.
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    });

    return Container(
      color: Colors.white,
      child: const Column(
        children: [
          Image(
            image: AssetImage('assets/logo.png'),
          ),
          Text(
            "PassGen",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontStyle: FontStyle.normal,
            ),
          )
        ],
      ),
    );
  }
}
