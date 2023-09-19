import 'package:attendance/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Buttons {
  static Widget redButtonReason(String text, VoidCallback func) {
    return ElevatedButton(
        onPressed: () => func.call(),
        style: Styles.redButton,
        child: Text(text, style: Styles.latoButtonText));
  }

  static Widget iconButton(
      {Color? color,
      String? text,
      required VoidCallback func,
      required Icon icon}) {
    return ElevatedButton.icon(
        onPressed: () => func.call(),
        icon: icon,
        style: Styles.blueButton.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(color!)),
        label: FittedBox(child: Text(text!)));
  }

  static Widget blueButtonReason(String text, VoidCallback func) {
    return ElevatedButton(
        onPressed: () => func.call(),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Strings.primaryColor)),
        child: Text(text,
            style: TextStyle(
                fontFamily: 'Lato', fontSize: 16, color: Colors.white)));
  }

  static Widget blueButtonRounded(String text, VoidCallback func) {
    return ElevatedButton(
      onPressed: () => func.call(),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(210, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Strings.primaryColor,
      ),
      child: Text(text,
          style:
              TextStyle(fontFamily: 'Lato', fontSize: 16, color: Colors.white)),
    );
  }

  static Widget whiteButtonRouded(String text, VoidCallback func) {
    return GestureDetector(
      onTap: () => func.call(),
      child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(66, 224, 219, 219),
                  offset: Offset(0, 1),
                  blurRadius: 2.0)
            ],
            borderRadius: BorderRadius.circular(150),
          ),
          child: Stack(alignment: AlignmentDirectional.center, children: [
            Image.asset("assets/image/roundShadowButton.png"),
            Text(text,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                )),
          ])),
    );
  }
}
