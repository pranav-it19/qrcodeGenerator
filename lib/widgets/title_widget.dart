import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator/styles/styles.dart';

class PageTitle extends StatelessWidget {
  String title;
  PageTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Get.context!.height * 0.09,
      left: Get.context!.width * 0.33,
      child: Container(
        height: Get.context!.height * 0.06,
        width: Get.context!.width * 0.35,
        decoration: titledecoration,
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
