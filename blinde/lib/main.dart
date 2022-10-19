import 'package:blinde_v09/splashpage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription>? cameras;
void main() async {
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BLINDE",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
