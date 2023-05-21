// import 'dart:convert';
// import '../../models/usermodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:worksaga/models/freelancerprofilemodel.dart';
// import 'package:http/http.dart' as http;
// import 'package:worksaga/models/usermodel.dart';

// class UpcomingBookings extends StatefulWidget {
//   String id, name, email, mobileno, Avatar;
//   int rating;
//   UpcomingBookings(
//       {required this.id,
//       required this.name,
//       required this.email,
//       required this.mobileno,
//       required this.Avatar,
//       required this.rating});
//   @override
//   State<UpcomingBookings> createState() => _UpcomingBookingsState();
// }

// class _UpcomingBookingsState extends State<UpcomingBookings> {
//   Future<List<FreelancerModel>> getfreelancer() async {
//     List<FreelancerModel> docs = [];

//     // final pref = await SharedPreferences.getInstance();
//     // final email = pref.getString("email");

//     final url =
//         Uri.parse("https://worksaga.onrender.com/api/user/findfreelancers");
//     var response = await http.get(
//       url,
//       headers: <String, String>{
//         'content-type': 'application/json',
//       },
//     );

//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print(response.body);
//       var data = jsonDecode(response.body) as List;
//       docs = data.map((e) => FreelancerModel.fromJson(e)).toList();
//     } else {
//       print(response.statusCode);
//     }
//     print(docs);

//     return docs;
//   }

//   Color widgetcolor = Color.fromARGB(255, 236, 236, 238);
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 8,
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemBuilder: (BuildContext context, index) {
//           return GestureDetector(
//               child: Container(
//                   margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
//                   padding: const EdgeInsets.all(5.0),
//                   decoration: BoxDecoration(
//                     color: widgetcolor,
//                     boxShadow: [
//                       BoxShadow(
//                           color: Color.fromARGB(255, 192, 189, 189),
//                           blurRadius: 5.0,
//                           blurStyle: BlurStyle.outer),
//                     ],
//                     borderRadius: BorderRadius.circular(50.0),
//                   ),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 35,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   'Name Surname',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                   child: RatingBar.builder(
//                                     initialRating: 3,
//                                     minRating: 1,
//                                     direction: Axis.horizontal,
//                                     allowHalfRating: true,
//                                     itemCount: 5,
//                                     itemSize: 16.0,
//                                     itemPadding:
//                                         EdgeInsets.symmetric(horizontal: 0.5),
//                                     itemBuilder: (context, _) => Icon(
//                                       Icons.star,
//                                       color: Colors.black,
//                                     ),
//                                     onRatingUpdate: (rating) {
//                                       print(rating);
//                                     },
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
//                               child: Text(
//                                 'data',
//                                 style: TextStyle(fontSize: 12),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
//                               child: Text(
//                                 'data',
//                                 style: TextStyle(fontSize: 12),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   )));
//         });
//   }
// }
