import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(fontWeight: FontWeight.bold,
          fontSize: 14.0),
        ),
      ),
    );
  }
}
