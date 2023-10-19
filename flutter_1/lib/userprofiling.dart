import 'package:flutter_1/succespage.dart';
import 'functions.dart';
import 'package:flutter/material.dart';

List<String> category = [
  "Horror",
  "Adventure",
  "Fantasy",
  "Crime",
  "Sci-Fi",
  "Romance",
  "Comedy"
];

class userprofiling extends StatefulWidget {
  @override
  checklistspage createState() => checklistspage();
}

class checklistspage extends State<userprofiling> {
  List<bool> checklistStates = List.generate(7, (index) => false);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
            body: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.1,
                    MediaQuery.of(context).size.height * 0.15,
                    0,
                    0),
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Select Your Favorite Genre (2)",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Exo',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05),
                        child: GridView.count(
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 7),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(category.length, (index) {
                              return CheckboxListTile(
                                  activeColor: Color(0xFF4600DC),
                                  checkColor: Color(0xFF4600DC),
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(category[index],
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1.0),
                                        fontSize: 15,
                                        fontFamily: 'Exo',
                                      )),
                                  value: checklistStates[index],
                                  onChanged: (newValue) {
                                    if (checklistStates
                                                .where((element) =>
                                                    element == true)
                                                .length <
                                            2 ||
                                        checklistStates
                                            .asMap()
                                            .entries
                                            .where(
                                                (entry) => entry.value == true)
                                            .map((entry) => entry.key)
                                            .contains(index)) {
                                      setState(() {
                                        checklistStates[index] = newValue!;
                                      });
                                    }
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading);
                            })),
                      )
                    ],
                  ),
                  buttonblue(
                      context,
                      "Log Out",
                      Color.fromRGBO(74, 157, 255, 1.0),
                      Colors.white,
                      Color(0xff4A9DFF),
                      0.75,
                      0.3, () {
                    Navigator.pop(context);
                  }),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.5,
                    child: buttonblue(context, "Next", Colors.white,
                        Color(0xff4A9DFF), Color(0xff4A9DFF), 0.75, 0.3, () {
                      go_to(context, succespage());
                    }),
                  )
                ]))));
  }
}
