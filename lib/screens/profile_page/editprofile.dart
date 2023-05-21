import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/usermodel.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phoneno = TextEditingController();

  Future<void> EditProfile(String email, String mobileno, String name) async {
    final pref = await SharedPreferences.getInstance();
    final Authtoken = pref.getString("auth-token");
    final String cc = "https://worksaga.onrender.com/api/user/editdetails";
    final response = await http.post(
      Uri.parse(cc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': Authtoken.toString(),
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'mobileNo': mobileno,
        'name': name,
      }),
    );

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Container(
          child: Form(
            child: Column(
              children: [
                TextField(
                  controller: _name,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _phoneno,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone no.',
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueGrey),
                          elevation: MaterialStateProperty.all(0)),
                      onPressed: () {},
                      child: Text('Submit')),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
