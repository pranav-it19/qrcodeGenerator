import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/screens/login_screen.dart';
import 'package:qr_code_generator/screens/plugin_screen.dart';

class Check extends StatelessWidget {
  static const routePlugin = '/home';
  const Check({Key? key}) : super(key: key);
  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return LoginScreen();
            }

            return PluginScreen(
              data: random(1, 45).toString(),
              phoneNum: '1',
              location: '11',
              firebase: false,
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
