import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoudedTextFiled {
  static Widget roundedTextFile([Function? validator]) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      Image.asset(
        "assets/image/textField.png",
        width: 300,
      ),
      TextFormField(
        // ignore: prefer_const_constructors
        validator: (val) {
          validator;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(100, 0, 0, 0),
          border: InputBorder.none,
          hintText: 'Username',
        ),

        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 12,
        ),

        //controller: userInput
      ),
    ]);
  }

  static Widget otpTextFile([Function? validator]) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      Image.asset(
        "assets/icon/Group 1841@2x.png",
        width: 300,
      ),
      TextFormField(
        // ignore: prefer_const_constructors
        validator: (val) {
          validator;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(100, 0, 0, 0),
          border: InputBorder.none,
          hintText: 'Username',
        ),

        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 12,
        ),

        //controller: userInput
      ),
    ]);
  }
}
