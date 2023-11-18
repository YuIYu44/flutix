import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/services/services.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<int> rated = [0, 1, 2, 3, 4, 5];

class TicketDetail extends StatefulWidget {
  final String previousPage;
  final String id;
  TicketDetail({required this.previousPage, required this.id});

  @override
  _TicketDetailState createState() => _TicketDetailState(previousPage, id);
}

class _TicketDetailState extends State<TicketDetail> {
  final String previousPage;
  final String id;
  _TicketDetailState(this.previousPage, this.id);
  int selectedvalue = 0;

  @override
  Widget build(BuildContext context) {
    final bc = Barcode.dataMatrix();
    return FutureBuilder(
        future: historyService.gethistory_info(id),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              final svg = bc.toSvg(id, width: 150, height: 150);
              return WillPopScope(
                onWillPop: () {
                  return Future.value(false);
                },
                child: Scaffold(
                  appBar: barflutix(context),
                  body: Column(
                    children: [
                      Padding(
                          padding: customEdgeInsets(context),
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.65),
                              child: buttonblue(
                                  context,
                                  "Back",
                                  Color(0xff4A9DFF),
                                  Color(0xffffffff),
                                  Color(0xff4A9DFF),
                                  0,
                                  0.25, () {
                                Navigator.pop(context);
                              }),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.03,
                                  left:
                                      MediaQuery.of(context).size.width * 0.02),
                              width: 250,
                              height: 350,
                              child:
                                  Image.network(snapshot.data["link_picture"]),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 17),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: texts_exo(
                                  context,
                                  snapshot.data["name"],
                                  25,
                                  0,
                                  0,
                                  0,
                                  0,
                                  Colors.black,
                                  TextAlign.center,
                                  FontWeight.bold),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: texts_exo(
                                  context,
                                  snapshot.data["category"],
                                  18,
                                  0,
                                  0,
                                  0,
                                  0,
                                  Colors.black,
                                  TextAlign.center,
                                  FontWeight.normal),
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
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Center(
                                          child: DropdownButtonHideUnderline(
                                              child: ButtonTheme(
                                                  alignedDropdown: true,
                                                  child: DropdownButton(
                                                    value: snapshot
                                                            .data["rating"] ??
                                                        selectedvalue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedvalue =
                                                            value as int;
                                                        snapshot.data[
                                                                    "rating"] ==
                                                                null
                                                            ? historyService
                                                                .historyrating(
                                                                    value,
                                                                    id,
                                                                    snapshot.data[
                                                                        "link_name"])
                                                            : null;
                                                      });
                                                    },
                                                    icon: Icon(
                                                        Icons.arrow_downward),
                                                    items:
                                                        rated.map((int value) {
                                                      return DropdownMenuItem<
                                                          int>(
                                                        value: value,
                                                        child: Text(
                                                            value.toString()),
                                                      );
                                                    }).toList(),
                                                  )))))
                                ],
                              ),
                            Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.0),
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 130,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      texts_exo(
                                          context,
                                          snapshot.data["cinema"],
                                          20,
                                          0,
                                          0,
                                          0,
                                          0,
                                          Colors.black,
                                          TextAlign.left,
                                          FontWeight.w600),
                                      texts_exo(
                                          context,
                                          "Time  : ${snapshot.data["time"]}",
                                          18,
                                          0,
                                          0,
                                          0,
                                          0,
                                          Colors.black,
                                          TextAlign.left,
                                          FontWeight.normal),
                                      texts_exo(
                                          context,
                                          "Date   : ${snapshot.data["date"]}",
                                          18,
                                          0,
                                          0,
                                          0,
                                          0,
                                          Colors.black,
                                          TextAlign.left,
                                          FontWeight.normal),
                                      texts_exo(
                                          context,
                                          "Seat   : ${snapshot.data["seat"].toString().replaceFirst("[", "").replaceFirst("]", "")}",
                                          18,
                                          0,
                                          0,
                                          0,
                                          0,
                                          Colors.black,
                                          TextAlign.left,
                                          FontWeight.normal)
                                    ])),
                          ])),
                      if (previousPage == "new")
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.05,
                              left: MediaQuery.of(context).size.width * 0.58),
                          child: Container(
                            width: 150,
                            height: 150,
                            child:
                                SvgPicture.string(svg, fit: BoxFit.scaleDown),
                          ),
                        )
                    ],
                  ),
                ),
              );
            }
          }
          return Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
