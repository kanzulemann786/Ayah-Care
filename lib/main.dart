import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Screens
import 'package:ayahcare_app/home_screen.dart';
import 'package:ayahcare_app/login.dart';
import 'package:ayahcare_app/register.dart';


import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // Check if user is already logged in
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(initialRoute: user != null ? 'home' : 'login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute, // Auto redirects based on login state
      routes: {
        'login': (context) => MyLogin(),
        'register': (context) => MyRegister(),
        'home': (context) => HomeScreen(),
      },
    );
  }
}
