import 'package:flutter/material.dart';

import '../../constant/strings.dart';

class CustomAppBar extends StatelessWidget {
   String title;
  final Widget? widget;

  CustomAppBar(this.title, {super.key, this.widget});
  @override
  Widget build(BuildContext context) {
    double width = Strings.width(context);
    double height = Strings.width(context);
    return Container(
        width: double.infinity,
        height: height / 2.8,
        decoration: BoxDecoration(
            color: Strings.ColorBlue,
            borderRadius:
                BorderRadius.only(bottomLeft: Radius.elliptical(80, 60))),
        child: Column(children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: 
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: widget ?? GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child:
                      Icon(size: width / 10, color: Colors.white, Icons.menu)) ,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, top: 35,),
              child: Text(
                title,
                style: Styles.poppinsRegular
                    .copyWith(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ]));
  }
}
