import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_generator/screens/plugin_screen.dart';
import 'package:qr_code_generator/widgets/login_form_widget.dart';
// ignore: deprecated_member_use

class AuthMethod {
  String verifyId = '';
  Future<bool> loginWithPhone(
      String phone, BuildContext context, bool isvisible) async {
    try {
      if (phone.isNotEmpty) {
        await firebaseAuth.verifyPhoneNumber(
          phoneNumber: '+91' + phone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await firebaseAuth.signInWithCredential(credential);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Success')));
          },
          verificationFailed: (FirebaseAuthException e) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          },
          codeSent: (String verificationId, int? resendToken) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Successful')));
            Scaffold.of(context).setState(() {
              isvisible = true;
              verifyId = verificationId;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
    } catch (e) {
      print(e);
    }
    return Future.value(false);
  }

  void verifyOTP(String otp, BuildContext context) async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
    try {
      await firebaseAuth.signInWithCredential(credential);
      FocusManager.instance.primaryFocus?.unfocus();
    } on FirebaseAuthException catch (e) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('OTP not correct')));
    }
    Navigator.of(context).pushNamed(PluginScreen.routePlugin);
  }
}
