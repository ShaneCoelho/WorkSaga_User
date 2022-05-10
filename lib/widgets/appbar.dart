import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatefulWidget {
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      flexibleSpace: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Work Saga',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NanumMyeongjo'),
              ),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Location',
                    style: TextStyle(color: Colors.black),
                  ))
            ]),
          )),
    );
  }
}
