// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

final textFieldDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    fillColor: Color.fromRGBO(54, 31, 201, 100),
    filled: true);
final buttonStyle = ElevatedButton.styleFrom(
    minimumSize: Size(300, 50),
    primary: Colors.grey.shade800,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)));
// ignore: prefer_const_constructors
final gradientColor = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [
      0.3,
      0.7
    ],
    colors: [
      Color.fromRGBO(80, 77, 82, 100),
      Color.fromRGBO(83, 30, 135, 100)
    ]);
final numberContainerDecoration = ShapeDecoration(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
    gradient: gradientColor);
final outlinedButtonStyle = OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    minimumSize: Size(300, 50),
    side: BorderSide(color: Colors.white));
final logcontainerstyle = ShapeDecoration(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    color: Color.fromRGBO(69, 67, 82, 100));
final logoutdecoration = BoxDecoration(
    color: Color.fromRGBO(108, 87, 247, 100), shape: BoxShape.circle);
final titledecoration = ShapeDecoration(
    color: Colors.blue[400],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
