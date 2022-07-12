// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drone_for_smart_farming/blocs/profileProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '../Widget/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drone_for_smart_farming/Screen/login.dart';
import 'package:drone_for_smart_farming/Screen/editProfileFarmer.dart';

import '../model/profile.dart';

class ProfileFarmer extends StatefulWidget {
  const ProfileFarmer({Key? key}) : super(key: key);

  @override
  State<ProfileFarmer> createState() => _ProfileFarmerState();
}

class _ProfileFarmerState extends State<ProfileFarmer> {
  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final _auth = FirebaseAuth.instance;

  Profile profile = Profile(name: "", phone: "", address: "", area: "");

  bool isExits = true;

  bool checkExits(String docID) {
    FirebaseFirestore.instance
        .collection("ProfileFarmer " + _auth.currentUser!.uid)
        .doc(docID)
        .get()
        .then((value) => {
              if (value.exists) {isExits = true} else {isExits = false}
            });
    return isExits;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProfileProvider>(context);
    checkExits(_auth.currentUser!.uid);
    print(isExits);
    return (checkExits(_auth.currentUser!.uid))
        ? EditProfileFarmer()
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("profileFarmer " + _auth.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Scaffold(
                  backgroundColor: Color(0xFF9FE2BF),
                  appBar: AppBar(
                    backgroundColor: Color(0xFF9FE2BF),
                    elevation: 0,
                    title: Row(children: [
                      Container(
                        alignment: Alignment.topLeft,
                        height: 40,
                        width: 40,
                        child: FloatingActionButton(
                          heroTag: 1,
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavigation()));
                          },
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "บัญชีผู้ใช้",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          child: Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            await _auth.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                        ),
                      )
                    ]),
                  ),
                  body: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "ชื่อ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          snapshot.data!.docs[0]["name"].toString(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "เบอร์โทร",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          snapshot.data!.docs[0]["phone"].toString(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "ที่อยู่",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          snapshot.data!.docs[0]["address"].toString(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "พื้นที่",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 180,
                    ),
                    SizedBox(
                      height: 55,
                      width: 350,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        child: Text("แก้ไข",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          provider.getProfile(
                              snapshot.data!.docs[0]["name"].toString(),
                              snapshot.data!.docs[0]["phone"].toString(),
                              snapshot.data!.docs[0]["address"].toString(),
                              snapshot.data!.docs[0]["area"].toString());
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileFarmer()));
                        },
                      ),
                    ),
                  ]));
            });
  }
}
