import 'dart:developer';
import 'package:attendance/routes/getRoutes.dart';
import 'package:flutter/material.dart';

class Strings {
  static String url = "";
  static String welcome = "Welcome to Reso Bridge - Staff";

  static Color primaryColor = const Color.fromARGB(255, 76, 175, 147);
  static Color colorRed = const Color.fromRGBO(229, 76, 76, 1);
  static Color colorGreen = const Color.fromRGBO(193, 211, 38, 1);
  static Color bgColor = const Color.fromRGBO(230, 230, 230, 1);
  static Color bgColor_2 = const Color.fromRGBO(112, 112, 112, 1);
  // static Color primaryColor = Color(0xFFCD6155);
  // Color(0xFF34495E);
  // static Color primaryColor =Color.fromARGB(255, 200, 219, 81);
  // teal --> Color(0xFF48C9B0);
  // blue --> Color(0xFF5DADE2);
  // reddish --> Color(0xFFCD6155);

  // static Color ColorBlue = const Color.fromRGBO(25, 130, 198, 1);

  static String loginField = "Enter Mail/Phone Number";
  static String loginFieldInvalid = "Invalid input";
  static String login = "Login";
  static String lateLogin = "Late Login";
  static String logout = "Logout";
  static String earlyLogout = "Early Logout";
  static String gatePass = "Gate Pass";
  static String bulkPass = "Bulk Pass";

  static String baseUrl = "http://maidendropgroup.com/public/api/";
  // static String baseUrl = "https://test.maidendropgroup.com/public/api/";

  static List<Map<String, String>> drawerRoutes = [
    {"Dashboard": 'todayAttendance'},
    {"Leaves": GetRoutes.pageAppliedLeaves},
    {"Approve Leaves": GetRoutes.pageApproveLeaves},
    {"Reporting Employee": GetRoutes.pageReportingEmployee},
    {"My Attendance": GetRoutes.pageMyAttendance},
    {"Parent Concerns": GetRoutes.pageParentConcern},
    {"OutPass": GetRoutes.pageGatePass},
  ];
  List<String> drawerIconList = [
    'assets/icon/ic_todayattendence.png',
    'assets/icon/ic_leave.png',
    'assets/icon/ic_approveleave.png',
    'assets/icon/ic_reportingemployee.png',
    'assets/icon/ic_myattendance.png',
    'assets/icon/ic_parentconcern.png',
    'assets/icon/ic_outpass.png',
  ];
  List<String> drawerIconList2 = [
    'assets/icon/ic_regularisation.png',
    'assets/icon/ic_payslip.png',
    'assets/icon/ic_application.png',
    'assets/icon/ic_deleteaccount.png',
    'assets/icon/ic_logout.png'
  ];
  List<Map<String, String>> getDrawerRoute(String? userId) {
    log('userId --> ${userId.toString()}');
    if (userId == null) {
      print(drawerRoutes.toString());
      return drawerRoutes;
    }
    if (userId != "3" && userId != "16") {
      log('!= 3,16 working');
      print('not 3 --> ${drawerRoutes.toString()}');
      drawerRoutes.removeRange(6, drawerRoutes.length);
      return drawerRoutes;
    } else {
      log('3,16 working');
      return drawerRoutestonormal();
    }
  }

  List<Map<String, String>> drawerRoutestonormal() {
    log('drawer to normal');
    drawerRoutes = [];
    drawerRoutes.addAll([
      {"Dashboard": 'todayAttendance'},
      {"Leaves": GetRoutes.pageAppliedLeaves},
      {"Approve Leaves": GetRoutes.pageApproveLeaves},
      {"Reporting Employee": GetRoutes.pageReportingEmployee},
      {"My Attendance": GetRoutes.pageMyAttendance},
      {"Parent Concerns": GetRoutes.pageParentConcern},
      {"OutPass": GetRoutes.pageGatePass},
    ]);
    drawerRoutes = drawerRoutes.toSet().toList();
    print('drawer to normal ==> ${drawerRoutes.toString()}');
    return drawerRoutes;
  }

  static String applyLeave = "Apply Leaves";
  static String leaves = "Leaves";

  static String appliedLeave = "Applied Leaves";
  static String approve = "Approve";
  static String reject = "Reject";

  static String todayAttendance = "Today's Attendance";
  static String approveLeave = "Approve Leaves";
  static String myAttendance = "My Attendance";
  static String reportingEmp = "Reporting Employee";
  static String paySlip = "Pay Slip";
  static String employeeCode = "Emp Code";
  static String filler =
      "                                                                                " +
          "                                                                                ";
  static String leaveBl = "Leave Balance";
  static String leaveFrom = "Leave From";
  static String leaveTo = "Leave To";
  static String reason = "Reason";
  static String leaveStatus = "Leave Status";

  static String repoting = "Reporting To";

  static String passwordField = "Password";
  static String emptyInvalid = "Field cannnot be empty";

  static BoxDecoration roundBoxDecoration = BoxDecoration(
    boxShadow: const [
      BoxShadow(color: Colors.black26, offset: Offset(0, 1), blurRadius: 2.0)
    ],
    color: const Color.fromRGBO(230, 230, 230, 1),
    borderRadius: BorderRadius.circular(50.0),
  );

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}

class Styles {
  static TextStyle robotoTabStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
  );

  static TextStyle poppinsBold = TextStyle(
    fontSize: 22,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    // fontWeight: FontWeight.bold,
    color: Colors.white,
    fontStyle: FontStyle.normal,
  );

  static TextStyle poppinsRegular = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black);

  static TextStyle robotoTextFieldStyle = TextStyle(
      fontFamily: 'Roboto', fontSize: 18, fontWeight: FontWeight.bold);

  static TextStyle latoWelcomeStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Strings.bgColor_2,
  );

  static InputDecoration textInputBlue = InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Strings.primaryColor, width: 2)),
    //icon of text field
    //label text of field
  );

  static BoxDecoration textFieldDecoration = BoxDecoration(
    boxShadow: const [
      BoxShadow(color: Colors.black26, offset: Offset(0, 1), blurRadius: 2.0)
    ],
    color: Colors.white,
    borderRadius: BorderRadius.circular(40.0),
  );

  static ButtonStyle RoundButton = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      )),
      backgroundColor: MaterialStateProperty.all<Color>(Strings.primaryColor));

  static ButtonStyle redButton = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Strings.colorRed));

  static ButtonStyle blueButton = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Strings.primaryColor));
  static TextStyle latoButtonText =
      TextStyle(fontFamily: 'Lato', fontSize: 16, color: Colors.white);
}
