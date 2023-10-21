import 'package:flutter/material.dart';
import 'package:flutter_1/functions.dart';
import 'package:flutter_1/seat_page.dart';

class scheduleplace extends StatefulWidget {
  scheduleplace({super.key});

  @override
  State<scheduleplace> createState() => schdp();
}

class schdp extends State<scheduleplace> {
  void _toggleButtonState(int index) {
    setState(() {
      for (int i = 0; i < buttonStates_date.length; i++) {
        if (i != index) {
          buttonStates_date[i] = false;
        }
      }
      buttonStates_date[index] = !buttonStates_date[index];
    });
  }

  void _toggleButtonState_place(int index_cinema, int index_time) {
    setState(() {
      buttonStates_cinema[index_cinema][index_time] =
          !buttonStates_cinema[index_cinema][index_time];
      for (int i = 0; i < buttonStates_cinema.length; i++) {
        for (int j = 0; j < buttonStates_cinema[i].length; j++) {
          if (i != index_cinema || j != index_time) {
            buttonStates_cinema[i][j] = false;
          }
        }
      }
    });
  }

  List<bool> buttonStates_date = List.generate(7, (index) => false);
  List<List<bool>> buttonStates_cinema =
      List.generate(5, (row) => List.generate(6, (col) => false));
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
                child: Stack(children: [
                  SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.07),
                            width: MediaQuery.of(context).size.width * 0.97,
                            child: Text(
                              "Choose Date",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Exo',
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 8,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: OutlinedButton(
                                          onPressed: () {
                                            _toggleButtonState(index);
                                          },
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                buttonStates_date[index]
                                                    ? Color(0x404600DC)
                                                    : Colors.white,
                                            side: BorderSide(
                                                width: 1.0,
                                                color: Color(0xFF4600DC)),
                                          ),
                                          child: Text(
                                            "Wed, 15 May",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF4600DC),
                                              fontSize: 15,
                                              fontFamily: 'Exo',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                    )
                                  ]);
                                })),
                        Container(
                            margin: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.055),
                            width: MediaQuery.of(context).size.width * 0.97,
                            child: Text(
                              "Place & Time",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Exo',
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: buttonStates_cinema.length,
                                itemBuilder:
                                    (BuildContext context, int index_place) {
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "THE CINEMA NAME",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Exo',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: buttonStates_cinema[
                                                        index_place]
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index_time) {
                                                  return Column(children: [
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.06,
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 0),
                                                      child: OutlinedButton(
                                                          onPressed: () =>
                                                              _toggleButtonState_place(
                                                                  index_place,
                                                                  index_time),
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                buttonStates_cinema[
                                                                            index_place]
                                                                        [
                                                                        index_time]
                                                                    ? Color(
                                                                        0x404600DC)
                                                                    : Colors
                                                                        .white,
                                                            side: BorderSide(
                                                                width: 1.0,
                                                                color: Color(
                                                                    0xFF4600DC)),
                                                          ),
                                                          child: Text(
                                                            "20:00",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: buttonStates_cinema[
                                                                          index_place]
                                                                      [
                                                                      index_time]
                                                                  ? Colors.white
                                                                  : Color(
                                                                      0xFF4600DC),
                                                              fontSize: 15,
                                                              fontFamily: 'Exo',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          )),
                                                    )
                                                  ]);
                                                }))
                                      ]);
                                })),
                      ])),
                  Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.06),
                  buttonblue(context, "Back", Color(0xff4A9DFF),
                      Color(0xffffffff), Color(0xff4A9DFF), 0, 0.23, () {
                    Navigator.pop(context);
                  }),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.78,
                      child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1)),
                  Positioned(
                      left: MediaQuery.of(context).size.width * 0.55,
                      child: buttonblue(
                          context,
                          "Choose Seats",
                          Color(0xffffffff),
                          Color(0xff4A9DFF),
                          Color(0xff4A9DFF),
                          0.8,
                          0.37, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => seat_page()),
                        );
                      })),
                ]))));
  }
}
