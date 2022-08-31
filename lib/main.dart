import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_confirmpassword/screens/screen.dart';
import 'package:firebase_confirmpassword/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  File? user;
  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null ? MySplashScreen(userId: '$user') : MyFirstScreen(),
    );
  }
}
