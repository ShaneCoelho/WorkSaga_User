import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worksaga/widgets/navbar.dart';

import '../../widgets/navbar.dart';

import 'package:http/http.dart' as http;
import '../../models/signupmodel.dart';
import 'signuppage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

Future<void> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('https://worksaga.herokuapp.com/api/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final parsedJson = jsonDecode(response.body);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString('auth-token', parsedJson['authtoken']);
    await sharedPreferences.setInt('isLoggedIn', 1);
  } else if (response.statusCode == 400) {
    print(response.body);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setInt('isLoggedIn', 0);
  } else {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    await sharedPreferences.setInt('isLoggedIn', 0);
    throw Exception('Failed to create data.');
  }
}

TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                      'assets/images/login.png',
                    ))),
                    width: 278,
                    height: 275,
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  child: Text(
                    "WORK SAGA",
                    style: TextStyle(
                      fontFamily: 'NanumMyeongjo',
                      color: Colors.black,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Color(0xff182a42), width: 3)),
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      border: InputBorder.none,
                      hintText: 'Phone no. / Email',
                      hintStyle: TextStyle(
                        fontFamily: 'NanumMyeongjo',
                        fontSize: 20,
                        color: Color(0xc925212c),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Color(0xff182a42), width: 3)),
                  child: TextField(
                    controller: _password,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontFamily: 'NanumMyeongjo',
                        fontSize: 20,
                        color: Color(0xc925212c),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                  width: 100,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff182a42),
                        onPrimary: Color.fromARGB(255, 255, 255, 255)),
                    onPressed: () async {
                      login(_email.text, _password.text);
                      final prefs = await SharedPreferences.getInstance();
                      var isLoggedIn = false;
                      if ((prefs.getInt('isLoggedIn') == 1)) {
                        isLoggedIn = true;
                      }
                      print(isLoggedIn);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  isLoggedIn ? Navbar() : LoginPage()));
                    },
                    child: Text(
                      'Log In',
                      style:
                          TextStyle(fontSize: 20, fontFamily: 'NanumMyeongjo'),
                    ),
                  )),
              SizedBox(
                height: 35,
              ),
              Container(
                  child: TextButton(
                child: Text(
                  'New to Work Saga? SignUp',
                  style: TextStyle(
                    color: Color(0xff182a42),
                    fontFamily: 'NanumMyeongjo',
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()))
                },
              ))
            ],
          ),
        ),
      );
    });
  }
}
