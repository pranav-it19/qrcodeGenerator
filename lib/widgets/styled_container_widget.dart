import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StyledContainer extends StatelessWidget {
  Widget child;
  StyledContainer({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: Get.context!.height * 0.80,
      width: Get.context!.width,
      child: child,
    );
  }
}
