import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/widget_state/selected_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultdropdownDrawerOption extends StatefulWidget {
  dynamic stateSelectedPage;
  bool visibility;
  dynamic iconList;
  String label;
  int padenum;

  DefaultdropdownDrawerOption(
      {super.key,
      required this.stateSelectedPage,
      required this.visibility,
      required this.padenum,
      required this.label,
      required this.iconList});

  @override
  State<DefaultdropdownDrawerOption> createState() =>
      _DefaultdropdownDrawerOptionState();
}

class _DefaultdropdownDrawerOptionState
    extends State<DefaultdropdownDrawerOption> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 10),
      child: Container(
        width: 265,
        height: 50,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
          color:
              widget.stateSelectedPage == widget.padenum ? Colors.white : null,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 37.0),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      widget.iconList,
                      width: MediaQuery.of(context).size.width / 13,
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    SizedBox(width: 24.0),
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 16,
                        color: widget.stateSelectedPage == widget.padenum
                            ? Colors.black
                            : Colors.white,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: widget.visibility == false
                  ? Icon(
                      Icons.arrow_left,
                      color: widget.stateSelectedPage == widget.padenum
                          ? Colors.black
                          : Colors.white,
                    )
                  : Icon(
                      Icons.arrow_drop_down,
                      color: widget.stateSelectedPage == widget.padenum
                          ? Colors.black
                          : Colors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubWidgets extends StatelessWidget {
  SubWidgets(
      {super.key,
      required this.visibility,
      required this.screen,
      required this.label});
  bool visibility;
  dynamic screen;
  String label;
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visibility,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 70, bottom: 20),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => screen,
              ));
            },
            child: Text(
              label,
              style: Styles.latoButtonText,
              textAlign: TextAlign.start,
            ),
          ),
        ));
  }
}
