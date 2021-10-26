import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController smsController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _message = '';
  late String _verificationId;
  get verificationId => _verificationId;
  late String _verifycode;
  String get verifycode => _verifycode;
  CountryCode _countrycode = CountryCode.fromCountryCode('ja');
  get countrycode => _countrycode.dialCode;

  setVerifyCode(pin) {
    _verifycode = pin;
  }

  verifyPhoneNumber(context) async {
    _message = '';
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      _message = 'Received phone auth credential: $phoneAuthCredential';
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      _message =
      'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: countrycode + phoneNumberController.text,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    Navigator.pushNamed(context, "/verify");
  }

  signInWithPhoneNumber(context) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: verifycode,
    );
    try {
      final User? user =
          (await _auth.signInWithCredential(credential)).user;
      print(user);
      final User currentUser = await _auth.currentUser!;
      assert(user!.uid == currentUser.uid);
      if (user != null) {
        _message = 'Successfully signed in, uid: ' + user.uid;
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      } else {
        _message = 'Sign in failed';
      }
    } catch (e) {
      print("debug error");
      print(e);
    }
  }
}