// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:practice/App/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashScreen = SplashService();

  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "My App",
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
