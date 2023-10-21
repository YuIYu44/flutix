import 'package:flutter/material.dart';
import 'package:flutter_1/SuccesTopUp.dart';
import 'package:flutter_1/functions.dart';

List<int> category = [
  25000,
  50000,
  100000,
  150000,
  200000,
  250000,
  400000,
  500000
];

class wallet extends StatefulWidget {
  const wallet({super.key});

  @override
  State<wallet> createState() => Mywallet();
}

class Mywallet extends State<wallet> {
  List<bool> buttonStates = List.generate(category.length, (index) => false);
  void _toggleButtonState(int index) {
    setState(() {
      for (int i = 0; i < buttonStates.length; i++) {
        if (i != index) {
          buttonStates[i] = false;
        }
      }
      buttonStates[index] = !buttonStates[index];
    });
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buttonblue(context, "Back", Color(0xff4A9DFF),
                      Color(0xffffffff), Color(0xff4A9DFF), 0, 0.25, () {
                    Navigator.pop(context);
                  }),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.07),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    width: MediaQuery.of(context).size.width * 0.97,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.02,
                            0,
                            MediaQuery.of(context).size.width * 0.02,
                            MediaQuery.of(context).size.height * 0.01),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Balance",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Exo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  child: Text(
                                    "Rp 30000",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontFamily: 'Exo',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                            ])),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.06),
                      child: Text(
                        "Top Up",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'Exo',
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03),
                      child: GridView.count(
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 4),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(category.length, (index) {
                            return Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.28,
                                    height: 40,
                                    child: OutlinedButton(
                                      onPressed: () =>
                                          _toggleButtonState(index),
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: buttonStates[index]
                                              ? Color.fromRGBO(
                                                  46, 111, 236, 0.5)
                                              : Colors.white,
                                          side: BorderSide(
                                              width: 1.0,
                                              color: Color(0xFF4600DC))),
                                      child: Text(
                                        category[index].toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: buttonStates[index]
                                              ? Colors.white
                                              : Color(0xFF4600DC),
                                          fontSize: 15,
                                          fontFamily: 'Exo',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )),
                              ],
                            );
                          }))),
                  Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.6,
                          MediaQuery.of(context).size.height * 0.1,
                          0,
                          0),
                      child: buttonblue(context, "Top Up", Color(0xffffffff),
                          Color(0xff4A9DFF), Color(0xff4A9DFF), 0, 0.4, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => succestopup()),
                        );
                      })),
                ],
              ),
            )));
  }
}
