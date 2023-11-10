import 'package:flutter/material.dart';
import 'package:flutter_1/bloc(modelview)/films.dart';
import 'package:flutter_1/bloc(modelview)/user_.dart';
import 'package:flutter_1/services/services.dart';
import 'package:flutter_1/services/show_film.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'SuccesCheckout.dart';

class checkout extends StatefulWidget {
  const checkout({super.key});

  @override
  State<checkout> createState() => _checkoutState();
}

List<String> lists = [
  "Cinema",
  "Time",
  "Date",
  "Ticket",
  "Price",
  "Tax",
  "Total"
];
List<String> button = ["Check Out", "Home Page"];

class _checkoutState extends State<checkout> {
  int sufficient = 0;
  final user_cubit = user_();
  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<films_>(context);
    return FutureBuilder(
        future: show_film(userCubit.state.uservalue[0]).getposts_weblink(""),
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
                                              30,
                                              MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.02,
                                              0,
                                              MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.02),
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
                                                          userCubit
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
                                                    userCubit
                                                        .checkout_val()[6]
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Exo',
                                                    )))
                                          ])),
                                  FutureBuilder(
                                      future: user_cubit.loadUserValue(),
                                      builder: (BuildContext context, email) {
                                        if (email.connectionState ==
                                            ConnectionState.done) {
                                          return FutureBuilder(
                                              future: UserService.getvalue(
                                                  user_cubit
                                                      .state.uservalue[0]),
                                              builder: (BuildContext context,
                                                  balance) {
                                                if (balance.connectionState ==
                                                    ConnectionState.done) {
                                                  if (int.tryParse(
                                                          balance.data![1])! <
                                                      userCubit
                                                          .checkout_val()[6]) {
                                                    sufficient = 1;
                                                    return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "Can't Check Out\nYour Wallet Balance is Insufficient",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Exo',
                                                                color: Colors
                                                                    .red[800],
                                                              )),
                                                          Text(
                                                              "Wallet: ${balance.data![1]}",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'Exo',
                                                                color: Colors
                                                                    .red[800],
                                                              ))
                                                        ]);
                                                  }
                                                  sufficient = 0;
                                                }
                                                return Text("");
                                              });
                                        }
                                        return Text("");
                                      })
                                ],
                              ),
                              Positioned(
                                  left:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: buttonblue(
                                      context,
                                      button[sufficient],
                                      Color(0xffffffff),
                                      Color(0xff4A9DFF),
                                      Color(0xff4A9DFF),
                                      0.76,
                                      0.35, () {
                                    if (sufficient == 0) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                successcheckout()),
                                      );
                                    } else {
                                      userCubit.close();
                                      Navigator.popUntil(context,
                                          ModalRoute.withName('/home'));
                                    }
                                  })),
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
