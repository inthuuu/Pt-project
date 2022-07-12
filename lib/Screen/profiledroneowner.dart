// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drone_for_smart_farming/blocs/profileDroneProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drone_for_smart_farming/Screen/login.dart';
import 'package:drone_for_smart_farming/Screen/editProfileroneOwner.dart';
import 'package:provider/provider.dart';
import '../Widget/bottomNavDroneOwner.dart';

class ProfileDroneOwner extends StatefulWidget {
  const ProfileDroneOwner({Key? key}) : super(key: key);

  @override
  State<ProfileDroneOwner> createState() => _ProfileDroneOwnerState();
}

class _ProfileDroneOwnerState extends State<ProfileDroneOwner> {
  //final formKey = GlobalKey<FormState>();
  //final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final _auth = FirebaseAuth.instance;
  bool isExits = true;

  Future<bool> checkExits() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection("ProfileDroneOwners ");
    var doc = await users.doc(_auth.currentUser!.uid).get();
    if (!doc.exists) {
      isExits = false;
      print("{$isExits 1}");
    }
    return isExits;
  }

  @override
  Widget build(BuildContext context) {
    checkExits();
    print("{$isExits 2}");
    return (checkExits() == true)
        ? EditProfileDroneOwner()
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("profileDroneOwners")
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
                                    builder: (context) =>
                                        BottomNavigationDroneOwner()));
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
                      Text(
                        "บัญชีผู้ใช้",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 130,
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
                          child: Text(
                            "แก้ไข",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfileDroneOwner()));
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
                          //document["name"],
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
                          //document["phone"],
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
                          //document["address"],
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 250,
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
                        child: Text("ออกจากระบบ",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                      ),
                    ),
                  ]));
            });
  }
}



            // if (!snapshot.hasData) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            // snapshot.data?.docs.map((document) {
            //   return Column(children: [
            //     Padding(
            //       padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
            //       child: Container(
            //         alignment: Alignment.topLeft,
            //         child: Text(
            //           "ชื่อ",
            //           style: TextStyle(
            //               fontSize: 20,
            //               color: Colors.black,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
            //       child: Container(
            //         alignment: Alignment.topLeft,
            //         child: Text(
            //           //snapshot.data!.docs[0]["name"].toString()
            //           document["name"],
            //           style: TextStyle(
            //               fontSize: 18,
            //               color: Colors.black,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
            //       child: Container(
            //         alignment: Alignment.topLeft,
            //         child: Text(
            //           "เบอร์โทร",
            //           style: TextStyle(
            //               fontSize: 20,
            //               color: Colors.black,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
            //       child: Container(
            //         alignment: Alignment.topLeft,
            //         child: Text(
            //           //snapshot.data!.docs[0]["phone"].toString(),
            //           document["phone"],
            //           style: TextStyle(
            //               fontSize: 18,
            //               color: Colors.black,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
            //       child: Container(
            //         alignment: Alignment.topLeft,
            //         child: Text(
            //           "ที่อยู่",
            //           style: TextStyle(
            //               fontSize: 20,
            //               color: Colors.black,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
            //       child: Container(
            //         alignment: Alignment.topLeft,
            //         child: Text(
            //           //snapshot.data!.docs[0]["address"].toString(),
            //           document["address"],
            //           style: TextStyle(
            //               fontSize: 18,
            //               color: Colors.black,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       height: 250,
            //     ),
            //     SizedBox(
            //       height: 55,
            //       width: 350,
            //       child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //             primary: Colors.white,
            //             onPrimary: Colors.red,
            //             shape: RoundedRectangleBorder(
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(10)))),
            //         child: Text("ออกจากระบบ",
            //             style: TextStyle(
            //                 fontSize: 22, fontWeight: FontWeight.bold)),
            //         onPressed: () async {
            //           await _auth.signOut();
            //           Navigator.pushReplacement(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => LoginScreen()));
            //         },
            //       ),
            //     ),
            //   ]);
            // });

