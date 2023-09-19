import 'package:attendance/constant/strings.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

class CustomError {
 static Widget noData({msg="No Data found"}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
      child: SizedBox(
        height: 400,
        width: 400,
        child: EmptyWidget(
         
          image: null,
          packageImage: PackageImage.Image_3,
          title: 'Empty Data',
          subTitle: msg,
          titleTextStyle: TextStyle(
            fontSize: 22,
            color: Strings.primaryColor,
            fontWeight: FontWeight.w500,
          ),
          subtitleTextStyle: TextStyle(
            fontSize: 14,
            color: Color(0xffabb8d6),
          ),
        ),
      ),
    );
  }
}
