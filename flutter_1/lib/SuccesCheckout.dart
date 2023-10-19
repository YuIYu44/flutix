import 'functions.dart';
import 'package:flutter/material.dart';

//check out to this page need to use
//go_to(BuildContext context, page,"home") ;

class successcheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          appBar: barflutix(context),
          body: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                  child: texts_exo(context, "Enjoy The Movie!", 35, 0, 0, 0, 0,
                      Colors.black, TextAlign.center, FontWeight.w400),
                ),
                Container(
                  margin: EdgeInsets.only(top: 17),
                  width: MediaQuery.of(context).size.width * 0.73,
                  child: texts_exo(
                      context,
                      "Don't forget to but your popcorn",
                      15,
                      0,
                      0,
                      0,
                      0,
                      Colors.black,
                      TextAlign.center,
                      FontWeight.w200),
                ),
                Container(
                  margin: EdgeInsets.only(top: 80),
                  width: MediaQuery.of(context).size.width * 0.73,
                  child: texts_exo(
                      context,
                      "Your Ticket has been succesfully paid",
                      25,
                      0,
                      0,
                      0,
                      0,
                      Colors.black,
                      TextAlign.center,
                      FontWeight.w200),
                ),
                Container(
                    margin: EdgeInsets.only(top: 70),
                    child: customButton(
                        context,
                        'My Ticket',
                        0,
                        140,
                        45,
                        Color(0xff4A9DFF),
                        Color.fromRGBO(255, 255, 255, 1.0), () {
                      Navigator.pushNamed(context, '/myticket');
                    })),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: customButton(
                        context,
                        'Home',
                        0,
                        140,
                        45,
                        Color.fromRGBO(255, 255, 255, 1.0),
                        Color(0xff4A9DFF), () {
                      Navigator.pop(context);
                    })),
              ],
            ),
          ),
        ));
  }
}
