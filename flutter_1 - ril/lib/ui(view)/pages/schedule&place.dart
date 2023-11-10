import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/bloc(modelview)/films.dart';
import 'package:flutter_1/services/show_film.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'seat_page.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';

class scheduleplace extends StatefulWidget {
  final String data;
  const scheduleplace({Key? key, required this.data}) : super(key: key);

  @override
  State<scheduleplace> createState() => schdp(data);
}

class schdp extends State<scheduleplace> {
  schdp(this.data);
  final data;
  int choose_date = 0;

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
      List.generate(7, (row) => List.generate(10, (col) => false));
  @override
  Widget build(BuildContext context) {
    _toggleButtonState(choose_date);
    return BlocProvider<films_>(
        create: (context) => films_(),
        child: WillPopScope(
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
                            FutureBuilder(
                                future: show_film(data).getposts_date(),
                                builder: (BuildContext context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData &&
                                        snapshot.data.isNotEmpty) {
                                      return Container(
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot.data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Column(children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.06,
                                                    margin: EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                    child: OutlinedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            _toggleButtonState(
                                                                index);
                                                            _toggleButtonState_place(
                                                                6, 9);
                                                          });
                                                        },
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              buttonStates_date[
                                                                      index]
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
                                                          snapshot
                                                              .data[index].id,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF4600DC),
                                                            fontSize: 15,
                                                            fontFamily: 'Exo',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )),
                                                  )
                                                ]);
                                              }));
                                    } else {
                                      return Center(
                                          child: Text('No data available.'));
                                    }
                                  } else {
                                    return Container(
                                      color: Colors.white,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  }
                                }),
                            Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
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
                            FutureBuilder(
                                future: show_film(data)
                                    .getposts_cinema(choose_date),
                                builder: (BuildContext context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData &&
                                        snapshot.data.isNotEmpty) {
                                      return Container(
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.12 *
                                              (snapshot.data.length),
                                          child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: snapshot.data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index_place) {
                                                return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data[index_place]
                                                            .id,
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
                                                          height:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                  0.06,
                                                          child: FutureBuilder(
                                                              future: show_film(data)
                                                                  .getposts_time(
                                                                      choose_date,
                                                                      index_place),
                                                              builder:
                                                                  (BuildContext context,
                                                                      snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .done) {
                                                                  if (snapshot
                                                                          .hasData &&
                                                                      snapshot
                                                                          .data
                                                                          .isNotEmpty) {
                                                                    return ListView.builder(
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemCount: snapshot.data.length,
                                                                        itemBuilder: (BuildContext context, int index_time) {
                                                                          return Column(
                                                                              children: [
                                                                                Container(
                                                                                  height: MediaQuery.of(context).size.height * 0.06,
                                                                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                                                  child: OutlinedButton(
                                                                                      onPressed: () {
                                                                                        final userCubit = BlocProvider.of<films_>(context);
                                                                                        userCubit.addfilms(data);

                                                                                        // userCubit.addschedule([
                                                                                        //   show.title_(choose_date)[0],
                                                                                        //   show.title_(choose_date)[index_place + 1][0],
                                                                                        //   show.title_(choose_date)[index_place + 1][1][index_time].toString()
                                                                                        // ]);
                                                                                        setState(() {
                                                                                          _toggleButtonState_place(index_place, index_time);
                                                                                        });
                                                                                      },
                                                                                      style: OutlinedButton.styleFrom(
                                                                                        backgroundColor: buttonStates_cinema[index_place][index_time] ? Color(0x404600DC) : Colors.white,
                                                                                        side: BorderSide(width: 1.0, color: Color(0xFF4600DC)),
                                                                                      ),
                                                                                      child: Text(
                                                                                        snapshot.data[index_time].id + ":00",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          color: buttonStates_cinema[index_place][index_time] ? Colors.white : Color(0xFF4600DC),
                                                                                          fontSize: 15,
                                                                                          fontFamily: 'Exo',
                                                                                          fontWeight: FontWeight.w400,
                                                                                        ),
                                                                                      )),
                                                                                )
                                                                              ]);
                                                                        });
                                                                  } else {
                                                                    return Center(
                                                                        child: Text(
                                                                            'No data available.'));
                                                                  }
                                                                } else {
                                                                  return Container(
                                                                    color: Colors
                                                                        .white,
                                                                    child: Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                  );
                                                                }
                                                              }))
                                                    ]);
                                              }));
                                    } else {
                                      return Center(
                                          child: Text('No data available.'));
                                    }
                                  } else {
                                    return Container(
                                      color: Colors.white,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  }
                                }),
                          ]))),
                  Positioned(
                      left: MediaQuery.of(context).size.width * 0.02,
                      child: buttonblue(context, "Back", Color(0xff4A9DFF),
                          Color(0xffffffff), Color(0xff4A9DFF), 0, 0.23, () {
                        Navigator.pop(context);
                      })),
                  BlocConsumer<films_, filmstate>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Positioned(
                            left: MediaQuery.of(context).size.width * 0.6,
                            child: buttonblue(
                                context,
                                "Choose Seats",
                                Color(0xffffffff),
                                Color(0xff4A9DFF),
                                Color(0xff4A9DFF),
                                0.78,
                                0.37, () async {
                              setState(() {
                                buttonStates_cinema[6][9] = false;
                              });
                              if (buttonStates_cinema
                                  .any((element) => element.contains(true))) {
                                final reload = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                            value: BlocProvider.of<films_>(
                                                context),
                                            child: seat_page())));

                                if (reload == false) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              scheduleplace(data: data)));
                                }
                              }
                            }));
                      })
                ]))));
  }
}
