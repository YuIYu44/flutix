import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/services/films.dart';
import 'package:flutter_1/services/services.dart';
import 'package:flutter_1/ui(view)/main.dart';
import 'changeprofile.dart';
import 'movie_detail.dart';
import 'login.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';
import 'ticketdetail.dart';
import 'wallet.dart';

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
  String category_choosen = "";

  List<bool> buttonStates = List.generate(7, (index) => false);
  bool _toggleButtonState(int index) {
    setState(() {
      for (int i = 0; i < buttonStates.length; i++) {
        if (i != index) {
          buttonStates[i] = false;
        }
      }
      buttonStates[index] = !buttonStates[index];
    });
    return buttonStates[index];
  }

  Widget movies_home(BuildContext context) {
    Storage films = Storage();
    return FutureBuilder(
        future: films.up_file_firebase(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
                future: films.image(category_choosen),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SingleChildScrollView(
                        child: Padding(
                            padding: customEdgeInsets(context),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      child: texts_exo(
                                          context,
                                          "Category",
                                          16,
                                          0,
                                          0,
                                          0,
                                          0,
                                          Colors.black,
                                          TextAlign.left,
                                          FontWeight.w800)),
                                  GridView.count(
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              4.5),
                                      shrinkWrap: true,
                                      crossAxisCount: 4,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: List.generate(category.length,
                                          (index) {
                                        return Column(
                                          children: [
                                            FittedBox(
                                                child: OutlinedButton(
                                              onPressed: () {
                                                if (_toggleButtonState(index)) {
                                                  category_choosen =
                                                      category[index];
                                                } else {
                                                  category_choosen = "";
                                                }
                                              },
                                              style: OutlinedButton.styleFrom(
                                                padding: EdgeInsets.fromLTRB(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.01,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.01),
                                                backgroundColor:
                                                    buttonStates[index]
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
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      child: texts_exo(
                                          context,
                                          "Now Playing",
                                          20,
                                          0,
                                          0,
                                          0,
                                          0,
                                          Colors.black,
                                          TextAlign.left,
                                          FontWeight.bold)),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: films.link.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 0),
                                                width: 150,
                                                height: 350,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        films.Image_(index)),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                child: OutlinedButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                movie_detail(
                                                                    data: films
                                                                            .data[
                                                                        index])));
                                                  },
                                                  child: Text(''),
                                                ));
                                          })),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      child: texts_exo(
                                          context,
                                          "Coming Soon",
                                          20,
                                          0,
                                          0,
                                          0,
                                          0,
                                          Colors.black,
                                          TextAlign.left,
                                          FontWeight.bold)),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              films.link_coming_soon.length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              width: 150,
                                              height: 350,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      films.Image_coming_soon(
                                                          i)),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            );
                                          })),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.4,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage("asset/iklan.png"),
                                        fit: BoxFit.fill,
                                      )))
                                ])));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
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
            color: Colors.transparent,
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
                setState(() {});
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
          Text(getValue_class()[2],
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Exo',
                fontWeight: FontWeight.bold,
              )),
          Text(getValue_class()[0],
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'Exo',
                fontWeight: FontWeight.normal,
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
              Color(0xff4A9DFF), 0.05, 0.7, () async {
            await deletepref();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => login()));
          })
        ],
      ),
    ));
  }

  @override
  void initState() {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.ref().keepSynced(true);
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    List<String> _balance_name =
        await UserService.getvalue(getValue_class()[0]);
    user.update_balance(int.tryParse(_balance_name[1])!);
    user.update_name(_balance_name[0]);
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
                icon: Icon(CupertinoIcons.film,
                    size: MediaQuery.of(context).size.width * 0.08),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.ticket,
                    size: MediaQuery.of(context).size.width * 0.08),
                label: "My Ticket",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_alt_circle,
                    size: MediaQuery.of(context).size.width * 0.08),
                label: "Profile",
              ),
            ],
          ),
        ));
  }
}
