import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/widgets/login_form_widget.dart';
import 'package:qr_code_generator/widgets/title_widget.dart';

class LoginScreen extends StatefulWidget {
  static const routeLogin = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    int random(min, max) {
      return min + Random().nextInt(max - min);
    }

    String number = random.toString();
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(54, 31, 201, 100),
        body: Stack(
          children: [
            LoginForm(number),
            PageTitle(
              title: 'Login',
            )
          ],
        ),
      ),
    );
  }
}
