import 'package:flutter/services.dart';
import 'package:flutter_1/changeprofile.dart';
import 'package:flutter_1/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/login.dart';
import 'package:flutter_1/movie_detail.dart';
import 'package:flutter_1/ticketdetail.dart';
import 'package:flutter_1/wallet.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => homeState();
}

List<String> category = [
  "Horror",
  "Adventure",
  "Fantasy",
  "Crime",
  "Sci-Fi",
  "Romance",
  "Comedy"
];

class homeState extends State<home> with SingleTickerProviderStateMixin {
  int _index = 0;

  List<bool> buttonStates = List.generate(7, (index) => false);
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

  Widget movies_home(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: customEdgeInsets(context),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  child: texts_exo(context, "Category", 16, 0, 0, 0, 0,
                      Colors.black, TextAlign.left, FontWeight.w800)),
              GridView.count(
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 4.5),
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(category.length, (index) {
                    return Column(
                      children: [
                        FittedBox(
                            child: OutlinedButton(
                          onPressed: () => _toggleButtonState(index),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.02,
                                MediaQuery.of(context).size.height * 0.01,
                                MediaQuery.of(context).size.width * 0.02,
                                MediaQuery.of(context).size.height * 0.01),
                            backgroundColor: buttonStates[index]
                                ? Color(0xFF4600DC)
                                : Colors.white,
                          ),
                          child: Text(
                            category[index],
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
                  })),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: texts_exo(context, "Now Playing", 20, 0, 0, 0, 0,
                      Colors.black, TextAlign.left, FontWeight.bold)),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: MediaQuery.of(context).size.height * 0.2,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => movie_detail()));
                              },
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              child: Text(
                                "never",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 115, 22, 22),
                                  fontSize: 15,
                                  fontFamily: 'Exo',
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                        );
                      })),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: texts_exo(context, "Coming Soon", 20, 0, 0, 0, 0,
                      Colors.black, TextAlign.left, FontWeight.bold)),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: MediaQuery.of(context).size.height * 0.2,
                          height: MediaQuery.of(context).size.height * 0.2,
                          color: Colors.grey,
                          child: Text(
                            "never",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 115, 22, 22),
                              fontSize: 15,
                              fontFamily: 'Exo',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      })),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                color: Colors.red,
              )
            ])));
  }

  Widget ticket_new(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
                bottom: MediaQuery.of(context).size.height * 0.02),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ticketdetail(previousPageName: "new")));
                          },
                          child: Row(children: [
                            Container(
                                color: Colors.black,
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.005,
                                    right: MediaQuery.of(context).size.width *
                                        0.03),
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.width * 0.2),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "The Movie Name",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      fontFamily: 'Exo',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "09:00",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontFamily: 'Exo',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "Hari, Tanggal bulan",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontFamily: 'Exo',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "The Cinema Name",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                      fontFamily: 'Exo',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ])
                          ])),
                    )
                  ]);
                })));
  }

  Widget ticket_old(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
                bottom: MediaQuery.of(context).size.height * 0.02),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ticketdetail(previousPageName: "Old")));
                            },
                            child: Row(children: [
                              Container(
                                  color: Colors.black,
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.005,
                                      right: MediaQuery.of(context).size.width *
                                          0.03),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.width * 0.2),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "The Movie Name",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        fontFamily: 'Exo',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "09:00",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        fontFamily: 'Exo',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      "Hari, Tanggal bulan",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        fontFamily: 'Exo',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      "The Cinema Name",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035,
                                        fontFamily: 'Exo',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ]),
                            ])))
                  ]);
                })));
  }

  Widget myticket(BuildContext context) {
    int _selectedTabIndex = 0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
          child: Container(
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                20,
                MediaQuery.of(context).size.width * 0.05,
                0),
            color: Colors.white,
            child: TabBar(
              indicator: BoxDecoration(color: Colors.white),
              indicatorPadding: EdgeInsets.zero,
              labelColor: Color(0xFF4600DC),
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 20,
                fontFamily: 'Exo',
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 18,
                fontFamily: 'Exo',
                fontWeight: FontWeight.bold,
              ),
              onTap: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              tabs: [
                Tab(
                  child: Text(
                    "NEW",
                  ),
                ),
                Tab(
                  child: Text(
                    "USED",
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [ticket_new(context), ticket_old(context)],
        ),
      ),
    );
  }

  Widget profile(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Username",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Exo',
                fontWeight: FontWeight.w200,
              )),
          Text("email@gmail.com",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Exo',
                fontWeight: FontWeight.w200,
              )),
          buttonblue(context, "Edit Profile", Color(0xff4A9DFF),
              Color(0xffffffff), Color(0xff4A9DFF), 0.03, 0.4, () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => changeprofile()));
          }),
          buttonblue(context, "My Wallet", Color(0xff4A9DFF), Color(0xffffffff),
              Color(0xff4A9DFF), 0.07, 0.7, () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => wallet()));
          }),
          buttonblue(context, "Rate Flutix App", Color(0xff4A9DFF),
              Color(0xffffffff), Color(0xff4A9DFF), 0.05, 0.7, () {}),
          buttonblue(context, "Log Out", Color(0xff4A9DFF), Color(0xffffffff),
              Color(0xff4A9DFF), 0.05, 0.7, () {
            go_to(context, login());
          })
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      movies_home(context),
      myticket(context),
      profile(context)
    ];
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          appBar: barflutix(context),
          body: pages[_index],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            unselectedItemColor: Color(0xff2E6FEC),
            selectedItemColor: Color(0xFF4600DC),
            currentIndex: _index,
            onTap: (index) {
              if (index != _index) {
                setState(() {
                  _index = index;
                });
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.abc,
                    size: MediaQuery.of(context).size.width * 0.08),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite,
                    size: MediaQuery.of(context).size.width * 0.08),
                label: "My Ticket",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_sharp,
                    size: MediaQuery.of(context).size.width * 0.08),
                label: "Profile",
              ),
            ],
          ),
        ));
  }
}
