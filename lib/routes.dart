import 'package:flutter/material.dart';
import 'package:qr_code_generator/check_user.dart';
import 'package:qr_code_generator/screens/login_screen.dart';
import 'package:qr_code_generator/screens/plugin_screen.dart';
import 'package:qr_code_generator/screens/previous_login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  Check.routePlugin: (context) => Check(),
  LoginScreen.routeLogin: (context) => const LoginScreen(),
  PluginScreen.routePlugin: (context) => PluginScreen(
        data: '',
        phoneNum: '',
        location: '',
        firebase: false,
      ),
  PreviousLogin.routePreviousLog: (context) => const PreviousLogin(),
};
