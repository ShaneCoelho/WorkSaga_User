import 'package:flutter/material.dart';
import 'package:worksaga/screens/home_screen/home.dart';
import 'package:worksaga/widgets/navbar.dart';
import 'screens/startup_screen/LoginPage.dart';
import 'screens/startup_screen/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Work Saga',
      home: LoginPage(),
    );
  }
}
