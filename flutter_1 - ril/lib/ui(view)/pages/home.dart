import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/bloc(modelview)/user_.dart';
import 'package:flutter_1/services/push_film.dart';
import 'package:flutter_1/services/services.dart';
import 'package:flutter_1/services/show_film.dart';
import 'package:flutter_1/ui(view)/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'changeprofile.dart';
import 'movie_detail.dart';
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
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Storage films = Storage();
  Future<void>? futureschedule;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    futureschedule = films.up_file_firebase();
  }

  void _onRefresh() async {
    setState(() {
      films = Storage();
    });
    _refreshController.refreshCompleted();
  }

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
    return SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        enablePullDown: true,
        child: FutureBuilder<void>(
            future: futureschedule,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                    child: Padding(
                        padding: customEdgeInsets(context),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
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
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              4.5),
                                  shrinkWrap: true,
                                  crossAxisCount: 4,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children:
                                      List.generate(category.length, (index) {
                                    return Column(
                                      children: [
                                        FittedBox(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              setState(() {
                                                if (_toggleButtonState(index)) {
                                                  category_choosen =
                                                      category[index];
                                                } else {
                                                  category_choosen = "";
                                                }
                                              });
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
                                                    0.01,
                                              ),
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
                                          ),
                                        ),
                                      ],
                                    );
                                  })),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
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
                                    top: MediaQuery.of(context).size.height *
                                        0.02),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: FutureBuilder(
                                  future: show_film("").getposts("film"),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData &&
                                          snapshot.data.isNotEmpty) {
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (snapshot.data[index]
                                                    .data()['category'] !=
                                                null) {
                                              if (snapshot.data[index]
                                                  .data()['category']
                                                  .contains(category_choosen)) {
                                                return Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                                  width: 150,
                                                  height: 350,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        snapshot.data[index]
                                                            .data()['link'],
                                                      ),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  child: OutlinedButton(
                                                    onPressed: () async {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  movie_detail(
                                                                      data: snapshot
                                                                          .data[
                                                                              index]
                                                                          .id)));
                                                    },
                                                    child: Text(''),
                                                  ),
                                                );
                                              } else {
                                                return SizedBox.shrink();
                                              }
                                            }
                                          },
                                        );
                                      } else {
                                        return Center(
                                            child: Text('No data available.'));
                                      }
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
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
                                      top: MediaQuery.of(context).size.height *
                                          0.02),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: FutureBuilder(
                                    future:
                                        show_film("").getposts("coming_soon"),
                                    builder: (BuildContext context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData &&
                                            snapshot.data.isNotEmpty) {
                                          return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (snapshot.data[index]
                                                      .data()['category'] !=
                                                  null) {
                                                if (snapshot.data[index]
                                                    .data()['category']
                                                    .contains(
                                                        category_choosen)) {
                                                  return Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                    width: 150,
                                                    height: 350,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            snapshot.data[index]
                                                                    .data()[
                                                                'link']),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox.shrink();
                                                }
                                              }
                                            },
                                          );
                                        } else {
                                          return Center(
                                              child:
                                                  Text('No data available.'));
                                        }
                                      } else {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.02),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage("asset/iklan.png"),
                                    fit: BoxFit.fill,
                                  )))
                            ])));
              } else {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(child: CircularProgressIndicator()),
                );
              }
            }));
  }

  @override
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

  Widget profile(context) {
    return Center(
        child: Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<user_, userstate>(
              listener: (context, state) {},
              builder: (context, state) {
                return Text(state.uservalue[2],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Exo',
                      fontWeight: FontWeight.bold,
                    ));
              }),
          BlocConsumer<user_, userstate>(
              listener: (context, state) {},
              builder: (context, state) {
                return Text(state.uservalue[0],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'Exo',
                      fontWeight: FontWeight.normal,
                    ));
              }),
          buttonblue(context, "Edit Profile", Color(0xff4A9DFF),
              Color(0xffffffff), Color(0xff4A9DFF), 0.03, 0.4, () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (change_context) => BlocProvider.value(
                    value: BlocProvider.of<user_>(context),
                    child: changeprofile())));
          }),
          buttonblue(context, "My Wallet", Color(0xff4A9DFF), Color(0xffffffff),
              Color(0xff4A9DFF), 0.07, 0.7, () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (change_context) => BlocProvider.value(
                    value: BlocProvider.of<user_>(context), child: wallet())));
          }),
          buttonblue(context, "Rate Flutix App", Color(0xff4A9DFF),
              Color(0xffffffff), Color(0xff4A9DFF), 0.05, 0.7, () {}),
          buttonblue(context, "Log Out", Color(0xff4A9DFF), Color(0xffffffff),
              Color(0xff4A9DFF), 0.05, 0.7, () async {
            BlocProvider.of<user_>(context).delete();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MyApp()),
                (Route<dynamic> route) => false);
          })
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context_) {
    final List<Widget> pages = [
      movies_home(context_),
      myticket(context_),
      profile(context_)
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
            onTap: (index) async {
              if (index != _index) {
                final userCubit = BlocProvider.of<user_>(context);
                List<String> _balance_name =
                    await UserService.getvalue(userCubit.state.uservalue[0]);
                setState(() {
                  userCubit.update_name(_balance_name[0]);
                  userCubit.update_balance(int.tryParse(_balance_name[1])!);
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
