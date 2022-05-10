import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  final String value;
  const CategoriesWidget({Key? key, required this.value}) : super(key: key);

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(35, 20, 0, 0),
          child: Container(
            width: 325,
            height: 130,
            decoration: BoxDecoration(
              color: Color(0xFFCBDEED),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/p2.png',
                    width: 100,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.value,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 170,
                        child: Text(
                          'An electrician is a tradesperson specializing in electrical wiring',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
