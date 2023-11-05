import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/services/show_film.dart';
import 'package:flutter_1/ui(view)/pages/schedule&place.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';

String data = "";

class movie_detail extends StatefulWidget {
  final String data;
  const movie_detail({Key? key, required this.data}) : super(key: key);

  @override
  State<movie_detail> createState() => MovieDetailState(data);
}

class MovieDetailState extends State<movie_detail> {
  MovieDetailState(String datas) {
    data = datas;
  }
  @override
  Widget build(BuildContext context) {
    show_film show = show_film(data);
    return FutureBuilder(
        future: show.titles(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: Scaffold(
                appBar: barflutix(context),
                body: Padding(
                    padding: customEdgeInsets(context),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buttonblue(
                                context,
                                "Back",
                                Color(0xff4A9DFF),
                                Color(0xffffffff),
                                Color(0xff4A9DFF),
                                0,
                                0.23, () {
                              Navigator.pop(context);
                            }),
                            Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.03,
                                    left: MediaQuery.of(context).size.width *
                                        0.15),
                                width: 300,
                                height: 450,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: NetworkImage(
                                    show.title_(0),
                                  ),
                                  fit: BoxFit.cover,
                                ))),
                            Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.02),
                                width: MediaQuery.of(context).size.width * 0.97,
                                child: Text(
                                  show.title_(1),
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
                                    show.title_(2) + "   ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Exo',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.star,
                                    color: Color(0xFF4600DC),
                                    size: 20,
                                  )
                                ]),
                                Text(
                                  show.title_(3),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Exo',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.02),
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
                                    top: MediaQuery.of(context).size.height *
                                        0.01),
                                child: Text(
                                  show.title_(4),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Exo',
                                      fontWeight: FontWeight.normal),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.02),
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
                                    top: MediaQuery.of(context).size.height *
                                        0.01),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: show.title_(5).length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  show.title_(5)[index][0],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Exo',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Text(
                                                  "as " +
                                                      show.title_(5)[index][1],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Exo',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ]));
                                    })),
                            Container(
                                margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.3,
                                ),
                                child: buttonblue(
                                    context,
                                    "Book",
                                    Color(0xffffffff),
                                    Color(0xff4A9DFF),
                                    Color(0xff4A9DFF),
                                    0,
                                    0.32, () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            scheduleplace(data: data)),
                                  );
                                })),
                          ]),
                    )),
              ),
            );
            // ));
          } else {
            return Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            );
          }
        });
  }
}
