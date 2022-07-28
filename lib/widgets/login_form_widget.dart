// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_generator/api/date_format.dart';
import 'package:qr_code_generator/authentication/firestore_functions.dart';
import 'package:qr_code_generator/check_user.dart';
import 'package:qr_code_generator/styles/styles.dart';
import 'package:qr_code_generator/widgets/styled_container_widget.dart';

class LoginForm extends StatefulWidget {
  String num;
  LoginForm(this.num);
  @override
  State<LoginForm> createState() => _LoginFormState();
}

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? user;

DateTime currentPhoneDate = DateTime.now();
// //DateTime
Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
DateTime myDateTime = myTimeStamp.toDate();
final DateFormat date = DateFormat('dd-MM-yyyy');
final DateFormat time = DateFormat('hh:mm');
final String formattedDate = date.format(myDateTime);
final String formattedtime = time.format(myDateTime);
final String currentDate =
    DateFormatter().getVerboseDateTimeRepresentation(myDateTime);
String location = '';
String Address = ' ';
Future<Position> _getGeoLocationPosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

Future<void> GetAddressFromLatLong(Position position) async {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  //print(placemarks);
  Placemark place = placemarks[0];
  Address = place.locality.toString();
}

void check() async {
  Position position = await _getGeoLocationPosition();
  GetAddressFromLatLong(position);
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController phonetext = TextEditingController();
  TextEditingController otptext = TextEditingController();
  String verifyId = ' ';
  bool isvisible = false;
  String? _currentAddress;
  Position? _currentPosition;

  void initState() {
    super.initState();
    check();
  }

  Future<String> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    Address = '${place.locality}';
    //print(placemarks[0]);
    return Future.value(place.locality);
  }

  @override
  Widget build(BuildContext context) {
    //print("Loc" + test.toString());
    return Positioned(
      bottom: 0,
      child: StyledContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  'Phone Number',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: phonetext,
                  keyboardType: TextInputType.phone,
                  decoration: textFieldDecoration,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              isvisible == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Text(
                            'OTP',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                              controller: otptext,
                              keyboardType: TextInputType.number,
                              decoration: textFieldDecoration),
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 70,
              ),
              Center(
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () async {
                    if (isvisible == false) {
                      loginWithPhone();
                      print(phonetext.text);
                    } else {
                      //print('object');
                      verifyOTP();
                    }
                    // verifyOTP();
                  },
                  child: Text(
                    isvisible ? 'LOGIN' : 'Verify',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> loginWithPhone() async {
    firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+91${phonetext.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
// ignore: deprecated_member_use
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Successful')));
        setState(() {
          isvisible = true;
          verifyId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return phonetext.text;
  }

  void verifyOTP() async {
    final ipv4 = await Ipify.ipv4();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyId, smsCode: otptext.text);

    await firebaseAuth.signInWithCredential(credential).then((value) {
      setState(() {
        user = FirebaseAuth.instance.currentUser;
      });
    }).whenComplete(() {
      print(Address);
      print(myDateTime);
      FirestoreFun().adddetails(
          uid: FirebaseAuth.instance.currentUser!.uid.toString(),
          ip: ipv4.toString(),
          loc: Address,
          date: currentDate,
          datetime: myDateTime);
      if (user != null) {
        print(phonetext.text);
        print(widget.num);
        Navigator.pushNamed(context, Check.routePlugin);
      }
    });
  }
}
