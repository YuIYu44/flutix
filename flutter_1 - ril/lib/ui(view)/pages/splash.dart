import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';

class splashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03),
              child: Image.asset(
                'asset/popcorn.png',
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),
            texts_bubble(context, 'NEW EXPERIENCE', 30.0, 0, 0, 0, 0,
                Color(0xff2E6FEC), TextAlign.center),
            texts_bubble(
                context,
                'Watch Movie With Your Friends,\nFamilies, and Lovers Much Easier',
                15.0,
                0.02,
                0.05,
                0,
                0,
                Color(0xFF4600DC),
                TextAlign.center),
            customButton(context, 'Log In', 150, 45, Color(0xff4A9DFF),
                Color.fromRGBO(255, 255, 255, 1.0), () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => login()));
            }),
            customButton(context, 'Sign Up', 150, 45,
                Color.fromRGBO(255, 255, 255, 1.0), Color(0xff4A9DFF), () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => signup()));
            }),
          ],
        ),
      ),
    );
  }
}
