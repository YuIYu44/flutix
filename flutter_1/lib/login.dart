import 'package:flutter_1/signup.dart';
import 'package:flutter_1/succespage.dart';

import 'functions.dart';
import 'package:flutter/material.dart';

final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class login extends StatefulWidget {
  State<login> createState() => _login();
}

class _login extends State<login> {
  String errorText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              child: Image.asset(
                'asset/login.png',
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            texts_bubble(
                context,
                'Log In',
                30.0,
                MediaQuery.of(context).size.height * 0.3,
                0,
                0,
                0,
                Color.fromRGBO(0, 0, 0, 1.0),
                TextAlign.center),
            textfields(
                context,
                usernameController,
                false,
                'Email',
                MediaQuery.of(context).size.height * 0.45,
                14,
                Colors.black,
                FontWeight.bold),
            textfields(
                context,
                passwordController,
                true,
                'Password',
                MediaQuery.of(context).size.height * 0.55,
                14,
                Colors.black,
                FontWeight.bold),
            texts_exo(
                context,
                errorText,
                13,
                MediaQuery.of(context).size.height * 0.67,
                0,
                MediaQuery.of(context).size.width * 0.16,
                0,
                Colors.red,
                TextAlign.left,
                FontWeight.bold),
            customButton(
                context,
                'Log In',
                MediaQuery.of(context).size.height * 0.82,
                MediaQuery.of(context).size.width * 0.7,
                45,
                Color(0xff4A9DFF),
                Color.fromRGBO(255, 255, 255, 1.0), () {
              // if (login succesfull){
              // go_to(context, userprofilling());}
              //else{
              setState(() {
                errorText = "Account Not Found!";
              });
              go_to(context, succespage());
            }),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.06,
              left: MediaQuery.of(context).size.width * 0.15,
              child: GestureDetector(
                onTap: () {
                  go_to(context, signup());
                },
                child: Text(
                  "Don't have account yet?",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1.0),
                    fontSize: 14,
                    fontFamily: 'Exo',
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
