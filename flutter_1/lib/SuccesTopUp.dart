import 'functions.dart';
import 'package:flutter/material.dart';

class succestopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          appBar: barflutix(context),
          body: Center(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15),
                    child: Image.asset("asset/wallet.png",
                        width: MediaQuery.of(context).size.width * 0.5)),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 0.73,
                  child: texts_exo(
                      context,
                      "Your wallet has been succesfully filled",
                      25,
                      0,
                      0,
                      0,
                      0,
                      Colors.black,
                      TextAlign.center,
                      FontWeight.w400),
                ),
                Container(
                    margin: EdgeInsets.only(top: 70),
                    child: customButton(
                        context,
                        'My Wallet',
                        0,
                        140,
                        45,
                        Color(0xff4A9DFF),
                        Color.fromRGBO(255, 255, 255, 1.0), () {
                      Navigator.pop(context);
                    })),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: customButton(
                        context,
                        'Home',
                        0,
                        140,
                        45,
                        Color.fromRGBO(255, 255, 255, 1.0),
                        Color(0xff4A9DFF), () {
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName('/home'));
                    })),
              ],
            ),
          ),
        ));
  }
}
