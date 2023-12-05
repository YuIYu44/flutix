import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/services/services.dart';
import 'package:flutter_1/ui(view)/pages/schedule&place.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';

class movie_detail extends StatelessWidget {
  final String data;

  const movie_detail({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: show_film(data).getposts_weblink(""),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
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
                                    snapshot.data['link'],
                                  ),
                                  fit: BoxFit.cover,
                                ))),
                            Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.02),
                                width: MediaQuery.of(context).size.width * 0.97,
                                child: Text(
                                  snapshot.data['movie_name'],
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
                                    snapshot.data['rating'].toString() + "   ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Exo',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.star,
                                    color: Color(0xFF4600DC),
                                    size: 20,
                                  )
                                ]),
                                Text(
                                  snapshot.data['category'],
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
                                  snapshot.data['sinopsis'],
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
                                    itemCount: snapshot.data['castlist'].length,
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
                                                  snapshot.data['castlist'].keys
                                                      .toList()[index],
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
                                                      snapshot.data['castlist']
                                                          .values
                                                          .toList()[index],
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
                            if (snapshot.data['available'] == 1)
                              Container(
                                  margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * 0.3,
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
                                            scheduleplace(data: data),
                                        settings:
                                            RouteSettings(name: '/schedule'),
                                      ),
                                    );
                                  })),
                          ]),
                    )),
              ),
            );
          } else {
            return Center(
                child: Text(
              "I'm Sorry But It Seems That Your Movie Is Not Available",
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ));
          }
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
