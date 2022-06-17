import 'package:drone_for_smart_farming/HomeScreen.dart';
import 'package:drone_for_smart_farming/map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'model/profile.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FROM_STATE,
  SHOW_OTP_FROM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FROM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCreential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final AuthCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });

      if (AuthCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("e.message")));
    }
  }

  getMobileFromWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(hintText: "Phone Number"),
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(
            onPressed: () async {
              setState(() {
                showLoading = true;
              });

              await _auth.verifyPhoneNumber(
                phoneNumber: phoneController.text,
                verificationCompleted: (PhoneAuthCredential) async {
                  setState(() {
                    showLoading = false;
                  });
                  //signInWithPhoneAuthCreential(phoneAuthCredential);
                },
                verificationFailed: (PhoneVerificationFailed) async {
                  setState(() {
                    showLoading = false;
                  });
                  //var verificationFailed; //????????
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${PhoneVerificationFailed.message}")));
                },
                codeSent: (verificationId, resendingToken) async {
                  setState(() {
                    showLoading = false;
                    currentState = MobileVerificationState.SHOW_OTP_FROM_STATE;
                    this.verificationId = verificationId;
                  });
                },
                codeAutoRetrievalTimeout: (verificationId) async {},
              );
            },
            child: Text(
              "SEND",
              style: TextStyle(color: Colors.blue),
            )
            // color: Colors.blue,
            // textColor: Colors.white,
            ),
        Spacer(),
      ],
    );
  }

  getOtpFromWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          decoration: InputDecoration(hintText: "OTP"),
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(
            onPressed: () async {
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: otpController.text);

              signInWithPhoneAuthCreential(phoneAuthCredential);
            },
            child: Text(
              "Enter OTP",
              style: TextStyle(color: Colors.black),
            )
            // color: Colors.blue,
            // textColor: Colors.white,
            ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FROM_STATE
                  ? getMobileFromWidget(context)
                  : getOtpFromWidget(context),
          padding: const EdgeInsets.all(16)),
    );
  }
}
