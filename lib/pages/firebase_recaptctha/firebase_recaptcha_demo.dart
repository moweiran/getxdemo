import 'package:flutter/material.dart';
import 'package:flutter_firebase_recaptcha/flutter_firebase_recaptcha.dart';

class FirebaseRecaptchaDemo extends StatefulWidget {
  const FirebaseRecaptchaDemo({Key? key}) : super(key: key);

  @override
  State<FirebaseRecaptchaDemo> createState() => _FirebaseRecaptchaDemoState();
}

class _FirebaseRecaptchaDemoState extends State<FirebaseRecaptchaDemo> {
  final firebaseConfig = {
    "apiKey": "AIzaSyDoz__f7sd_c4n1X2UxJ-Fs8E9kqplni14",
    "authDomain": "getxdemo-aab9b.firebaseapp.com",
    "projectId": "getxdemo-aab9b",
    "storageBucket": "getxdemo-aab9b.appspot.com",
    "messagingSenderId": "1082427102418",
    "appId": "1:1082427102418:web:b128829268cf3b96e0c90b",
    "measurementId": "G-4J1F2GSVRK"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FirebaseRecaptchaDemo')),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FirebaseRecaptchaVerifierModal(
          firebaseConfig: firebaseConfig,
          onVerify: (token) => print('token: ' + token),
          onLoad: () => print('onLoad'),
          onError: () => print('onError'),
          onFullChallenge: () => print('onFullChallenge'),
          attemptInvisibleVerification: false,
          // appVerificationDisabledForTesting: true,
        ),
      ),
    );
  }
}
