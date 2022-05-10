import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worksaga/screens/home_screen/home.dart';

import '../booking/finishbooking.dart';

class BookFreelancer extends StatefulWidget {
  @override
  final String name;
  final String charge;
  final String profile;
  final String freelancerId;

  const BookFreelancer(
      {Key? key,
      required this.profile,
      required this.name,
      required this.charge,
      required this.freelancerId})
      : super(key: key);

  _BookFreelancerState createState() => _BookFreelancerState();
}

class _BookFreelancerState extends State<BookFreelancer> {
  @override
  void initState() {
    super.initState();
  }

  late bool success = false;

  Future<void> FinalBooking(String email, String mobileno, String address,
      String jobdescription) async {
    final pref = await SharedPreferences.getInstance();
    final Authtoken = pref.getString("auth-token");
    final String cc =
        "https://worksaga.herokuapp.com/api/user/bookfreelancer/" +
            widget.freelancerId;
    final response = await http.post(
      Uri.parse(cc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': Authtoken.toString(),
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'mobileNo': mobileno,
        'address': address,
        'jobdescription': jobdescription,
      }),
    );

    if (response.statusCode == 200) {
      print("Success");
      success = true;
    } else if (response.statusCode == 400) {
      print("Failed");
      success = false;
    } else {
      success = false;
      throw Exception('Failed to create data.');
    }
  }

  TextEditingController _email = TextEditingController();
  TextEditingController _mobileno = TextEditingController();
  TextEditingController _jobdescription = TextEditingController();
  TextEditingController _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E5),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 171,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color(0x1D000000),
                            offset: Offset(0, 4),
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 25, 0, 20),
                            child: Container(
                              width: 120,
                              height: 120,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                widget.profile,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 58, 0, 10),
                                child: Text(
                                  widget.name,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                                child: Text(
                                  'Charges: \$ ' + widget.charge,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF111111),
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 320,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x1B000000),
                          offset: Offset(0, 4),
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(31, 10, 0, 0),
                          child: Text(
                            'Enter Your Details',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 17, 10, 0),
                                child: TextFormField(
                                  controller: _address,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    hintText: '\n',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 10),
                                    prefixIcon: Icon(
                                      Icons.home_rounded,
                                      color: Color(0xFF111111),
                                      size: 30,
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 3,
                                  keyboardType: TextInputType.streetAddress,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 0),
                                child: TextFormField(
                                  controller: _email,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.mail_outlined,
                                      color: Color(0xFF111111),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                  maxLines: 2,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 0),
                                child: TextFormField(
                                  controller: _mobileno,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Phone No.',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0)),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Color(0xFF111111),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                  maxLines: 2,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color(0x1C000000),
                            offset: Offset(0, 4),
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(31, 10, 0, 0),
                            child: Text(
                              'Job Description',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 0),
                                  child: TextFormField(
                                    controller: _jobdescription,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        )),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                    maxLines: 6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 11, 39, 53)),
                            elevation: MaterialStateProperty.all(0)),
                        onPressed: () async {
                          FinalBooking(_email.text, _mobileno.text,
                              _address.text, _jobdescription.text);
                          if (success == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FinishBooking()));
                          }
                        },
                        child: Text('Book Freelancer')),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
