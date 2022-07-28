import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/screens/login_screen.dart';
import 'package:qr_code_generator/styles/styles.dart';

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({Key? key}) : super(key: key);

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseauth = FirebaseAuth.instance;
    return Positioned(
        top: -35,
        right: 0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          height: 100,
          width: 100,
          decoration: logoutdecoration,
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: TextButton(
              onPressed: () async {
                await firebaseauth.signOut();
                Navigator.pushNamed(context, LoginScreen.routeLogin);
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ));
  }
}
