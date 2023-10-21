import 'functions.dart';
import 'package:flutter/material.dart';

List<int> rated = [0, 1, 2, 3, 4, 5];

class ticketdetail extends StatefulWidget {
  final String previousPageName;
  ticketdetail({required this.previousPageName});
  @override
  State<ticketdetail> createState() =>
      _ticketdetailState(previousPage: previousPageName);
}

class _ticketdetailState extends State<ticketdetail> {
  String previousPage;
  _ticketdetailState({required this.previousPage});

  int selectedvalue = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: barflutix(context),
        body: Stack(
          children: [
            Padding(
                padding: customEdgeInsets(context),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.65),
                    child: buttonblue(context, "Back", Color(0xff4A9DFF),
                        Color(0xffffffff), Color(0xff4A9DFF), 0, 0.25, () {
                      Navigator.pop(context);
                    }),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03,
                          left: MediaQuery.of(context).size.width * 0.02),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.2,
                      color: Colors.black),
                  Container(
                    margin: EdgeInsets.only(top: 17),
                    width: MediaQuery.of(context).size.width * 0.73,
                    child: texts_exo(context, "Title", 20, 0, 0, 0, 0,
                        Colors.black, TextAlign.center, FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.73,
                    child: texts_exo(context, "Category", 18, 0, 0, 0, 0,
                        Colors.black, TextAlign.center, FontWeight.normal),
                  ),
                  if (previousPage != "new")
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Rated:",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "exo",
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.03),
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Center(
                                child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton(
                                          value: selectedvalue,
                                          onChanged: selectedvalue > 0
                                              ? null
                                              : (int? newValue) {
                                                  setState(() {
                                                    selectedvalue = newValue!;
                                                  });
                                                },
                                          icon: Icon(Icons.arrow_downward),
                                          items: rated.map((int value) {
                                            return DropdownMenuItem<int>(
                                              value: value,
                                              child: Text(value.toString()),
                                            );
                                          }).toList(),
                                        )))))
                      ],
                    ),
                  Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 130,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            texts_exo(context, "The cinema", 20, 0, 0, 0, 0,
                                Colors.black, TextAlign.left, FontWeight.w600),
                            texts_exo(context, "Time  :lalalal", 18, 0, 0, 0, 0,
                                Colors.black, TextAlign.left, FontWeight.w100),
                            texts_exo(context, "Date  :lalalal", 18, 0, 0, 0, 0,
                                Colors.black, TextAlign.left, FontWeight.w100),
                            texts_exo(context, "Seat  :lalalal", 18, 0, 0, 0, 0,
                                Colors.black, TextAlign.left, FontWeight.w100)
                          ])),
                ])),
            if (previousPage == "new")
              Positioned(
                top: MediaQuery.of(context).size.height * 0.7,
                left: MediaQuery.of(context).size.width * 0.5,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 90,
                    color: Colors.black),
              )
          ],
        ),
      ),
    );
  }
}
