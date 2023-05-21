// ignore_for_file: deprecated_member_use, prefer_const_constructors, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:worksaga/widgets/navbar.dart';

import '../../models/signupmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

Future<void> createAlbum(
    String name, String email, String password, String mobileNo) async {
  final response = await http.post(
    Uri.parse('https://worksaga.onrender.com/api/auth/createuser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'password': password,
      'mobileNo': mobileNo
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    final parsedJson = jsonDecode(response.body);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString('auth-token', parsedJson['authtoken']);
    await sharedPreferences.setInt('isLoggedIn', 1);
// set value

  } else if (response.statusCode == 400) {
    print(response.body);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    await sharedPreferences.setInt('isLoggedIn', 0);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    await sharedPreferences.setInt('isLoggedIn', 0);
    throw Exception('Failed to create data.');
  }
}

TextEditingController _name = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();
TextEditingController _mobileNo = TextEditingController();

class _SignUpState extends State<SignUp> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
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
                          image: AssetImage('assets/images/signup.png'))),
                  width: 281,
                  height: 188,
                ),
              ],
            ),
            SizedBox(
              height: 35,
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
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Color(0xff182a42), width: 3)),
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: _name,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      border: InputBorder.none,
                      hintText: 'Full name (Name Surname)',
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Color(0xff182a42), width: 3)),
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: _mobileNo,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      border: InputBorder.none,
                      hintText: 'Mobile no',
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Color(0xff182a42), width: 3)),
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Color(0xff182a42), width: 3)),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                      suffixIcon: Container(
                        child: IconButton(
                          color: Color.fromARGB(255, 0, 0, 0),
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                    ),
                    controller: _password,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                width: 110,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff182a42),
                      onPrimary: Color.fromARGB(255, 255, 255, 255)),
                  onPressed: () async {
                    createAlbum(_name.text, _email.text, _password.text,
                        _mobileNo.text);
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
                                isLoggedIn ? Navbar() : SignUp()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20, fontFamily: 'NanumMyeongjo'),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                child: TextButton(
              child: Text(
                'Already a customer? LogIn',
                style: TextStyle(
                  color: Color(0xff182a42),
                  fontFamily: 'NanumMyeongjo',
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()))
              },
            ))
          ],
        ),
      ),
    );
  }
}
