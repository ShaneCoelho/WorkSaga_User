import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:worksaga/screens/freelancerprofile/freelancerprofile.dart';
import '../../models/selectedcatmodel.dart';
import '../../widgets/selectedcatwidget.dart';
import 'categories.dart';
import 'package:lottie/lottie.dart';

class SelectedCategories extends StatefulWidget {
  final String value;
  const SelectedCategories({Key? key, required this.value}) : super(key: key);
  @override
  State<SelectedCategories> createState() => _SelectedCategoriesState();
}

class _SelectedCategoriesState extends State<SelectedCategories> {
  Future<List<SelectedCategoriesModel>> getfreelancers() async {
    List<SelectedCategoriesModel> docs = [];

    // final pref = await SharedPreferences.getInstance();
    // final email = pref.getString("email");

    final url = Uri.parse(
        "https://worksaga.onrender.com/api/user/findfreelancerstype/" +
            widget.value);
    var response = await http.get(
      url,
      headers: <String, String>{
        'content-type': 'application/json',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body) as List;
      docs = data.map((e) => SelectedCategoriesModel.fromJson(e)).toList();
    } else {
      print(response.statusCode);
    }
    print(docs);

    return docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.red,
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 231,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/selcat.png"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('WorkSaga',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            )),
                        TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_on,
                              size: 16,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            label: Text(
                              'Vasai-Virar, Maharashtra',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text('Search'),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.search))
                    ],
                  ),
                  height: 38,
                  width: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFEEEEEE),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Column(
          children: [
            FutureBuilder(
                future: getfreelancers(),
                builder: (context,
                    AsyncSnapshot<List<SelectedCategoriesModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error Occured"),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FreelancerProfile(
                                          value: snapshot.data![index].id)));
                            },
                            child: SelectedCategoriesWidget(
                              name: snapshot.data![index].name,
                              bio: snapshot.data![index].bio,
                              banner: snapshot.data![index].banner,
                              id: snapshot.data![index].id,
                              Avatar: snapshot.data![index].Avatar,
                              rating: snapshot.data![index].rating,
                            ),
                          );
                        });
                  }
                  return Text("Error Occured");
                }),
            SizedBox(
              height: 20.0,
            )
          ],
        )
      ],
    )));
  }
}
