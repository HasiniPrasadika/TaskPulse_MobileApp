import 'dart:async';

import 'package:TaskPulse/auth/main_page.dart';
import 'package:TaskPulse/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Main_Page()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.png',
              width: size.width * 0.3,
              height: size.width * 0.3,
            ),
            Text(
              "TaskPulse",
              style: TextStyle(
                fontSize: size.width * 0.12,
                fontWeight: FontWeight.bold,
                color: custom_purple,
              ),
            ),
            JumpingText('...',
                style: TextStyle(
                    color: custom_purple, fontSize: size.width * 0.2)),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
