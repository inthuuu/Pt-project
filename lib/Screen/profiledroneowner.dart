// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drone_for_smart_farming/blocs/profileDroneProvider.dart';
import 'package:drone_for_smart_farming/model/profileDroneOwnerModel.dart';
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
  final _auth = FirebaseAuth.instance;

  ProfileDroneOwnerModel profile =
      ProfileDroneOwnerModel(name: "", phone: "", address: "");

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProfileDroneProvider>(context);
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("profileDroneOwners")
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
            return EditProfileDroneOwner();
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
                      snapshot.data!.get("address").toString(),
                      style: TextStyle(
                          fontSize: 18,
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
                          snapshot.data!.get("name").toString(),
                          snapshot.data!.get("phone").toString(),
                          snapshot.data!.get("address").toString());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileDroneOwner()));
                    },
                  ),
                ),
              ]));
        });
  }
}
