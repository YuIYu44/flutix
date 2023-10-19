import 'package:flutter_1/home.dart';
import 'functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/login.dart';
import 'package:flutter_1/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_1/services/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FLUTIX",
      home: splashscreen(),
    );
  }
}

class splashscreen extends StatelessWidget {
  void navigateToSecondPage(BuildContext context, page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset(
                'asset/popcorn.png',
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
              ),
            ),
            texts_bubble(
                context,
                'NEW EXPERIENCE',
                30.0,
                MediaQuery.of(context).size.height * 0.5,
                0,
                0,
                0,
                Color(0xff2E6FEC),
                TextAlign.center),
            texts_bubble(
                context,
                'Watch Movie With Your Friends,\nFamilies, and Lovers Much Easier',
                14.0,
                MediaQuery.of(context).size.height * 0.6,
                0,
                0,
                0,
                Color(0xFF4600DC),
                TextAlign.center),
            customButton(
                context,
                'Log In',
                MediaQuery.of(context).size.height * 0.72,
                150,
                45,
                Color(0xff4A9DFF),
                Color.fromRGBO(255, 255, 255, 1.0), () {
              //   async {
              // await AutServices.signUp("ayulestari@gmail.com", "1234", "ayu",
              //     ["Action", "Horror", "Sci-Fi", "Drama"], "Korean");
              // }
              // go_to(context, login());
              go_to(context, login());
            }),
            customButton(
                context,
                'Sign Up',
                MediaQuery.of(context).size.height * 0.8,
                150,
                45,
                Color.fromRGBO(255, 255, 255, 1.0),
                Color(0xff4A9DFF), () {
              go_to(context, signup());
            }),
          ],
        ),
      ),
    );
  }
}
