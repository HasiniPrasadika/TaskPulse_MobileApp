import 'package:flutter/material.dart';
import 'package:TaskPulse/screen/login_screen.dart';
import 'package:TaskPulse/screen/signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool a = true;
  void to() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      return LoginPage(to);
    } else {
      return SignupPage(to);
    }
  }
}
