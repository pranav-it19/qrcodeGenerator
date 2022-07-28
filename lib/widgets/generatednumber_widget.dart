import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_generator/authentication/firestore_functions.dart';
import 'package:qr_code_generator/screens/previous_login_screen.dart';
import 'package:qr_code_generator/styles/styles.dart';
import 'package:qr_code_generator/widgets/styled_container_widget.dart';

class GeneratedNumber extends StatefulWidget {
  String generatedNumber;
  // String location;
  GeneratedNumber({
    required this.generatedNumber,
    // required this.location
  });
  @override
  State<GeneratedNumber> createState() => _GeneratedNumberState();
}

DateTime currentPhoneDate = DateTime.now();
// //DateTime
Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
DateTime myDateTime = myTimeStamp.toDate();
final DateFormat date = DateFormat('dd-MM-yyyy');
final DateFormat time = DateFormat('hh:mm');
final String formattedDate = date.format(myDateTime);
final String formattedtime = time.format(myDateTime);
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

class _GeneratedNumberState extends State<GeneratedNumber> {
  String verifyId = ' ';
  bool isvisible = false;
  String? _currentAddress;
  Position? _currentPosition;

  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    String lastlogin = "Today, 11AM";
    // int randomNum = 123456;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print("Gen " + widget.generatedNumber);
    return Positioned(
      bottom: 0,
      child: StyledContainer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height * 0.22,
            width: width * 0.53,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.011)),
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade800,
                    Color.fromRGBO(54, 31, 201, 100),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Text(
                  'Generated Number',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  widget.generatedNumber,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                // Text(
                //   // 'location : ${widget.location.toString()}'
                //   widget.
                //   style: TextStyle(
                //     color: Colors.green,
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.15,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            OutlinedButton(
                style: outlinedButtonStyle,
                onPressed: () {
                  Navigator.pushNamed(context, PreviousLogin.routePreviousLog);
                },
                child: Text("Last Login at $lastlogin")),
            SizedBox(
              height: height * 0.03,
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () async {
                final ipv4 = await Ipify.ipv4();
                FirestoreFun().savedQR(
                  ip: ipv4.toString(),
                  address: Address,
                  time: myDateTime.toString(),
                );
                FirestoreFun().saveDetails(
                  uid: FirebaseAuth.instance.currentUser!.uid.toString(),
                  random: widget.generatedNumber,
                );
              },
              child: Text(
                'Save',
              ),
            )
          ]),
        ],
      )),
    );
  }
}
