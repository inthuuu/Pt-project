// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:drone_for_smart_farming/Widget/bottomNavDroneOwner.dart';
import 'Widget/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:drone_for_smart_farming/Screen/login.dart';
import 'package:drone_for_smart_farming/Screen/whichone.dart';
import 'package:drone_for_smart_farming/blocs/application_bloc.dart';
import 'package:drone_for_smart_farming/service/service_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Applicationbloc()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (context) => ManageService()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarProvider2())
      ],
      child: MaterialApp(
          title: "My App",
          theme: ThemeData(
              primaryColor: const Color(0xff2f574b),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Poppins'),
          debugShowCheckedModeBanner: false,
          home: whichone()),
    );
  }
}

class InitializerWidget extends StatefulWidget {
  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  late FirebaseAuth _auth;

  User? _user;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavigationBarProvider(),
      child: isLoading
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : _user == null
              ? LoginScreen()
              : whichone(),
    );
  }
}
