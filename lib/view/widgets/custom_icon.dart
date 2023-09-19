import 'package:flutter/material.dart';

import '../../constant/strings.dart';

class CustomIcon{



   static Icon iconCheck(double width) {
    return Icon(Icons.check_circle_sharp, color: Strings.primaryColor, size: width / 10);
  }
   static Icon iconWaiting(double width) {
    return Icon(Icons.pending_actions,color: Strings.primaryColor, size: width / 10);
  }

    
    
    static Widget iconClose(double width, double height) {
    return Container(
        width: width / 11,
        height: height / 25,
        decoration: BoxDecoration(
            color: Strings.colorRed, borderRadius: BorderRadius.circular(200)),
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: width / 14.5,
        ));
    
  }

}