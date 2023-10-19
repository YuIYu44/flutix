import 'package:flutter_1/home.dart';
import 'functions.dart';
import 'package:flutter/material.dart';

class succespage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                texts_exo(
                    context,
                    'Welcome To',
                    32,
                    MediaQuery.of(context).size.height * 0.3,
                    0,
                    0,
                    MediaQuery.of(context).size.width * 0.2,
                    Colors.black,
                    TextAlign.center,
                    FontWeight.w400),
                texts_bubble(
                    context,
                    'FLU',
                    50.0,
                    MediaQuery.of(context).size.height * 0.4,
                    0,
                    MediaQuery.of(context).size.width * 0.31,
                    0,
                    Color(0xff2E6FEC),
                    TextAlign.left),
                texts_bubble(
                    context,
                    'TIX',
                    50.0,
                    MediaQuery.of(context).size.height * 0.4,
                    0,
                    MediaQuery.of(context).size.width * 0.31 + 100,
                    0,
                    Color.fromRGBO(70, 0, 220, 1.0),
                    TextAlign.left),
                texts_exo(
                    context,
                    'xxx',
                    20,
                    MediaQuery.of(context).size.height * 0.65,
                    0,
                    0,
                    0,
                    Colors.black,
                    TextAlign.center,
                    FontWeight.normal),
                customButton(
                    context,
                    'Finish',
                    MediaQuery.of(context).size.height * 0.82,
                    150,
                    45,
                    Color(0xff4A9DFF),
                    Color.fromRGBO(255, 255, 255, 1.0), () {
                  go_to(context, home());
                }),
              ],
            ),
          ),
        ));
  }
}
