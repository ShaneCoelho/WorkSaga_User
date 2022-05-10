// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart';
import 'package:worksaga/screens/profile_page/editprofile.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../widgets/homepage_appbar.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? bannerPicture;
  File? profilePicture;
  bool showSpinner = false;
  final ImagePicker picker = ImagePicker();

  Future profilePicker(ImageSource source) async {
    final pref = await SharedPreferences.getInstance();
    final Authtoken = pref.getString("auth-token");
    final profilePic = await picker.getImage(source: source);
    if (PickedFile != null) {
      profilePicture = File(profilePic!.path) as File?;
    } else {
      profilePicture = AssetImage('assets/images/try.jpg') as File?;
    }
    setState(() {
      profilePicture = profilePic! as File?;
    });

    var url =
        Uri.parse("https://worksaga.herokuapp.com/api/userprofile/avatar");

    try {
      final request = http.MultipartRequest("POST", url);
      String filename = profilePicture!.path;
      request.files.add(http.MultipartFile(
        'picture',
        File(filename).readAsBytes().asStream(),
        File(filename).lengthSync(),
        filename: filename.split("/").last,
      ));

      request.headers.addAll({"auth-token": Authtoken.toString()});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future bannerPicker(ImageSource source) async {
    final bannerPic = await picker.getImage(source: source);
    setState(() {
      bannerPicture = bannerPic! as File?;
    });
  }

  Future<void> uploadprofile() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(profilePicture!.openRead());
    stream.cast();

    var length = await profilePicture;
    var uri = Uri.parse('https://fakestoreapi.com/products');
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
              body: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1,
                      // decoration: BoxDecoration(
                      //   color: Color(0xFFEEEEEE),
                      // ),
                      child: SingleChildScrollView(
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
                          Container(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.26,
                            child: Stack(
                              children: [
                                Image.network(
                                  'https://picsum.photos/seed/316/600',
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  fit: BoxFit.cover,
                                ),
                                Align(
                                    alignment:
                                        AlignmentDirectional(-0.74, 0.67),
                                    child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage: AssetImage(
                                            "assets/images/try.jpg"))),
                                Align(
                                  alignment: AlignmentDirectional(-0.36, 0.77),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add_circle_sharp,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      showMaterialModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                            height: 200,
                                            child: Container(
                                              child: Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: 250,
                                                    child: OutlinedButton.icon(
                                                      icon: Icon(
                                                          Icons.upload_rounded),
                                                      label: Text(
                                                          'Upload Profile'),
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: BorderSide(
                                                            color: Colors.blue,
                                                            width: 2),
                                                      ),
                                                      onPressed: () {
                                                        profilePicker(
                                                            ImageSource
                                                                .gallery);
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    width: 250,
                                                    child: OutlinedButton.icon(
                                                      onPressed: () {
                                                        profilePicker(
                                                            ImageSource.camera);
                                                      },
                                                      icon: Icon(Icons
                                                          .camera_alt_rounded),
                                                      label: Text('Click Now'),
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: BorderSide(
                                                            color: Colors.blue,
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
                                  alignment: AlignmentDirectional(0.94, 1.30),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      showMaterialModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                            height: 500, child: EditProfile()),
                                      );
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, -0.21),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Color.fromARGB(255, 90, 90, 90),
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      showMaterialModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                            height: 200,
                                            child: Container(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 50,
                                                  width: 250,
                                                  child: OutlinedButton.icon(
                                                    onPressed: () {
                                                      bannerPicker(
                                                          ImageSource.gallery);
                                                    },
                                                    icon: Icon(
                                                        Icons.upload_rounded),
                                                    label:
                                                        Text('Upload Profile'),
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      side: BorderSide(
                                                          color: Colors.blue,
                                                          width: 2),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                  width: 250,
                                                  child: OutlinedButton.icon(
                                                    onPressed: () {
                                                      bannerPicker(
                                                          ImageSource.camera);
                                                    },
                                                    icon: Icon(Icons
                                                        .camera_alt_rounded),
                                                    label: Text('Click Now'),
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      side: BorderSide(
                                                          color: Colors.blue,
                                                          width: 2),
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          33, 0, 0, 0),
                                      child: Text(
                                        "lauren jason gonsalves",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
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
                                            33, 5, 23, 0),
                                        child: Text(
                                          'hello',
                                          style: TextStyle(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          33, 11, 0, 0),
                                      child: Text(
                                        'Mumbai, Maharashtra, India',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
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
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xfffaf5ee),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.email_rounded),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('name@mail.com')
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
                                        Text('+91-9872534536')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 10,
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xfffaf5ee),
                          ),
                          InkWell(
                            onTap: () {
                              print("tapped on container");
                            },
                            child: Container(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Icon(Icons.settings),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Setting')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xfffaf5ee),
                          ),
                        ]),
                      ))))),
    );
  }
}
