import 'package:flutter/material.dart';
import 'package:qr_code_generator/widgets/generatednumber_widget.dart';
import 'package:qr_code_generator/widgets/logout_widget.dart';
import 'package:qr_code_generator/widgets/qr_image_widget.dart';
import 'package:qr_code_generator/widgets/title_widget.dart';

class PluginScreen extends StatefulWidget {
  String data;
  String phoneNum;
  String location;
  bool firebase;
  PluginScreen({
    required this.data,
    required this.phoneNum,
    required this.location,
    required this.firebase,
  });

  static const routePlugin = '/plugin';
  @override
  State<PluginScreen> createState() => _PluginScreenState();
}

class _PluginScreenState extends State<PluginScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.firebase) {
      final arg = ModalRoute.of(context)!.settings.arguments as Map;
      print('data' + arg['data'].toString());
    }
    // print('phone' + widget.phoneNum);
    // print("loc :" + widget.location);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(54, 31, 201, 100),
        body: Stack(
          children: [
            GeneratedNumber(
              generatedNumber: widget.data,
            ),
            QRImage(
              qrData: widget.data,
            ),
            LogoutWidget(),
            PageTitle(title: 'Plugin'),
          ],
        ),
      ),
    );
  }
}
