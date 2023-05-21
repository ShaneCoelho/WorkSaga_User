import 'dart:convert';

import 'package:flutter/material.dart' ;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:favorite_button/favorite_button.dart';
import 'package:http/http.dart' as http;
import 'package:worksaga/widgets/navbar.dart';
import '../../Widgets/appbar.dart';
import '../../models/freelancerprofilemodel.dart';
import 'package:lottie/lottie.dart';

import 'bookfreelancer.dart';

class FreelancerProfile extends StatefulWidget {
  final String value;
  const FreelancerProfile({Key? key, required this.value}) : super(key: key);
  @override
  _FreelancerProfileState createState() => _FreelancerProfileState();
}

class _FreelancerProfileState extends State<FreelancerProfile> {
  late String name;
  late PageController pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getprofile();
    super.initState();
  }

  Future<void> Favourite(String Fid) async {
    final pref = await SharedPreferences.getInstance();
    final Authtoken = pref.getString("auth-token");
    String cc =
        "https://worksaga.onrender.com/api/user/bookmark/" + widget.value;
    final response = await http.post(
      Uri.parse(cc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': Authtoken.toString(),
      },
      body: jsonEncode(<String, String>{
        'freelancerId': Fid,
      }),
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      print(responseJson);
    } else if (response.statusCode == 400) {
      print(response.body);
    } else {
      throw Exception('Failed to create data.');
    }
  }

  Future<void> UnFavourite(String Fid) async {
    final pref = await SharedPreferences.getInstance();
    final Authtoken = pref.getString("auth-token");
    String cc =
        "https://worksaga.onrender.com/api/user/bookmark/" + widget.value;

    final response = await http.post(
      Uri.parse(cc),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': Authtoken.toString(),
      },
      body: jsonEncode(<String, String>{
        'freelancerId': Fid,
      }),
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      print(responseJson);
    } else if (response.statusCode == 400) {
      print(response.body);
    } else {
      throw Exception('Failed to create data.');
    }
  }

  Future<UserModel> getprofile() async {
    late UserModel model;
    String cc = "https://worksaga.onrender.com/api/user/findfreelancers/" +
        widget.value;
    var url = Uri.parse(cc);

    var response = await http.get(url,
        headers: <String, String>{"content-type": "application/json"});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      model = UserModel.fromJson(data);
    }
    var datafreelancer = model;

    return model;
  }

  Color _iconColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    // Size get; preferredSize => const Size.fromHeight(100);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBarWidget();
        key: scaffoldKey,
        backgroundColor: Colors.white,

        body: FutureBuilder(
            future: getprofile(),
            builder: (context, AsyncSnapshot<UserModel> snapshot) {
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
                                alignment: AlignmentDirectional(0.5, 1.1),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    side: BorderSide(
                                        width: 2, color: Color(0xff09172a)),
                                  ),
                                  child: Text(
                                    'Book a Service',
                                    style: TextStyle(color: Color(0xff09172a)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BookFreelancer(
                                                    profile:
                                                        snapshot.data!.Avatar,
                                                    name: snapshot.data!.name,
                                                    charge:
                                                        snapshot.data!.charge,
                                                    freelancerId:
                                                        widget.value)));
                                  },
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.95, 1.0),
                                child: FavoriteButton(
                                  iconSize: 50,
                                  iconColor: Color(0xff09172a),
                                  isFavorite: false,
                                  // iconDisabledColor: Colors.white,
                                  valueChanged: (_isFavorite) {
                                    print('Is Favorite : $_isFavorite');
                                    if (_isFavorite == true) {
                                      Favourite(widget.value);
                                    } else {
                                      UnFavourite(widget.value);
                                    }
                                  },
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-0.74, 1.1),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    snapshot.data!.Avatar,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
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
                                      snapshot.data!.name,
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
                                        snapshot.data!.bio,
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
                                      style: TextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 15,
                          thickness: 15,
                          color: Color(0xFFE5E5E5),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          33, 0, 0, 0),
                                      child: Text(
                                        'About',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          33, 0, 23, 0),
                                      child: Text(
                                        snapshot.data!.about,
                                        style: TextStyle(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 15,
                          thickness: 15,
                          color: Color(0xFFE5E5E5),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        33, 10, 0, 10),
                                    child: Text(
                                      'Cost',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(33, 0, 0, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Text('\$2000')],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 15,
                          thickness: 15,
                          color: Color(0xFFE5E5E5),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        33, 10, 0, 10),
                                    child: Text(
                                      'Experiences',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 18),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        31, 0, 0, 0),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/380/600',
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    21, 0, 0, 0),
                                            child: Text(
                                              snapshot
                                                  .data!.experience[0].title,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    21, 0, 0, 0),
                                            child: Text(
                                              snapshot.data!.experience[0]
                                                  .description,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 49),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        31, 0, 0, 0),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/630/600',
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    21, 0, 0, 0),
                                            child: Text(
                                              'Marketing Executive',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    21, 0, 0, 0),
                                            child: Text(
                                              'Lorem Ipsum is simply dummy text of \nthe printing and typesetting industry.',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 15,
                          thickness: 15,
                          color: Color(0xFFE5E5E5),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        33, 10, 0, 10),
                                    child: Text(
                                      'CV & Certifications',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.35,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 500,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 50),
                                      child: PageView(
                                        controller: pageViewController =
                                            PageController(initialPage: 0),
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Image.network(
                                            'https://picsum.photos/seed/266/600',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          Image.network(
                                            'https://picsum.photos/seed/706/600',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          Image.network(
                                            'https://picsum.photos/seed/364/600',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 1),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 10),
                                        child: SmoothPageIndicator(
                                          controller: pageViewController =
                                              PageController(initialPage: 0),
                                          count: 3,
                                          axisDirection: Axis.horizontal,
                                          onDotClicked: (i) {
                                            pageViewController.animateToPage(
                                              i,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          },
                                          effect: ExpandingDotsEffect(
                                            expansionFactor: 2,
                                            spacing: 5,
                                            radius: 12,
                                            dotWidth: 6,
                                            dotHeight: 6,
                                            dotColor: Color(0xFF9E9E9E),
                                            activeDotColor: Color(0xFF3F51B5),
                                            paintStyle: PaintingStyle.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
