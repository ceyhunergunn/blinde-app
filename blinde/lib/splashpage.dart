import 'package:blinde_v09/homepage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: HomePage(),
      title: Text(
        'BLINDE',
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          fontSize: 50,
          color: Colors.black,
        ),
      ),
      image: Image.asset(
        'assets/blinde.png',
      ),
      backgroundColor: Colors.green.shade800,
      photoSize: 110,
      loaderColor: Colors.black,
    );
  }
}
