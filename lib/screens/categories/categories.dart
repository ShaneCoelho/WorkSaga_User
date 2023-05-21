import 'package:flutter/material.dart';
import 'package:worksaga/screens/profile_page/profilepage.dart';

import '../../widgets/categorieswidget.dart';
import '../../widgets/navbar.dart';
import 'selectedcategories.dart';
// import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> value = <String>[
    'electrician',
    'plumber',
    'mechanic',
    'webdeveloper',
    'acrepair',
    'parlour',
    'datascience',
    'engineering',
    'writing',
    'translation',
    'legal',
    'adminsupport',
    'customerservice',
    'sales',
    'accounting',
    'design ',
    'manager'
  ];
  final List<String> displayvalue = <String>[
    'Electrician',
    'Plumber',
    'Mechanic',
    'Web Developer',
    'AC Repair',
    'Parlour',
    'Data Science',
    'Engineering',
    'Writing',
    'Translation',
    'Legal',
    'Admin Support',
    'Customer ser',
    'Sales ',
    'Accounting',
    'Design ',
    'Manager'
  ];
  final List<String> displayimg = <String>[
    'assets/images/p2.png',
    'assets/images/s6.png',
    'assets/images/s3.png',
    'assets/images/s2.png',
    'assets/images/s4.png',
    'assets/images/s1.png',
    'assets/images/s6.png',
    'assets/images/s6.png',
    'assets/images/s3.png',
    'assets/images/s4.png',
    'assets/images/s5.png',
    'assets/images/s6.png',
    'assets/images/s1.png',
    'assets/images/s6.png',
    'assets/images/s3.png',
    'assets/images/s5.png',
    'assets/images/s6.png'
  ];

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height * 1,
          ),
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                          ),
                          child: Image.asset(
                            'assets/images/categories.png',
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(35, 240, 0, 0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategories(
                                          value: "softwaredeveloper")));
                            },
                            child: Container(
                              width: 340,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Color(0xFFDBECF4),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/s2.png',
                                      width: 100,
                                      height: 130,
                                      fit: BoxFit.cover,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Software Dev',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: 170,
                                          child: Text(
                                            'Click to select your favourite worker and get your work done',
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(45, 175, 0, 0),
                        child: Container(
                          width: 280,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: textController,
                            obscureText: false,
                            decoration: InputDecoration(
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
                                  EdgeInsetsDirectional.fromSTEB(20, 5, 0, 0),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                            ),
                            style: TextStyle(),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-0.2, -0.3),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 100, 0, 0),
                                    child: Text(
                                      'Work Saga',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(15, 0, 5, 1),
                                child: Icon(
                                  Icons.location_pin,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 17,
                                ),
                              ),
                              Text(
                                'Vasai-Virar, Maharashtra',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: value.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SelectedCategories(
                                                value: "${value[index]}")));
                              },
                              child: CategoriesWidget(
                                  value: "${displayvalue[index]}",
                                  image: "${displayimg[index]}"));
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
