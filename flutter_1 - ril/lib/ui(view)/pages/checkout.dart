import 'package:flutter/material.dart';
import 'package:flutter_1/bloc(modelview)/films.dart';
import 'package:flutter_1/bloc(modelview)/user_.dart';
import 'package:flutter_1/services/services.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'SuccesCheckout.dart';

class checkout extends StatelessWidget {
  checkout({super.key});

  List<String> lists = [
    "Cinema",
    "Time",
    "Date",
    "Ticket",
    "Price",
    "Tax",
    "Total"
  ];
  List<String> button = ["Home Page", "Check Out"];

  int sufficient = 1;
  @override
  Widget build(BuildContext context) {
    final filmCubit = BlocProvider.of<films_>(context);
    final userCubit = BlocProvider.of<user_>(context);
    return FutureBuilder(
        future: show_film(filmCubit.state.uservalue[0]).getposts_weblink(""),
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
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buttonblue(
                                      context,
                                      "Back",
                                      Color(0xff4A9DFF),
                                      Color(0xffffffff),
                                      Color(0xff4A9DFF),
                                      0,
                                      0.25, () {
                                    Navigator.pop(context);
                                  }),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.07,
                                          bottom: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.03),
                                      child: Text(
                                        "Check Your Ticket Here",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "exo"),
                                      )),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: sized(context) * 0.4,
                                        height: sized(context) * 0.4,
                                        child: Image.network(
                                          snapshot.data["link"],
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.fromLTRB(
                                              10,
                                              MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.02,
                                              0,
                                              MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.02),
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.5,
                                          child: Text(
                                            snapshot.data["movie_name"],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "exo"),
                                          )),
                                    ],
                                  ),
                                  Divider(color: Colors.black),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.005),
                                      width: MediaQuery.of(context).size.width *
                                          0.92,
                                      child: GridView.count(
                                          childAspectRatio: 14,
                                          shrinkWrap: true,
                                          crossAxisCount: 1,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: List.generate(
                                              lists.length - 1, (index) {
                                            return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      child: Text(lists[index],
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily: 'Exo',
                                                          ))),
                                                  Container(
                                                      child: Text(
                                                          filmCubit
                                                                  .checkout_val()[
                                                              index],
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily: 'Exo',
                                                          )))
                                                ]);
                                          }))),
                                  Divider(color: Colors.black),
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
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                child: Text(lists.last,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Exo',
                                                    ))),
                                            Container(
                                                child: Text(
                                                    filmCubit
                                                        .checkout_val()[6]
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Exo',
                                                    )))
                                          ])),
                                  FutureBuilder(
                                      future: UserService.getvalue(
                                          userCubit.state.uservalue[0]),
                                      builder: (BuildContext context, balance) {
                                        if (balance.connectionState ==
                                            ConnectionState.done) {
                                          sufficient =
                                              int.tryParse(balance.data![1])! <
                                                      filmCubit
                                                          .checkout_val()[6]
                                                  ? 0
                                                  : 1;

                                          return Column(children: [
                                            if (sufficient == 0)
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "Can't Check Out\nYour Wallet Balance is Insufficient",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: 'Exo',
                                                          color:
                                                              Colors.red[800],
                                                        )),
                                                    Text(
                                                        "Wallet: ${balance.data![1]}",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily: 'Exo',
                                                          color:
                                                              Colors.red[800],
                                                        ))
                                                  ]),
                                            Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.5,
                                                    0,
                                                    0,
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.01),
                                                child: buttonblue(
                                                    context,
                                                    button[sufficient],
                                                    Color(0xffffffff),
                                                    Color(0xff4A9DFF),
                                                    Color(0xff4A9DFF),
                                                    0.07,
                                                    0.35, () async {
                                                  if (sufficient == 1) {
                                                    String dates =
                                                        "dates/${filmCubit.state.uservalue[1]}/cinema/${filmCubit.state.uservalue[2][0]}/time/${filmCubit.state.uservalue[2][1]}";
                                                    Map<String, dynamic>? book =
                                                        await show_film("")
                                                            .getposts_seat(filmCubit
                                                                    .state
                                                                    .uservalue[0] +
                                                                "/" +
                                                                dates);
                                                    List<dynamic> booked =
                                                        book!["booked"];

                                                    if (await show_film(filmCubit
                                                                .state
                                                                .uservalue[0])
                                                            .getposts_exist(
                                                                dates) ==
                                                        true) {
                                                      if (filmCubit.state
                                                              .uservalue[3]
                                                              .any((element) =>
                                                                  booked.contains(
                                                                      element)) ==
                                                          false) {
                                                        await show_film(filmCubit
                                                                .state
                                                                .uservalue[0])
                                                            .update_seat(
                                                                dates,
                                                                filmCubit.state
                                                                    .uservalue[3]);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        successcheckout()));
                                                        await historyService
                                                            .updatehistory(
                                                                userCubit.state
                                                                    .uservalue[0],
                                                                [
                                                              filmCubit.state
                                                                  .uservalue[0],
                                                              snapshot
                                                                  .data["link"],
                                                              snapshot.data[
                                                                  "movie_name"],
                                                              snapshot.data[
                                                                  "category"],
                                                              filmCubit.state
                                                                  .uservalue[1],
                                                              filmCubit.state
                                                                      .uservalue[
                                                                  2][0],
                                                              filmCubit.state
                                                                      .uservalue[
                                                                  2][1],
                                                              filmCubit.state
                                                                  .uservalue[3]
                                                            ]);
                                                        filmCubit.close();
                                                        List balance_val =
                                                            await UserService.getvalue(
                                                                BlocProvider.of<
                                                                            user_>(
                                                                        context)
                                                                    .state
                                                                    .uservalue[0]);

                                                        await AutServices.change(
                                                            userCubit.state
                                                                .uservalue[0],
                                                            userCubit.state
                                                                .uservalue[1],
                                                            'balance',
                                                            int.tryParse(
                                                                    balance_val[
                                                                        1])! -
                                                                filmCubit
                                                                    .checkout_val()[6]);
                                                      } else {
                                                        Navigator.of(context)
                                                            .popUntil(ModalRoute
                                                                .withName(
                                                                    '/seat'));
                                                      }
                                                    } else {
                                                      Navigator.of(context)
                                                          .popUntil(ModalRoute
                                                              .withName(
                                                                  '/schedule'));
                                                    }
                                                  } else {
                                                    filmCubit.close();
                                                    Navigator.of(context)
                                                        .popUntil((route) =>
                                                            route.isFirst);
                                                  }
                                                })),
                                          ]);
                                        }

                                        return Text("");
                                      }),
                                ],
                              ),
                            ],
                          ))));
            } else {
              return Center(child: Text('No data available.'));
            }
          } else {
            return Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
