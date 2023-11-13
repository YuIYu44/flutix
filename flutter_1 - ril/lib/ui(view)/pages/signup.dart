import 'package:flutter/material.dart';
import 'package:flutter_1/services/services.dart';
import 'login.dart';
import 'package:flutter_1/ui(view)/widget/widget.dart';

class signup extends StatefulWidget {
  State<signup> createState() => _signup();
}

class _signup extends State<signup> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Image.asset(
                  'asset/sign_up.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              texts_bubble(context, 'Sign Up', 40.0, 0, 0.03, 0, 0,
                  Color.fromRGBO(0, 0, 0, 1.0), TextAlign.center),
              Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04),
                  child: textfields(context, emailController, false, 'Email', 0,
                      14, Colors.black, FontWeight.bold)),
              Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: textfields(context, usernameController, false,
                      'Username', 0, 14, Colors.black, FontWeight.bold)),
              Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: textfields(context, passwordController, true,
                      'Password', 0, 14, Colors.black, FontWeight.bold)),
              texts_exo(context, error, 13, 0.05, 0.1, 0.15, 0.15, Colors.red,
                  TextAlign.left, FontWeight.bold),
              customButton(
                  context,
                  'Create An Account',
                  MediaQuery.of(context).size.width * 0.7,
                  45,
                  Color(0xff4A9DFF),
                  Color.fromRGBO(255, 255, 255, 1.0), () async {
                error = await AutServices.signUp(emailController.text,
                    passwordController.text, usernameController.text);
                setState(() {
                  if (error == "") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => login()));
                  }
                });
              }),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => login()));
                  },
                  child: Text(
                    "I already have an account",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1.0),
                      fontSize: 15,
                      fontFamily: 'Exo',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
