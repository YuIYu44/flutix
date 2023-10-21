import 'functions.dart';
import 'package:flutter/material.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController oldpasswordController = TextEditingController();
final TextEditingController newpasswordController = TextEditingController();

class changeprofile extends StatefulWidget {
  @override
  State<changeprofile> createState() => _changeprofile();
}

class _changeprofile extends State<changeprofile> {
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
              children: [
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
                        top: 70,
                        right: MediaQuery.of(context).size.width * 0.1),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: textfields(
                        context,
                        emailController,
                        false,
                        'Email',
                        MediaQuery.of(context).size.height * 0.58,
                        16,
                        Colors.black,
                        FontWeight.bold)),
                Container(
                    margin: EdgeInsets.only(
                        top: 40,
                        right: MediaQuery.of(context).size.width * 0.1),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: textfields(
                        context,
                        usernameController,
                        false,
                        'Username',
                        MediaQuery.of(context).size.height * 0.58,
                        16,
                        Colors.black,
                        FontWeight.bold)),
                Container(
                    margin: EdgeInsets.only(
                        top: 40,
                        right: MediaQuery.of(context).size.width * 0.1),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: textfields(
                        context,
                        oldpasswordController,
                        true,
                        'Old Password',
                        MediaQuery.of(context).size.height * 0.58,
                        16,
                        Colors.black,
                        FontWeight.bold)),
                Container(
                    margin: EdgeInsets.only(
                        top: 40,
                        right: MediaQuery.of(context).size.width * 0.1),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: textfields(
                        context,
                        newpasswordController,
                        true,
                        'New Password',
                        MediaQuery.of(context).size.height * 0.58,
                        16,
                        Colors.black,
                        FontWeight.bold)),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      right: MediaQuery.of(context).size.width * 0.55),
                  child: buttonblue(context, "Change", Color(0xffffffff),
                      Color(0xff4A9DFF), Color(0xff4A9DFF), 0, 0.25, () {
                    Navigator.pop(context);
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}
