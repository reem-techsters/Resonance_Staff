import 'package:attendance/view/pages/applications/add_application.dart';
import 'package:attendance/view/pages/leaves/applied_leaves.dart';
import 'package:attendance/view/pages/outpass/apply_bulk_pass.dart';
import 'package:attendance/view/pages/outpass/apply_pass.dart';
import 'package:attendance/view/pages/approve_leaves/approve_leaves.dart';
import 'package:attendance/view/pages/employee_attendance.dart';
import 'package:attendance/view/pages/parent_concerns/parent_concern_screen.dart';
import 'package:attendance/view/pages/finances/payslip.dart';
import 'package:attendance/view/pages/regularisation/regularisation.dart';
import 'package:attendance/view/pages/my_attendence/my_attendance.dart';
import 'package:attendance/view/pages/dashboard/dashboard.dart';
import 'package:attendance/view/pages/applications/view_applications.dart';
import 'package:flutter/material.dart';
import '../view/pages/outpass/gate_pass.dart';
import '../view/pages/authenthication/login.dart';
import '../view/pages/leaves/apply_leaves.dart';
import '../view/pages/dashboard/profile.dart';
import '../view/pages/reporting_employee/reporting_employee.dart';

class GetRoutes {
  static String pageLogin = "/login";
  static String pageApplyLeaves = "/applyLeaves";
  // static String pageTodayAttendance = "/todayAttendance";
  static String pageAppliedLeaves = "/appliedLeaves";
  static String pageApproveLeaves = "/approveLeaves";
  static String pageMyAttendance = "/myAttendance";
  static String pageReportingEmployee = "/reportingEmployee";
  static String pagePaySlip = "/paySlip";
  static String pageEmployeeAttendance = "/employeeAttendance";
  static String pageRegularisation = "/regularisation";
  static String pageProfile = "/profile";
  static const String pageApplyPass = "/ApplyPass";
  static const String pageGatePass = "/gatePass";
  static const String pageBulkPass = "/bulkPass";
  static const String pageParentConcern = "/parentConcern";
  static const String pageaddApplication = "/addApplication";
  static const String pageviewApplications = "/viewApplications";
  // static const String pageoutsidework = "/outsidework";

  static Route<dynamic> generateRoutes(RouteSettings args,
      {BuildContext? context}) {
    final data = args.arguments; //To pass arguments.
    switch (args.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => Login());
      case "/login":
        return MaterialPageRoute(builder: (context) => Login());
      case "/profile":
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case "/applyLeaves":
        return MaterialPageRoute(builder: (context) => ApplyLeaves());
      // case "/todayAttendance":
      //   return MaterialPageRoute(builder: (context) => TodayAttendance());
      case "/appliedLeaves":
        return MaterialPageRoute(builder: (context) => AppliedLeaves());
      case "/approveLeaves":
        return MaterialPageRoute(builder: (context) => ApproveLeaves());
      // case "/outsidework":
      //   return MaterialPageRoute(builder: (context) => OutsideWorkScreen());
      case "/myAttendance":
        return MaterialPageRoute(builder: (context) => MyAttendance());
      case "/reportingEmployee":
        return MaterialPageRoute(builder: (context) => ReportingEmployee());
      // case "/employeeAttendance":
      //   return MaterialPageRoute(
      //       builder: (context) => EmployeeAttendance(userid: data));
      case "/regularisation":
        return MaterialPageRoute(builder: (context) => Regulaization());
      case "/ApplyPass":
        return MaterialPageRoute(builder: (context) => ApplyOutPass());
      case "/gatePass":
        return MaterialPageRoute(builder: (context) => GatePass());
      case "/bulkPass":
        return MaterialPageRoute(builder: (context) => ApplyBulkPass());
      case "/paySlip":
        return MaterialPageRoute(builder: (context) => PaySlip());
      case "/parentConcern":
        return MaterialPageRoute(builder: (context) => ParentConcernScreen());
      case "/addApplication":
        return MaterialPageRoute(builder: (context) => AddApplication());
      case "/viewApplications":
        return MaterialPageRoute(builder: (context) => ViewApplication());
      default:
        return MaterialPageRoute(
          builder: (context) => DashBoardScreen(),
          settings: args,
        );
    }
  }
}
