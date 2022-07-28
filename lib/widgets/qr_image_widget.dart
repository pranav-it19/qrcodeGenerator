import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImage extends StatefulWidget {
  String qrData;
  QRImage({required this.qrData});
  @override
  State<QRImage> createState() => _QRImageState();
}

class _QRImageState extends State<QRImage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print("QR Data " + widget.qrData);
    return Positioned(
        top: height * 0.2,
        left: width * 0.37,
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 0.1),
            ),
            color: Colors.green,
          ),
          child: QrImage(
            size: 100,
            data: widget.qrData.toString(),
            backgroundColor: Colors.white,
          ),
        ));
  }
}
