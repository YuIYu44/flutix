import 'package:flutter/material.dart';
import 'package:flutter_1/services/show_film.dart';
import 'seat_page.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';

String data = "";

class scheduleplace extends StatefulWidget {
  final String data;
  const scheduleplace({Key? key, required this.data}) : super(key: key);

  @override
  State<scheduleplace> createState() => schdp(data);
}

class schdp extends State<scheduleplace> {
  int choose_date = 0;
  schdp(String datas) {
    data = datas;
  }

  void _toggleButtonState(int index) {
    setState(() {
      for (int i = 0; i < buttonStates_date.length; i++) {
        if (i != index) {
          buttonStates_date[i] = false;
        }
      }
      choose_date = index;
      buttonStates_date[index] = !buttonStates_date[index];
      if (buttonStates_date.every((element) => element == false)) {
        buttonStates_date[index] = true;
      }
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

  List<bool> buttonStates_date = List.generate(15, (index) => false);
  List<List<bool>> buttonStates_cinema =
      List.generate(9, (row) => List.generate(15, (col) => false));
  @override
  Widget build(BuildContext context) {
    _toggleButtonState(choose_date);
    show_film show = show_film(data);
    return FutureBuilder(
        future: show.show_schedule(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return WillPopScope(
                onWillPop: () {
                  return Future.value(false);
                },
                child: Scaffold(
                    appBar: barflutix(context),
                    body: Stack(children: [
                      Positioned(
                          top: MediaQuery.of(context).size.width * 0.23,
                          left: MediaQuery.of(context).size.width * 0.02,
                          right: MediaQuery.of(context).size.width * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.1,
                          child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                SizedBox(
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
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: show.title_(-1).length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.06,
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: OutlinedButton(
                                                  onPressed: () {
                                                    _toggleButtonState(index);
                                                    _toggleButtonState_place(
                                                        8, 14);
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        buttonStates_date[index]
                                                            ? Color(0x404600DC)
                                                            : Colors.white,
                                                    side: BorderSide(
                                                        width: 1.0,
                                                        color:
                                                            Color(0xFF4600DC)),
                                                  ),
                                                  child: Text(
                                                    show.title_(index)[0],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFF4600DC),
                                                      fontSize: 15,
                                                      fontFamily: 'Exo',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )),
                                            )
                                          ]);
                                        })),
                                Container(
                                    margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.055),
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
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    height: MediaQuery.of(context).size.height *
                                        0.12 *
                                        (show.title_(choose_date).length - 1),
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            show.title_(choose_date).length - 1,
                                        itemBuilder: (BuildContext context,
                                            int index_place) {
                                          return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  show.title_(choose_date)[
                                                      index_place + 1][0],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontFamily: 'Exo',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                        bottom:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                0.03),
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.06,
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: show
                                                            .title_(choose_date)[index_place + 1]
                                                                [1]
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext context,
                                                                int index_time) {
                                                          return Column(
                                                              children: [
                                                                Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.06,
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          0),
                                                                  child: OutlinedButton(
                                                                      onPressed: () {
                                                                        _toggleButtonState_place(
                                                                            index_place,
                                                                            index_time);
                                                                      },
                                                                      style: OutlinedButton.styleFrom(
                                                                        backgroundColor: buttonStates_cinema[index_place][index_time]
                                                                            ? Color(0x404600DC)
                                                                            : Colors.white,
                                                                        side: BorderSide(
                                                                            width:
                                                                                1.0,
                                                                            color:
                                                                                Color(0xFF4600DC)),
                                                                      ),
                                                                      child: Text(
                                                                        show.title_(choose_date)[index_place + 1][1][index_time].toString() +
                                                                            ":00",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          color: buttonStates_cinema[index_place][index_time]
                                                                              ? Colors.white
                                                                              : Color(0xFF4600DC),
                                                                          fontSize:
                                                                              15,
                                                                          fontFamily:
                                                                              'Exo',
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      )),
                                                                )
                                                              ]);
                                                        }))
                                              ]);
                                        })),
                              ]))),
                      Positioned(
                          left: MediaQuery.of(context).size.width * 0.02,
                          child: buttonblue(
                              context,
                              "Back",
                              Color(0xff4A9DFF),
                              Color(0xffffffff),
                              Color(0xff4A9DFF),
                              0,
                              0.23, () {
                            Navigator.pop(context);
                          })),
                      Positioned(
                          left: MediaQuery.of(context).size.width * 0.6,
                          child: buttonblue(
                              context,
                              "Choose Seats",
                              Color(0xffffffff),
                              Color(0xff4A9DFF),
                              Color(0xff4A9DFF),
                              0.78,
                              0.37, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => seat_page()),
                            );
                          }))
                    ])));
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
        });
  }
}
