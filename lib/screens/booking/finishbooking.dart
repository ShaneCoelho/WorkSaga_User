import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:worksaga/screens/booking/booking.dart';
import 'package:worksaga/screens/home_screen/home.dart';
import 'package:worksaga/widgets/navbar.dart';

class FinishBooking extends StatefulWidget {
  const FinishBooking({Key? key}) : super(key: key);

  @override
  State<FinishBooking> createState() => _FinishBookingState();
}

class _FinishBookingState extends State<FinishBooking> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_4chtroo0.json'),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: 200,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 11, 39, 53)),
                    elevation: MaterialStateProperty.all(0)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Navbar()));
                },
                child: Text('Continue Booking')),
          ),
        ],
      ),
    )));
  }
}
