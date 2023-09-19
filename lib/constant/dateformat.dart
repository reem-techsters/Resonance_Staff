import 'dart:developer';

import 'package:intl/intl.dart';

// String gateformatDateWithTime(String date) {
//   log("before --> $date");

//   // Assuming the input date format is "yyyy-M-d H:m"
//   DateFormat inputFormat = DateFormat('yyyy-M-d H:m');

//   // Parse the input date string using the specified format
//   DateTime parsedDate = inputFormat.parse(date);

//   // Format the parsed date as desired
//   DateFormat outputFormat =
//       DateFormat('yyyy-MM-dd HH:mm'); // Updated output format with time

//   String formattedDate = outputFormat.format(parsedDate);
//   log("after --> $formattedDate");

//   return formattedDate;
// }
String gateformatDateWithTime(String date) {
  log(date.toString());
  final List<String> parts = date.split('-');
  if (parts.length == 3) {
    final int year = int.parse(parts[0]);
    final int month = int.parse(parts[1]);
    final int day = int.parse(parts[2]);

    // Check if the month has a single digit and add a leading zero if needed.
    final String formattedMonth =
        month.toString().length == 1 ? '0$month' : month.toString();

    // Use String interpolation to format the date.
    final String formattedDate =
        '$year-${formattedMonth}-${day.toString().padLeft(2, '0')}';

    return formattedDate;
  }

  // Handle invalid date format here (e.g., return an error message or throw an exception).
  return ''; // Or throw an exception if desired.
}

String gateformatDateWithoutTime(String date) {
  // log("before --> $date");

  // Assuming the input date format is "yyyy-M-d"
  DateFormat inputFormat = DateFormat('yyyy-M-d');

  // Parse the input date string using the specified format
  DateTime parsedDate = inputFormat.parse(date);

  // Format the parsed date as desired
  DateFormat outputFormat =
      DateFormat('yyyy-MM-dd'); // Updated output format without time

  String formattedDate = outputFormat.format(parsedDate);

  // log("after --> $formattedDate");

  return formattedDate;
}
