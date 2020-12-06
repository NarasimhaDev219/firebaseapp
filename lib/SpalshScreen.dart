import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.network(
              "https://lh3.googleusercontent.com/proxy/mVhP20iIPOoWZmCEHEcFb4hRHxD20etSdNTjwfyWiuJJ0h187C9Cul4g8G_J9o5kYwgHLed5F3rJkyq_MfpjwwmTDCDBATzICbYSJwEydJA")),
    );
  }
}
