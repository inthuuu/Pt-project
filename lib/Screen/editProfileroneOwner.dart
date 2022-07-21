// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drone_for_smart_farming/Widget/bottomNavDroneOwner.dart';
import 'package:drone_for_smart_farming/blocs/profileDroneProvider.dart';
import 'package:provider/provider.dart';
import 'package:drone_for_smart_farming/model/profileDroneOwnerModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:drone_for_smart_farming/Screen/profileDroneOwner.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EditProfileDroneOwner extends StatefulWidget {
  const EditProfileDroneOwner({Key? key}) : super(key: key);

  @override
  State<EditProfileDroneOwner> createState() => _EditProfileDroneOwnerState();
}

class _EditProfileDroneOwnerState extends State<EditProfileDroneOwner> {
  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final _auth = FirebaseAuth.instance;

  ProfileDroneOwnerModel myProfileDroneOwnerModel =
      ProfileDroneOwnerModel(name: "", phone: "", address: "");

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProfileDroneProvider>(context);
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
                        builder: (context) => BottomNavigationDroneOwner()));
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
        ]),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
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
              TextFormField(
                validator: MultiValidator([
                  RequiredValidator(errorText: "กรุณากรอกชื่อ"),
                ]),
                onSaved: (String? name) {
                  myProfileDroneOwnerModel.name = name!;
                },
                initialValue: provider.name,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'กรุณากรอกชื่อ',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                      color: Colors.white,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 10),
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
              TextFormField(
                validator: MultiValidator([
                  RequiredValidator(errorText: "กรุณากรอกเบอร์"),
                ]),
                onSaved: (String? phone) {
                  myProfileDroneOwnerModel.phone = phone!;
                },
                initialValue: provider.phone,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'กรุณากรอกเบอร์',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                      color: Colors.white,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 10),
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
              TextFormField(
                validator: MultiValidator([
                  RequiredValidator(errorText: "กรุณากรอกที่อยู่"),
                ]),
                onSaved: (String? address) {
                  myProfileDroneOwnerModel.address = address!;
                },
                initialValue: provider.address,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'กรุณากรอกที่อยู่',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                      color: Colors.white,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
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
                      primary: Color(0xff2f574b),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: Text("ตกลง",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      var userRef = FirebaseFirestore.instance
                          .collection("profileDroneOwners")
                          .doc(_auth.currentUser!.uid);

                      userRef.get().then((documentSnapshot) => {
                            if (!documentSnapshot.exists)
                              {
                                userRef.set({
                                  "name": myProfileDroneOwnerModel.name,
                                  "phone": myProfileDroneOwnerModel.phone,
                                  "address": myProfileDroneOwnerModel.address
                                }),
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileDroneOwner()))
                              }
                            else
                              {
                                userRef.update({
                                  "name": myProfileDroneOwnerModel.name,
                                  "phone": myProfileDroneOwnerModel.phone,
                                  "address": myProfileDroneOwnerModel.address
                                }),
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileDroneOwner()))
                              }
                          });

                      // Navigator.pop(context);
                    }
                  },

                  // onPressed: () async {
                  //   if (formKey.currentState!.validate()) {
                  //     formKey.currentState!.save();
                  //     if (ProfileDroneProvider().isFirstTime) {
                  //       FirebaseFirestore.instance
                  //           .collection("profileDroneOwners")
                  //           .doc(_auth.currentUser!.uid)
                  //           .set({
                  //         "name": myProfileDroneOwnerModel.name,
                  //         "phone": myProfileDroneOwnerModel.phone,
                  //         "address": myProfileDroneOwnerModel.address
                  //       });
                  //       ProfileDroneProvider().setIsFirstTime;
                  //       print(ProfileDroneProvider().isFirstTime);
                  //       Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => ProfileDroneOwner()));
                  //     } else {
                  //       DocumentReference storeReference = FirebaseFirestore
                  //           .instance
                  //           .collection("profileDroneOwners")
                  //           .doc(_auth.currentUser!.uid);
                  //       await storeReference.update({
                  //         "name": myProfileDroneOwnerModel.name,
                  //         "phone": myProfileDroneOwnerModel.phone,
                  //         "address": myProfileDroneOwnerModel.address
                  //       });
                  //       Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => ProfileDroneOwner()));
                  //     }
                  //     // Navigator.pop(context);
                  //   }
                  // },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
