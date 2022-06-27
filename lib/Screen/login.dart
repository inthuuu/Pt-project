import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:drone_for_smart_farming/Screen/whichone.dart';

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
            context, MaterialPageRoute(builder: (context) => whichone()));
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
    return Scaffold(
      backgroundColor: Color(0xFF9FE2BF),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Spacer(),
            Container(
              child: Text("Drone For Smart Farming",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 80,
            ),
            Icon(
              Icons.account_circle,
              size: 150,
            ),
            SizedBox(
              height: 80,
            ),
            SizedBox(
                child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Phone Number"),
            )),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 55,
              width: 350,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF30574B),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                child: Text("ถัดไป", style: TextStyle(fontSize: 18)),
                onPressed: () async {
                  setState(() {
                    showLoading = true;
                  });
                  await _auth.verifyPhoneNumber(
                    phoneNumber: "+66" + phoneController.text,
                    verificationCompleted: (PhoneAuthCredential) async {
                      setState(() {
                        showLoading = false;
                      });
                      signInWithPhoneAuthCreential(PhoneAuthCredential);
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
                        currentState =
                            MobileVerificationState.SHOW_OTP_FROM_STATE;
                        this.verificationId = verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (verificationId) async {},
                  );
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  getOtpFromWidget(context) {
    return Scaffold(
      backgroundColor: Color(0xFF9FE2BF),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Spacer(),
            SizedBox(
                child: TextField(
              controller: otpController,
              decoration: InputDecoration(
                  filled: true, fillColor: Colors.white, labelText: "OTP"),
            )),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 55,
              width: 350,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF30574B),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                child: Text("ถัดไป", style: TextStyle(fontSize: 18)),
                onPressed: () async {
                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: otpController.text);
                  signInWithPhoneAuthCreential(phoneAuthCredential);
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
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
      ),
    );
  }
}
