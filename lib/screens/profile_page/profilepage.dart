// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:timeago/timeago.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../models/freelancerprofilemodel.dart';
import '../../models/usermodel.dart';
import '../../widgets/homepage_appbar.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // TextEditingController _name = TextEditingController();
  // TextEditingController _email = TextEditingController();
  // TextEditingController _phoneno = TextEditingController();

  // Future<void> Profilevv(String email, String mobileno, String name) async {
  //   final pref = await SharedPreferences.getInstance();
  //   final Authtoken = pref.getString("auth-token");
  //   final String cc = "https://worksaga.onrender.com/api/user/editdetails";
  //   final response = await http.post(
  //     Uri.parse(cc),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'auth-token': Authtoken.toString(),
  //     },
  //     body: jsonEncode(<String, String>{
  //       'email': email,
  //       'mobileNo': mobileno,
  //       'name': name,
  //     }),
  //   );

  PickedFile? bannerPicture;
  PickedFile? profilePicture;
  bool showSpinner = false;
  final ImagePicker picker = ImagePicker();

  Future profilePicker(ImageSource source) async {
    final pref = await SharedPreferences.getInstance();
    final Authtoken = pref.getString("auth-token");
    final profilePic = await picker.getImage(source: source);
    if (PickedFile != null) {
      profilePicture = PickedFile(profilePic!.path);
    } else {
      profilePicture = AssetImage('assets/images/try.jpg') as PickedFile?;
    }
    setState(() {
      profilePicture = profilePic! as PickedFile?;
    });

    var url = Uri.parse("https://worksaga.onrender.com/api/userprofile/avatar");

    try {
      final request = http.MultipartRequest("POST", url);
      String filename = profilePicture!.path;
      request.files.add(http.MultipartFile('file',
          File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
          filename: filename.split("/").last,
          contentType: MediaType('image', 'png')));

      request.headers.addAll({"auth-token": Authtoken.toString()});

      http.StreamedResponse response = await request.send();
      print('hello');
      if (response.statusCode == 200) {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile()));
    });
  }

  Future bannerPicker(ImageSource source) async {
    final pref = await SharedPreferences.getInstance();
    final Authtoken = pref.getString("auth-token");
    final bannerPic = await picker.getImage(source: source);
    if (PickedFile != null) {
      profilePicture = PickedFile(bannerPic!.path);
    } else {
      profilePicture = AssetImage('assets/images/try.jpg') as PickedFile?;
    }
    setState(() {
      bannerPicture = bannerPic! as PickedFile?;
    });

    var url2 =
        Uri.parse("https://worksaga.onrender.com/api/userprofile/banner");

    try {
      final request2 = http.MultipartRequest("POST", url2);
      String filename2 = bannerPicture!.path;
      request2.files.add(http.MultipartFile(
          'file',
          File(filename2).readAsBytes().asStream(),
          File(filename2).lengthSync(),
          filename: filename2.split("/").last,
          contentType: MediaType('image', 'png')));

      request2.headers.addAll({"auth-token": Authtoken.toString()});

      http.StreamedResponse response = await request2.send();
      print('hello');
      if (response.statusCode == 200) {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile()));
    });
  }

  Future<FreelancerModel> pro() async {
    final pref = await SharedPreferences.getInstance();
    final Authtoken = pref.getString("auth-token");
    late FreelancerModel docs;

    final url = Uri.parse("https://worksaga.onrender.com/api/auth/getuser");
    var response = await http.post(
      url,
      headers: <String, String>{
        'content-type': 'application/json',
        'auth-token': Authtoken.toString(),
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      docs = FreelancerModel.fromJson(data);
    } else {
      print(response.statusCode);
    }
    print(docs);
   

    return docs;
  }

  @override
  Widget build(BuildContext context) {
    // Size get; preferredSize => const Size.fromHeight(100);
    return ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
            child: Scaffold(
                // appBar: AppBarWidget();
                backgroundColor: Color(0xfffaf5ee),
                body: FutureBuilder(
                    future: pro(),
                    builder:
                        (context, AsyncSnapshot<FreelancerModel> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Lottie.network(
                                'https://assets9.lottiefiles.com/packages/lf20_kkyiobgx.json'),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('error');
                      }

                      return GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 1,
                              // decoration: BoxDecoration(
                              //   color: Color(0xFFEEEEEE),
                              // ),
                              child: SingleChildScrollView(
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.26,
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              snapshot.data!.banner,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              fit: BoxFit.cover,
                                            ),
                                            Align(
                                                alignment: AlignmentDirectional(
                                                    -0.74, 0.67),
                                                child: CircleAvatar(
                                                    radius: 60,
                                                    backgroundImage:
                                                        NetworkImage(snapshot
                                                            .data!.Avatar))),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.36, 0.77),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.add_circle_sharp,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  showMaterialModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        Container(
                                                            height: 200,
                                                            child: Container(
                                                              child: Center(
                                                                  child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 50,
                                                                    width: 250,
                                                                    child:
                                                                        OutlinedButton
                                                                            .icon(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .upload_rounded),
                                                                      label: Text(
                                                                          'Upload Profile'),
                                                                      style: OutlinedButton
                                                                          .styleFrom(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.blue,
                                                                            width: 2),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        profilePicker(
                                                                            ImageSource.gallery);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 50,
                                                                    width: 250,
                                                                    child:
                                                                        OutlinedButton
                                                                            .icon(
                                                                      onPressed:
                                                                          () {
                                                                        profilePicker(
                                                                            ImageSource.camera);
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .camera_alt_rounded),
                                                                      label: Text(
                                                                          'Click Now'),
                                                                      style: OutlinedButton
                                                                          .styleFrom(
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.blue,
                                                                            width: 2),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                            )),
                                                  );
                                                },
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.94, 1.30),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.edit_outlined,
                                                  color: Colors.black,
                                                  size: 25,
                                                ),
                                                onPressed: () {
                                                  showMaterialModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        Container(
                                                            height: 500,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          20,
                                                                          50,
                                                                          20,
                                                                          20),
                                                              child: Container(
                                                                child: Form(
                                                                  child: Column(
                                                                    children: [
                                                                      TextField(
                                                                        // controller: _name,
                                                                        keyboardType:
                                                                            TextInputType.name,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              'Full Name',
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      TextField(
                                                                        // controller: _email,
                                                                        keyboardType:
                                                                            TextInputType.emailAddress,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              'E-mail',
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      TextField(
                                                                        // controller: _phoneno,
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              'Phone no.',
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            50,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            100,
                                                                        child: ElevatedButton(
                                                                            style: ButtonStyle(
                                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(30.0),
                                                                                )),
                                                                                backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                                                                                elevation: MaterialStateProperty.all(0)),
                                                                            onPressed: () {},
                                                                            child: Text('Submit')),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )),
                                                  );
                                                },
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0, -0.21),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Color.fromARGB(
                                                      255, 90, 90, 90),
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  showMaterialModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        Container(
                                                            height: 200,
                                                            child: Container(
                                                                child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                  height: 50,
                                                                  width: 250,
                                                                  child:
                                                                      OutlinedButton
                                                                          .icon(
                                                                    onPressed:
                                                                        () {
                                                                      bannerPicker(
                                                                          ImageSource
                                                                              .gallery);
                                                                    },
                                                                    icon: Icon(Icons
                                                                        .upload_rounded),
                                                                    label: Text(
                                                                        'Upload Profile'),
                                                                    style: OutlinedButton
                                                                        .styleFrom(
                                                                      side: BorderSide(
                                                                          color: Colors
                                                                              .blue,
                                                                          width:
                                                                              2),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                SizedBox(
                                                                  height: 50,
                                                                  width: 250,
                                                                  child:
                                                                      OutlinedButton
                                                                          .icon(
                                                                    onPressed:
                                                                        () {
                                                                      bannerPicker(
                                                                          ImageSource
                                                                              .camera);
                                                                    },
                                                                    icon: Icon(Icons
                                                                        .camera_alt_rounded),
                                                                    label: Text(
                                                                        'Click Now'),
                                                                    style: OutlinedButton
                                                                        .styleFrom(
                                                                      side: BorderSide(
                                                                          color: Colors
                                                                              .blue,
                                                                          width:
                                                                              2),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ))),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 15),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(33, 0, 0, 0),
                                                  child: Text(
                                                    snapshot.data!.name,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(33, 11, 0, 0),
                                                  child: Text(
                                                    'Mumbai, Maharashtra, India',
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 10,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Color(0xfffaf5ee),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 20),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.email_rounded),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(snapshot.data!.email)
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.phone),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        snapshot.data!.mobileNo)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 10,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Color(0xfffaf5ee),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print("tapped on container");
                                        },
                                        child: Container(
                                          height: 40,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.logout_rounded),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text('Log out')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Color(0xfffaf5ee),
                                      ),
                                    ]),
                              )));
                    }))));
  }
}
