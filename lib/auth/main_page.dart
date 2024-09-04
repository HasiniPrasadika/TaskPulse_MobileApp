import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:TaskPulse/auth/auth_page.dart';
import 'package:TaskPulse/screen/main_home_page.dart';

class Main_Page extends StatelessWidget {
  const Main_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainHomePage();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
