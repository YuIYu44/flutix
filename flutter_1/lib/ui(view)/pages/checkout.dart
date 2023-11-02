import 'package:flutter/material.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';
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
  "Date",
  "Tax",
  "Total"
];
List<String> button = ["Check Out", "Home Page"];

class _checkoutState extends State<checkout> {
  int sufficient = 0;
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
                            Color(0xffffffff), Color(0xff4A9DFF), 0, 0.25, () {
                          Navigator.pop(context);
                        }),
                        Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.sizeOf(context).height * 0.07,
                                bottom:
                                    MediaQuery.sizeOf(context).height * 0.03),
                            child: Text(
                              "Check Your Ticket Here",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "exo"),
                            )),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.black,
                              width: sized(context) * 0.4,
                              height: sized(context) * 0.4,
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(
                                    30,
                                    MediaQuery.sizeOf(context).height * 0.02,
                                    0,
                                    MediaQuery.sizeOf(context).height * 0.02),
                                child: Text(
                                  "The Title of Movie",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "exo"),
                                )),
                          ],
                        ),
                        Divider(color: Colors.black),
                        Container(
                            margin: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.005),
                            width: MediaQuery.of(context).size.width * 0.92,
                            child: GridView.count(
                                childAspectRatio: 14,
                                shrinkWrap: true,
                                crossAxisCount: 1,
                                physics: const NeverScrollableScrollPhysics(),
                                children:
                                    List.generate(lists.length - 1, (index) {
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            child: Text(lists[index],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Exo',
                                                ))),
                                        Container(
                                            child: Text(lists[index],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Exo',
                                                )))
                                      ]);
                                }))),
                        Divider(color: Colors.black),
                        Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.02),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Text(lists.last,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Exo',
                                          ))),
                                  Container(
                                      child: Text(lists.last,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Exo',
                                          )))
                                ])),
                        Text(
                            "Can't Check Out\nYour Wallet Balance is Insufficient",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Exo',
                              color: (sufficient == 0)
                                  ? Colors.white
                                  : Colors.red[800],
                            ))
                      ],
                    ),
                    Positioned(
                        left: MediaQuery.of(context).size.width * 0.55,
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
                                  builder: (context) => successcheckout()),
                            );
                          } else {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/home'));
                          }
                        })),
                  ],
                ))));
  }
}
