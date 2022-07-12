// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/profileProvider.dart';
import '../model/profile.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'profilefarmer.dart';

class EditProfileFarmer extends StatefulWidget {
  const EditProfileFarmer({Key? key}) : super(key: key);

  @override
  State<EditProfileFarmer> createState() => _EditProfileFarmerState();
}

class _EditProfileFarmerState extends State<EditProfileFarmer> {
  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final _auth = FirebaseAuth.instance;

  Profile profile = Profile(name: "", phone: "", address: "", area: "");
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProfileProvider>(context);
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
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
                                builder: (context) => ProfileFarmer()));
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 25.0),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 0, 10),
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
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        validator: RequiredValidator(errorText: "โปรดระบุชื่อ"),
                        onSaved: (name) {
                          profile.name = name;
                        },
                        initialValue: provider.name,
                        decoration: InputDecoration(
                          hintText: 'ชื่อ',
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
                        padding: const EdgeInsets.fromLTRB(30, 30, 0, 10),
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
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        validator:
                            RequiredValidator(errorText: "โปรดระบุเบอร์"),
                        onSaved: (phone) {
                          profile.phone = phone;
                        },
                        initialValue: provider.phone,
                        decoration: InputDecoration(
                          hintText: 'เบอร์',
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
                        padding: const EdgeInsets.fromLTRB(30, 30, 0, 10),
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
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        validator:
                            RequiredValidator(errorText: "โปรดระบุที่อยู่"),
                        onSaved: (address) {
                          profile.address = address;
                        },
                        initialValue: provider.address,
                        decoration: InputDecoration(
                          hintText: 'ที่อยู่',
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
                        padding: const EdgeInsets.fromLTRB(30, 30, 0, 10),
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
                        height: 55,
                        width: 350,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff2f574b),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          child: Text("ตกลง",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              var userRef = FirebaseFirestore.instance
                                  .collection(
                                      "profileFarmer " + _auth.currentUser!.uid)
                                  .doc(_auth.currentUser!.uid);

                              userRef.get().then((documentSnapshot) => {
                                    if (!documentSnapshot.exists)
                                      {
                                        userRef.set({
                                          "name": profile.name,
                                          "phone": profile.phone,
                                          "address": profile.address,
                                          "area": profile.area,
                                        }),
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileFarmer()))
                                      }
                                    else
                                      {
                                        userRef.update({
                                          "name": profile.name,
                                          "phone": profile.phone,
                                          "address": profile.address,
                                          "area": profile.area,
                                        }),
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileFarmer()))
                                      }
                                  });

                              // Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
