import 'package:attendance/constant/strings.dart';
import 'package:flutter/material.dart';

class CustomRichText {
  static Widget customRichText(
    String text1,
    String text2,
     {
    TextAlign textAlign = TextAlign.left, colorindex,
  }) {
    return RichText(
        //softWrap:false,
        textAlign: textAlign,
        text: TextSpan(
            text: text1,
            style: Styles.poppinsRegular
                .copyWith(color: Colors.black, fontSize: 17),
            children: [
              TextSpan(
                text: text2,
                style: Styles.poppinsBold.copyWith(
                  fontSize: 18,
                  color: colorindex == 1 ? Colors.white : Colors.black,
                ),
              ),
            ]));
  }
}
