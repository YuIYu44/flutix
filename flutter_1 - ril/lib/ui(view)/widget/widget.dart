import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customButton(
  BuildContext context,
  String text,
  double width,
  double height,
  Color buttonColor,
  Color textColor,
  VoidCallback onPressed,
) {
  return Container(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontFamily: 'Exo',
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

Widget buttonblue(BuildContext context, texts, color, bgcolor, border, top,
    widths, VoidCallback do_) {
  return Container(
    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * top),
    width: MediaQuery.of(context).size.width * widths,
    height: MediaQuery.of(context).size.height * 0.055,
    child: ElevatedButton(
      onPressed: do_,
      style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor, side: BorderSide(width: 1, color: border)),
      child: Text(
        texts,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontFamily: 'Exo',
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget texts_bubble(
  BuildContext context,
  String text,
  double fontsize,
  double top,
  double bottom,
  double left,
  double right,
  Color textColor,
  TextAlign align,
) {
  return Container(
    margin: EdgeInsets.fromLTRB(
        MediaQuery.sizeOf(context).width * left,
        MediaQuery.sizeOf(context).height * top,
        MediaQuery.sizeOf(context).width * right,
        MediaQuery.sizeOf(context).height * bottom),
    child: Text(
      text,
      textAlign: align,
      style: GoogleFonts.rubikBubbles(
        fontSize: fontsize,
        color: textColor,
      ),
    ),
  );
}

Widget texts_exo(
  BuildContext context,
  String text,
  double fontsize,
  double top,
  double bottom,
  double left,
  double right,
  Color textColor,
  TextAlign align,
  FontWeight fontweight,
) {
  return Container(
    margin: EdgeInsets.fromLTRB(
        MediaQuery.sizeOf(context).width * left,
        MediaQuery.sizeOf(context).height * top,
        MediaQuery.sizeOf(context).width * right,
        MediaQuery.sizeOf(context).height * bottom),
    child: Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: textColor,
        fontSize: fontsize,
        fontFamily: 'Exo',
        fontWeight: fontweight,
      ),
    ),
  );
}

Widget textfields(
  BuildContext context,
  TextEditingController controllers,
  bool obscure,
  String text,
  double top,
  double fontsize,
  Color textColor,
  FontWeight fontweight,
) {
  return Container(
    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, top,
        MediaQuery.of(context).size.width * 0.05, 0),
    child: TextField(
      controller: controllers,
      obscureText: obscure,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(top: 10, left: 10),
        labelText: text,
        labelStyle: TextStyle(
          color: textColor,
          fontSize: fontsize + 3,
          fontFamily: 'Exo',
          fontWeight: fontweight,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      style: TextStyle(
        color: textColor,
        fontSize: fontsize,
        fontFamily: 'Exo',
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

PreferredSizeWidget barflutix(context) {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: MediaQuery.of(context).size.height * 0.1,
    elevation: 0.1,
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('FLU',
            style: GoogleFonts.rubikBubbles(
              fontSize: 40.0,
              color: Color(0xff2E6FEC),
            )),
        Text(
          'TIX',
          style: GoogleFonts.rubikBubbles(
            fontSize: 40.0,
            color: Color.fromRGBO(70, 0, 220, 1.0),
          ),
        ),
      ],
    ),
  );
}

EdgeInsets customEdgeInsets(BuildContext context) {
  return EdgeInsets.fromLTRB(
      MediaQuery.of(context).size.width * 0.03,
      MediaQuery.of(context).size.height * 0.02,
      MediaQuery.of(context).size.width * 0.03,
      MediaQuery.of(context).size.height * 0.02);
}

sized(BuildContext context) {
  if (MediaQuery.of(context).size.width >
      (MediaQuery.of(context).size.height / 2)) {
    return MediaQuery.of(context).size.width * 0.85;
  }
  if (MediaQuery.of(context).size.width < MediaQuery.of(context).size.height) {
    return MediaQuery.of(context).size.width;
  }

  return MediaQuery.of(context).size.height;
}
