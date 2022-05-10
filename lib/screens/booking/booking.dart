// import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worksaga/models/usermodel.dart';
import '../../Widgets/appbar.dart';

import 'favourite.dart';
import 'pastbookig.dart';

class Bookings extends StatefulWidget {
  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  Future<FreelancerModel> upcomingb() async {
    final pref = await SharedPreferences.getInstance();
    final Authtoken = pref.getString("auth-token");
    late FreelancerModel docs;

    final url = Uri.parse("https://worksaga.herokuapp.com/api/auth/getuser");
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

  Color primarycolor = Color(0xff182a42);
  Color secondarycolor = Color.fromARGB(255, 184, 213, 235);
  Color widgetcolor = Color.fromARGB(255, 236, 236, 238);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: upcomingb(),
        builder: (context, AsyncSnapshot<FreelancerModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            print(snapshot.data!..upcomingBookings.length);
            return SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(86.0),
                      child: AppBarWidget()),
                  body: Container(
                    child: DefaultTabController(
                      length: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: secondarycolor),
                              width: 350,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ButtonsTabBar(
                                    backgroundColor: primarycolor,
                                    unselectedBackgroundColor: secondarycolor,
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    unselectedLabelStyle: TextStyle(
                                        color: primarycolor,
                                        fontWeight: FontWeight.bold),
                                    unselectedBorderColor: primarycolor,
                                    radius: 50,
                                    tabs: [
                                      Tab(text: "     Favourites    "),
                                      Tab(text: " Upcoming Bookings "),
                                      Tab(text: "  Past Bookings  "),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: TabBarView(
                                children: <Widget>[
                                  Center(
                                    child: SingleChildScrollView(
                                        child: FavouriteBookings()),
                                  ),
                                  SingleChildScrollView(
                                      child: ListView.builder(
                                          itemCount: snapshot
                                              .data!.upcomingBookings.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext, index) {
                                            return GestureDetector(
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20.0,
                                                        left: 20.0,
                                                        right: 20.0),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    decoration: BoxDecoration(
                                                      color: widgetcolor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    192,
                                                                    189,
                                                                    189),
                                                            blurRadius: 5.0,
                                                            blurStyle: BlurStyle
                                                                .outer),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(snapshot
                                                                  .data!
                                                                  .upcomingBookings[
                                                                      index]
                                                                  .avatar),
                                                          radius: 35,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  15, 0, 0, 0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    snapshot
                                                                        .data!
                                                                        .upcomingBookings[
                                                                            index]
                                                                        .freelancerName,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: RatingBar
                                                                        .builder(
                                                                      initialRating:
                                                                          3,
                                                                      minRating:
                                                                          1,
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      allowHalfRating:
                                                                          true,
                                                                      itemCount:
                                                                          5,
                                                                      itemSize:
                                                                          16.0,
                                                                      itemPadding:
                                                                          EdgeInsets.symmetric(
                                                                              horizontal: 0.5),
                                                                      itemBuilder:
                                                                          (context, _) =>
                                                                              Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      onRatingUpdate:
                                                                          (rating) {
                                                                        print(
                                                                            rating);
                                                                      },
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        6,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  'data',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        6,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  'data',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )));
                                          })),
                                  Center(
                                    child: SingleChildScrollView(
                                        child: PastBookings()),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            );
          }
          return Text("Error Occured 2");
        });
  }
}
