import 'package:flutter/material.dart';
import 'checkout.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';

class seat_page extends StatefulWidget {
  const seat_page({super.key});

  @override
  State<seat_page> createState() => seat_pageState();
}

class seat_pageState extends State<seat_page> {
  List<List<bool>> buttonStates_seat =
      List.generate(6, (row) => List.generate(8, (col) => false));
  List<String> seat_alphabet = ["A", "B", "C", "D", "E", "F"];
  List<String> kind = ["Available", "Booked", "Selected"];
  List<Color> kind_color = [Colors.white, Colors.black, Color(0xFF4600DC)];
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
                                top: MediaQuery.of(context).size.height * 0.05),
                            width: MediaQuery.of(context).size.width * 0.94,
                            alignment: Alignment.topCenter,
                            child: Text("SCREEN",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Exo',
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.05,
                                left: MediaQuery.of(context).size.width * 0.09),
                            width: MediaQuery.of(context).size.width * 0.75,
                            alignment: Alignment.topCenter,
                            child: GridView.count(
                                childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
                                    (MediaQuery.of(context).size.height / 1.6),
                                shrinkWrap: true,
                                crossAxisCount: buttonStates_seat[1].length - 1,
                                physics: const NeverScrollableScrollPhysics(),
                                children: List.generate(
                                    (seat_alphabet.length - 1) *
                                        (buttonStates_seat[1].length - 1),
                                    (index) {
                                  return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                            height: sized(context) * 0.08,
                                            width: sized(context) * 0.08,
                                            child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor:
                                                      buttonStates_seat[
                                                                  (index / 7)
                                                                      .floor()]
                                                              [index % 7]
                                                          ? Color(0xFF4600DC)
                                                          : Colors.white,
                                                  side: BorderSide(
                                                      width: 1.0,
                                                      color: Color(0xFF4600DC)),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    buttonStates_seat[(index /
                                                                    7)
                                                                .floor()]
                                                            [index % 7] =
                                                        !buttonStates_seat[
                                                                (index / 7)
                                                                    .floor()]
                                                            [index % 7];
                                                  });
                                                },
                                                child: Text(""))),
                                        Text(
                                            seat_alphabet[(index / 7).floor()] +
                                                (index % 7 + 1).toString(),
                                            style: TextStyle(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1.0),
                                              fontSize: 12,
                                              fontFamily: 'Exo',
                                            )),
                                      ]);
                                })),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.07),
                              width: MediaQuery.of(context).size.width * 0.79,
                              alignment: Alignment.topCenter,
                              child: GridView.count(
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height),
                                  shrinkWrap: true,
                                  crossAxisCount: buttonStates_seat.last.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: List.generate(
                                      (buttonStates_seat.last.length), (index) {
                                    return Column(children: [
                                      SizedBox(
                                          height: sized(context) * 0.08,
                                          width: sized(context) * 0.08,
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor:
                                                    buttonStates_seat
                                                            .last[index]
                                                        ? Color(0xFF4600DC)
                                                        : Colors.white,
                                                side: BorderSide(
                                                    width: 1.0,
                                                    color: Color(0xFF4600DC)),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  buttonStates_seat
                                                          .last[index] =
                                                      !buttonStates_seat
                                                          .last[index];
                                                });
                                              },
                                              child: Text(""))),
                                      Text(
                                          seat_alphabet.last + index.toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Exo',
                                          )),
                                    ]);
                                  }))),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.93,
                              child: GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 3,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: List.generate(kind.length, (index) {
                                    return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: sized(context) * 0.08,
                                            width: sized(context) * 0.08,
                                            decoration: BoxDecoration(
                                                color: kind_color[index],
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0)),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Text(kind[index],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Exo',
                                                  ))),
                                        ]);
                                  })))
                        ]),
                    Positioned(
                        left: MediaQuery.of(context).size.width * 0.55,
                        child: buttonblue(
                            context,
                            "Payment",
                            Colors.white,
                            Color.fromRGBO(74, 157, 255, 1.0),
                            Color(0xff4A9DFF),
                            0.74,
                            0.32, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => checkout()),
                          );
                        })),
                  ],
                ))));
  }
}
