import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class CustomDatePickerDialog {
  DateTime intialDate;
  CustomDatePickerDialog({required this.intialDate});

  Future<DateTime?> datePicker(
      BuildContext context,
      TextEditingController fromDateCtrl,
      TextEditingController toDateCtrl,
      VoidCallback fun) async {
    print("DATE PICKER FUNCTION CALLED");
    // DateTime selectedDate = DateTime.now();
    // print("NOW $selectedDate");

    final values = await showCalendarDatePicker2Dialog(
      context: context,

      config: CalendarDatePicker2WithActionButtonsConfig(
          // shouldCloseDialogAfterCancelTapped: true,
          closeDialogOnCancelTapped: true,

          // okButton: Buttons.blueButtonReason("Filter", () {
          //   Navigator.pop(context);
          //   fun.call();}),
          // cancelButton: Buttons.redButtonReason("Cancel", () { }),
          calendarType: CalendarDatePicker2Type.range),
      dialogSize: const Size(325, 400),

      initialValue: [intialDate],

      // borderRadius: BorderRadius.circular(15),
    );

    print(values);
    if (values != null) {
      List fromDateFormat = values[0].toString().split(" ")[0].split("-");
      List toDateFormat = values[1].toString().split(" ")[0].split("-");
      fromDateCtrl.text =
          fromDateFormat[2] + "/" + fromDateFormat[1] + "/" + fromDateFormat[0];
      toDateCtrl.text =
          toDateFormat[2] + "/" + toDateFormat[1] + "/" + toDateFormat[0];
      fun.call();
      print("${fromDateCtrl.text}---${toDateCtrl.text}");
    } else {
      return null;
    }
    return values[0];
    // ignore: avoid_prin
  }

  // Future<DateTime?> datePickerSinglee(BuildContext context,
  //     TextEditingController dateCtrl, VoidCallback fun) async {
  //   print("DATE PICKER FUNCTION CALLED");

  //   final values = await showCalendarDatePicker2Dialog(
  //     context: context,

  //     // onValueChanged: (val){
  //     //   fromDateCtrl = TextEditingController(text: val[0].toString());
  //     //   toDateCtrl = TextEditingController(text: val[1].toString());
  //     //   },
  //     config: CalendarDatePicker2WithActionButtonsConfig(
  //         firstDate: DateTime.now(),
  //         // lastDate: DateTime.utc(year),
  //         shouldCloseDialogAfterCancelTapped: true,

  //         // okButton: Buttons.blueButtonReason("Filter", () {
  //         //   Navigator.pop(context);
  //         //   fun.call();}),
  //         // cancelButton: Buttons.redButtonReason("Cancel", () { }),
  //         calendarType: CalendarDatePicker2Type.single),
  //     dialogSize: const Size(325, 400),

  //     initialValue: [intialDate],

  //     // borderRadius: BorderRadius.circular(15),
  //   );

  //   print(values);
  //   if (values != null) {
  //     List dateFormat = values[0].toString().split(" ")[0].split("-");
  //     dateCtrl.text = dateFormat[2] + "-" + dateFormat[1] + "-" + dateFormat[0];
  //     fun.call();
  //     print("${dateCtrl.text}---");
  //   } else {
  //     return null;
  //   }
  //   return values[0];
  //   // ignore: avoid_prin
  // }

  Future<DateTime?> datePickerSingle(BuildContext context,
      TextEditingController dateCtrl, VoidCallback fun) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 100000)),
    );

    if (selectedDate != null) {
      return selectedDate; // Return the selected date
    }

    return null;
  }
}
