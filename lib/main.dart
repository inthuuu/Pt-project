import 'package:drone_for_smart_farming/Screen/homescreenframer.dart';
import 'package:drone_for_smart_farming/Screen/profilefarmer.dart';
import 'package:drone_for_smart_farming/Screen/whichone.dart';
import 'package:drone_for_smart_farming/blocs/application_bloc.dart';
import 'package:drone_for_smart_farming/Screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Widget/bottomNav.dart';

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
            create: (context) => BottomNavigationBarProvider())
      ],
      child: MaterialApp(
          title: "My App",
          theme: ThemeData(
              primarySwatch: Colors.blue,
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
