import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_ip_address/get_ip_address.dart';

class FirestoreFun {
  var ip = IpAddress;

  CollectionReference login_details =
      FirebaseFirestore.instance.collection('login_details');
  CollectionReference saved_qr =
      FirebaseFirestore.instance.collection('saved_qr');
  // Future storeDetails({required String ip, required String address}) async {
  //   final docDetails =
  //       FirebaseFirestore.instance.collection('login_details').doc('user');
  //   final userData = {
  //     // 'userIP': IpaddressApi.getIpAddress().toString(),
  //     // 'address': Details().getLocation().toString()
  //   };
  // }

  Future<void> adddetails({
    String? uid,
    String? ip,
    String? loc,
    DateTime? datetime,
    String? date,
  }) {
    return login_details
        .doc(uid)
        .set({
          'uid': uid,
          'ip': ip,
          'loc': loc,
          'lastest_login': '',
          'date': date,
          'timestamp': datetime
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> saveDetails({String? uid, String? random}) {
    return login_details.doc(uid).update({
      'random_number': random.toString(),
    });
  }

  Future<void> savedQR({String? ip, String? address, String? time}) {
    return saved_qr
        .add({
          'ip': ip,
          'address': address,
          'time': time,
        })
        .then((value) => print("Saved QR"))
        .catchError((error) => print("Failed to qr: $error"));
  }
}
