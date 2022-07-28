import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator/styles/styles.dart';
import 'package:qr_code_generator/widgets/qr_image_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LogContainer extends StatefulWidget {
  String time;
  String ipaddress;
  String location;
  LogContainer(
      {required this.time, required this.ipaddress, required this.location});
  @override
  State<LogContainer> createState() => _LogContainerState();
}

class _LogContainerState extends State<LogContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: Get.context!.height * 0.12,
        width: Get.context!.width,
        decoration: logcontainerstyle,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.ipaddress,
                    style:
                        TextStyle(color: Color.fromRGBO(255, 255, 255, 100))),
                Text(widget.location,
                    style:
                        TextStyle(color: Color.fromRGBO(255, 255, 255, 100))),
                Text(
                  widget.time,
                  style: TextStyle(color: Color.fromRGBO(255, 255, 255, 100)),
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: Container(
                height: 100,
                width: 50,
                child: QrImage(
                  size: 100,
                  data: widget.ipaddress,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
