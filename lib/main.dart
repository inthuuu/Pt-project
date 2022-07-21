// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, duplicate_ignore, library_private_types_in_public_api
import 'package:drone_for_smart_farming/blocs/profileDroneProvider.dart';
import 'package:drone_for_smart_farming/blocs/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drone_for_smart_farming/Screen/login.dart';
import 'package:drone_for_smart_farming/Screen/whichone.dart';
import 'package:drone_for_smart_farming/blocs/application_bloc.dart';
import 'package:drone_for_smart_farming/service/service_provider.dart';
import 'package:drone_for_smart_farming/Widget/bottomNavDroneOwner.dart';
import 'Widget/bottomNavFarmer.dart';

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
        ChangeNotifierProvider(create: (context) => ManageService()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => ProfileDroneProvider()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarFarmerProvider()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarDroneProvider()),
      ],
      child: MaterialApp(
          title: "My App",
          theme: ThemeData(
              primaryColor: const Color(0xff2f574b),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Poppins'),
          debugShowCheckedModeBanner: false,
          home: InitializerWidget()),
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
      create: (context) => BottomNavigationBarFarmerProvider(),
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
