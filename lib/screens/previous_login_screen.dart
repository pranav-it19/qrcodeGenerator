import 'package:flutter/material.dart';
import 'package:qr_code_generator/widgets/backbutton_widget.dart';
import 'package:qr_code_generator/widgets/logout_widget.dart';
import 'package:qr_code_generator/widgets/previous_log_widget.dart';
import 'package:qr_code_generator/widgets/title_widget.dart';

class PreviousLogin extends StatefulWidget {
  static const routePreviousLog = '/previouslog';
  const PreviousLogin({Key? key}) : super(key: key);

  @override
  State<PreviousLogin> createState() => _PreviousLoginState();
}

class _PreviousLoginState extends State<PreviousLogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(54, 31, 201, 100),
        body: Stack(
          children: [
            PreviousLogs(),
            LogoutWidget(),
            BackButtonWidget(),
            PageTitle(title: 'Last Login')
          ],
        ),
      ),
    );
  }
}
