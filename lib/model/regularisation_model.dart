import 'dart:developer';
import 'my_attendance_model.dart';

class RegulaizationModel {
  RegulaizationModel({required this.toRegularise});
  List<ToRegularise> toRegularise = [];
}

class ToRegularise {
  String employeeid;
  String name;
  String branchid;
  String inOut;
  String uniid;
  String inOutTime;
  String attendanceId;
  String date;
  String reason;
  String lateLoginReason;
  String earlyLoginReason;
  String loginregularised;
  String logoutregularised;
  String isLatelogin;
  String isEarlyLogout;

  ToRegularise({
    required this.employeeid,
    required this.name,
    required this.branchid,
    required this.inOut,
    required this.uniid,
    required this.inOutTime,
    required this.attendanceId,
    required this.date,
    required this.reason,
    required this.lateLoginReason,
    required this.earlyLoginReason,
    required this.loginregularised,
    required this.logoutregularised,
    required this.isLatelogin,
    required this.isEarlyLogout,
  });

  static Future<List<ToRegularise>> toRegulariseList(
      List<MyAttendanceModel> json) async {
    List<ToRegularise> toRegulrise = [];

    for (var element in json) {
      await fun(element, toRegulrise);
      log(element.toString());
    }
    print("toRegulrise AFTER ${toRegulrise.length.toString()}");
    return toRegulrise;
  }

  static Future fun(MyAttendanceModel element, List toRegulrise) async {
    element.data.forEach((item) {
      log('element --> ${item.toString()}');
      log('element name --> ${item.name.toString()}');
      log('toRegulrise --> ${toRegulrise.length.toString}');
      print("toRegulrise ${item.isLatelogin} ${item.loginregularised}");
      if (item.isLatelogin == "1" &&
          item.loginregularised.toString() == "null") {
        String inOut = "0";
        String inOutTime = item.loginTime.toString();
        toRegulrise.add(ToRegularise(
          employeeid: item.employeeid.toString(),
          name: item.name.toString(),
          branchid: item.branchid.toString(),
          uniid: item.uniid.toString(),
          inOutTime: inOutTime,
          inOut: inOut,
          attendanceId: item.attendanceId.toString(),
          date: item.date.toString(),
          reason: item.reason.toString(),
          lateLoginReason: item.lateLoginReason.toString(),
          earlyLoginReason: item.earlyLogoutReason.toString(),
          loginregularised: item.loginregularised.toString(),
          logoutregularised: item.logoutregularised.toString(),
          isLatelogin: item.isLatelogin.toString(),
          isEarlyLogout: item.isEarlyLogout.toString(),
        ));
      } else if (item.isEarlyLogout == "1" &&
          item.logoutregularised.toString() == "null") {
        String inOut = "1";
        String inOutTime = item.logoutTime.toString();
        toRegulrise.add(ToRegularise(
          employeeid: item.employeeid.toString(),
          name: item.name.toString(),
          branchid: item.branchid.toString(),
          uniid: item.uniid.toString(),
          inOutTime: inOutTime,
          inOut: inOut,
          attendanceId: item.attendanceId.toString(),
          date: item.date.toString(),
          reason: item.reason.toString(),
          lateLoginReason: item.lateLoginReason.toString(),
          earlyLoginReason: item.earlyLogoutReason.toString(),
          loginregularised: item.loginregularised.toString(),
          logoutregularised: item.logoutregularised.toString(),
          isLatelogin: item.isLatelogin.toString(),
          isEarlyLogout: item.isEarlyLogout.toString(),
        ));
      }
    });
  }
}
