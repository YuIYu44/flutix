import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/main.dart';
import 'package:flutter_1/services/services.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';

class succespage extends StatelessWidget {
  String email;
  succespage(this.email);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserService.getvalue(email),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return WillPopScope(
                  onWillPop: () {
                    return Future.value(false);
                  },
                  child: Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          texts_exo(context, 'Welcome To', 35, 0, 0, 0, 0,
                              Colors.black, TextAlign.center, FontWeight.w500),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                texts_bubble(
                                    context,
                                    'FLU',
                                    MediaQuery.sizeOf(context).width * 0.2,
                                    0.02,
                                    0,
                                    0,
                                    0,
                                    Color(0xff2E6FEC),
                                    TextAlign.left),
                                texts_bubble(
                                    context,
                                    'TIX',
                                    MediaQuery.sizeOf(context).width * 0.2,
                                    0.02,
                                    0,
                                    0,
                                    0,
                                    Color.fromRGBO(70, 0, 220, 1.0),
                                    TextAlign.left)
                              ]),
                          Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.sizeOf(context).height * 0.04,
                                  bottom:
                                      MediaQuery.sizeOf(context).height * 0.15),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.film, size: 25),
                                    texts_exo(
                                        context,
                                        snapshot.data![0],
                                        25,
                                        0,
                                        0,
                                        0.05,
                                        0.05,
                                        Colors.black,
                                        TextAlign.center,
                                        FontWeight.bold),
                                    Container(
                                        child: Icon(CupertinoIcons.film_fill,
                                            size: 25))
                                  ])),
                          customButton(
                              context,
                              'Finish',
                              180,
                              45,
                              Color(0xff4A9DFF),
                              Color.fromRGBO(255, 255, 255, 1.0), () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                                (Route<dynamic> route) => false);
                          }),
                        ],
                      ),
                    ),
                  ));
            }
          }
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
