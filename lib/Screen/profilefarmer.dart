// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, deprecated_member_use, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drone_for_smart_farming/blocs/profileProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drone_for_smart_farming/Screen/login.dart';
import 'package:drone_for_smart_farming/Screen/editProfileFarmer.dart';
import '../Widget/bottomNavFarmer.dart';
import '../model/profile.dart';

class ProfileFarmer extends StatefulWidget {
  const ProfileFarmer({Key? key}) : super(key: key);

  @override
  State<ProfileFarmer> createState() => _ProfileFarmerState();
}

class _ProfileFarmerState extends State<ProfileFarmer> {
  final _auth = FirebaseAuth.instance;

  Profile profile = Profile(name: "", phone: "", address: "", area: "");

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProfileProvider>(context);
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("profileFarmer")
            .doc(_auth.currentUser!.uid)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.data!.exists) {
            return EditProfileFarmer();
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
                                builder: (context) => BottomNavigationFarmer()));
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
                      "?????????????????????????????????",
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
                      "????????????",
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
                      snapshot.data!.get("name").toString(),
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
                      "????????????????????????",
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
                      snapshot.data!.get("phone").toString(),
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
                      "?????????????????????",
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
                      snapshot.data!.get("address").toString(),
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
                      "?????????????????????",
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
                    child: Text("???????????????",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      provider.getProfile(
                          snapshot.data!.get("name").toString(),
                          snapshot.data!.get("phone").toString(),
                          snapshot.data!.get("address").toString(),
                          snapshot.data!.get("area").toString());
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