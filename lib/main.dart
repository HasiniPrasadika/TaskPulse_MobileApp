import 'package:TaskPulse/const/colors.dart';
import 'package:TaskPulse/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
        cursorColor: custom_purple,
        selectionHandleColor: custom_purple,
        selectionColor: custom_purple.withOpacity(0.2),
      )),
    );
  }
}
