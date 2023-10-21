import 'package:flutter/material.dart';
import 'package:flutter_1/functions.dart';
import 'package:flutter_1/schedule&place.dart';

class movie_detail extends StatefulWidget {
  const movie_detail({super.key});

  @override
  State<movie_detail> createState() => movie();
}

class movie extends State<movie_detail> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
            appBar: barflutix(context),
            body: Padding(
              padding: customEdgeInsets(context),
              child: Stack(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buttonblue(context, "Back", Color(0xff4A9DFF),
                            Color(0xffffffff), Color(0xff4A9DFF), 0, 0.23, () {
                          Navigator.pop(context);
                        }),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03),
                          width: MediaQuery.of(context).size.width * 0.97,
                          height: MediaQuery.of(context).size.height * 0.2,
                          color: Colors.black,
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02),
                            width: MediaQuery.of(context).size.width * 0.97,
                            child: Text(
                              "The Title",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontFamily: 'Exo',
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Text(
                                "4.0",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Exo',
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              Icon(Icons.star, color: Color(0xFF4600DC))
                            ]),
                            Text(
                              "Adventure",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Exo',
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02),
                            child: Text(
                              "Description:",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Exo',
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01),
                            child: Text(
                              "Katniss Everdeen voluntarily takes her younger sister's place in the Hunger Games: a televised competition in which two teenagers from each of the twelve Districts of Panem are chosen at random to fight to the death.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Exo',
                                  fontWeight: FontWeight.normal),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02),
                            child: Text(
                              "Cast:",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Exo',
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 8,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "The Artist Names",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 115, 22, 22),
                                                fontSize: 14,
                                                fontFamily: 'Exo',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Text(
                                              "as The Character",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 115, 22, 22),
                                                fontSize: 14,
                                                fontFamily: 'Exo',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ]));
                                })),
                      ]),
                  Positioned(
                      left: MediaQuery.of(context).size.width * 0.3,
                      top: MediaQuery.of(context).size.height * 0.78,
                      child: buttonblue(context, "Book", Color(0xffffffff),
                          Color(0xff4A9DFF), Color(0xff4A9DFF), 0, 0.32, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => scheduleplace()),
                        );
                      })),
                ],
              ),
            )));
  }
}
