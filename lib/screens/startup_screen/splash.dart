import 'package:flutter/material.dart';
import 'LoginPage.dart';
import './splashPage.dart';
import 'LoginPage.dart';

class SplashScreen extends StatefulWidget {
  

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 2000), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>LoginPage()));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashPage(),
    );
  }
}
