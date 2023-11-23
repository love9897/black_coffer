import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpProvider with ChangeNotifier {
  dynamic _verificationId;

  final _auth = FirebaseAuth.instance;

  Future<void> verifyPhone(String phonenumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phonenumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval of the verification code
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        // Save the verification ID and resend token to use later
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timed out
        _verificationId = verificationId;
      },
      timeout: const Duration(seconds: 60),
    );
    notifyListeners();
  }

  Future<bool> validateOTP(String otp) async {
    // Create a PhoneAuthCredential using the verification ID and the user-entered OTP.
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otp,
    );

    try {
      // Sign in the user with the PhoneAuthCredential.

      await _auth.signInWithCredential(credential);

      // If the sign-in is successful, return true.
      return true;
    } catch (e) {
      // If the sign-in is unsuccessful, print the error message and return false.
      // print(e.toString());
      return false;
    }
  }
}
