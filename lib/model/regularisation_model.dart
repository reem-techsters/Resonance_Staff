// import 'package:flutter/material.dart';
import 'dart:developer';
import 'my_attendance_model.dart';

class RegulaizationModel {
  RegulaizationModel({required this.toRegularise});
  List<ToRegularise> toRegularise = [];
}

class ToRegularise {
  String? employeeid;
  String? name;
  String? branchid;
  String? inOut;
  String? uniid;
  String? inOutTime;
  String? attendanceId;
  String? date;
  String? reason;
  String? lateLoginReason;
  String? earlyLoginReason;
  String? loginregularised;
  String? logoutregularised;
  String? isLatelogin;
  String? isEarlyLogout;

  ToRegularise({
    this.employeeid,
    this.name,
    this.branchid,
    this.inOut,
    this.uniid,
    this.inOutTime,
    this.attendanceId,
    this.date,
    this.reason,
    this.lateLoginReason,
    this.earlyLoginReason,
    this.loginregularised,
    this.logoutregularised,
    this.isLatelogin,
    this.isEarlyLogout,
  });

  List<ToRegularise> toRegulriseList = [];

  Future<List<ToRegularise>> toRegulariseList(
      List<MyAttendanceModel> json) async {
    List<ToRegularise> toRegulrise = [];

    for (var element in json) {
      await fun(element, toRegulrise);
      log(element.toString());
    }
    print("toRegulrise AFTER ${toRegulrise.length.toString()}");
    toRegulriseList = toRegulrise;
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
