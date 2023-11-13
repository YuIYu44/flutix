import 'package:flutter/material.dart';
import 'package:flutter_1/bloc(modelview)/user_.dart';
import 'package:flutter_1/services/services.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class changeprofile extends StatefulWidget {
  @override
  State<changeprofile> createState() => _changeprofile();
}

class _changeprofile extends State<changeprofile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
            appBar: barflutix(context),
            body: SingleChildScrollView(
              child: Padding(
                padding: customEdgeInsets(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        margin: EdgeInsets.only(top: 70),
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: textfields(context, emailController, false,
                            'Email', 0, 16, Colors.black, FontWeight.bold)),
                    Container(
                        margin: EdgeInsets.only(top: 40),
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: textfields(context, usernameController, false,
                            'Username', 0, 16, Colors.black, FontWeight.bold)),
                    Container(
                        margin: EdgeInsets.only(top: 40),
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: textfields(
                            context,
                            oldpasswordController,
                            true,
                            'Old Password',
                            0,
                            16,
                            Colors.black,
                            FontWeight.bold)),
                    Container(
                        margin: EdgeInsets.only(
                          top: 40,
                        ),
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: textfields(
                            context,
                            newpasswordController,
                            true,
                            'New Password',
                            0,
                            16,
                            Colors.black,
                            FontWeight.bold)),
                    Container(
                        margin: EdgeInsets.only(top: 30),
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: texts_exo(context, error, 16, 0, 0, 0.05, 0,
                            Colors.red, TextAlign.left, FontWeight.w800)),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1,
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: buttonblue(
                          context,
                          "Change",
                          Color(0xffffffff),
                          Color(0xff4A9DFF),
                          Color(0xff4A9DFF),
                          0,
                          0.3, () async {
                        String check = await AutServices.changePassword(
                            emailController.text,
                            usernameController.text,
                            oldpasswordController.text,
                            newpasswordController.text);
                        setState(() {
                          error = check;
                        });
                        if (error == "") {
                          BlocProvider.of<user_>(context)
                              .update_username_password([
                            emailController.text,
                            newpasswordController.text
                          ]);
                          BlocProvider.of<user_>(context)
                              .update_name(usernameController.text);
                          Navigator.pop(context);
                        }
                      }),
                    ),
                  ],
                ),
              ),
            )));
  }
}
