import 'package:drone_for_smart_farming/drawPolygon.dart';
import 'package:drone_for_smart_farming/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:drone_for_smart_farming/map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'model/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final currentState = TextEditingController();

  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _auth.signOut();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PolygonScreen()));
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
        // future: firebase,
        // builder: (context, snapshot) {
        //   if (snapshot.hasError) {
        //     return Scaffold(
        //       appBar: AppBar(
        //         title: Text("Error"),
        //       ),
        //       body: Center(
        //         child: Text("${snapshot.error}"),
        //       ),
        //     );
        //   }
        //   if (snapshot.connectionState == ConnectionState.done) {
        //     return Scaffold(
        //       backgroundColor: Colors.blue[200],
        //       body: SingleChildScrollView(
        //         child: Column(
        //           children: [
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
        //                   child: Image.asset(
        //                     "image/farming.png",
        //                     height: 90,
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: 10,
        //                 ),
        //                 SizedBox(
        //                   child: Text(
        //                     "Login With Phone Number",
        //                     style: TextStyle(fontSize: 25, color: Colors.white),
        //                   ),
        //                 )
        //               ],
        //             ),
        //             Form(
        //               key: formKey,
        //               child: Padding(
        //                 padding: const EdgeInsets.symmetric(
        //                     horizontal: 30.0, vertical: 25.0),
        //                 child: Column(
        //                   children: [
        //                     TextFormField(
        //                       style: TextStyle(
        //                         fontSize: 16,
        //                         color: Colors.black,
        //                       ),
        //                       validator: RequiredValidator(
        //                           errorText: "This field is required!"),
        //                       onSaved: (name) {
        //                         profile.name = name!;
        //                       },
        //                       decoration: InputDecoration(
        //                         hintText: 'Telephone',
        //                         hintStyle: TextStyle(
        //                             fontSize: 16, color: Colors.grey.shade500),
        //                         fillColor: Colors.white,
        //                         filled: true,
        //                         border: OutlineInputBorder(
        //                             borderRadius:
        //                                 BorderRadius.all(Radius.circular(10))),
        //                       ),
        //                     ),
        //                     SizedBox(height: 15),
        //                     SizedBox(
        //                       height: 55,
        //                       width: double.infinity,
        //                       child: ElevatedButton(
        //                         style: ElevatedButton.styleFrom(
        //                             primary: Colors.green,
        //                             onPrimary: Colors.white,
        //                             shape: RoundedRectangleBorder(
        //                                 borderRadius: BorderRadius.all(
        //                                     Radius.circular(10)))),
        //                         child: Text("Verify",
        //                             style: TextStyle(fontSize: 18)),
        //                         onPressed: () async {
        //                           if (formKey.currentState!.validate()) {
        //                             formKey.currentState!.save();

        //                             try {
        //                               await FirebaseAuth.instance
        //                                   .createUserWithEmailAndPassword(
        //                                       email: profile.email,
        //                                       password: profile.password)
        //                                   .then((value) => {
        //                                         FirebaseFirestore.instance
        //                                             .collection("profile" +
        //                                                 value.user!.uid)
        //                                             .doc(value.user!.uid)
        //                                             .set({
        //                                           "name": profile.name,
        //                                           "lname": profile.lname,
        //                                           "email": profile.email,
        //                                           "password": profile.password,
        //                                         })
        //                                       });
        //                               Fluttertoast.showToast(
        //                                   msg: "Created an account already!",
        //                                   gravity: ToastGravity.TOP);
        //                               formKey.currentState!.reset();
        //                               Navigator.pushReplacement(context,
        //                                   MaterialPageRoute(builder: (context) {
        //                                 return MapsPage();
        //                               }));
        //                             } on FirebaseAuthException catch (e) {
        //                               String message;
        //                               if (e.code == 'email-already-in-use') {
        //                                 message =
        //                                     "This email is already in use! Change to another email.";
        //                               } else if (e.code == 'weak-password') {
        //                                 message =
        //                                     "The password needs to be longer than 6 or equal.";
        //                               } else {
        //                                 message = e.message!;
        //                               }
        //                               Fluttertoast.showToast(
        //                                   msg: e.message!,
        //                                   gravity: ToastGravity.TOP);
        //                             }
        //                           }
        //                         },
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   }
        //   return Scaffold(
        //     backgroundColor: Colors.black,
        //     body: Center(child: CircularProgressIndicator()),
        //   );
        // });


// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Image.asset("image/farming.png"),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton.icon(
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return RegisterScreen();
//                         }));
//                       },
//                       icon: Icon(Icons.add),
//                       label: Text("Register", style: TextStyle(fontSize: 20))),
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton.icon(
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return LoginScreen();
//                         }));
//                       },
//                       icon: Icon(Icons.login),
//                       label: Text("Login", style: TextStyle(fontSize: 20))),
//                 )
//               ],
//             ),
//           )),
//     );
//   }
// }
