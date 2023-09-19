// To parse required this JSON data, do
//
//     final MyAttendanceModel = MyAttendanceModelFromJson(jsonString);

import 'dart:convert';

MyAttendanceModel myAttendanceFromJson(String str) =>
    MyAttendanceModel.fromJson(json.decode(str));

String myAttendanceToJson(MyAttendanceModel data) => json.encode(data.toJson());

class MyAttendanceModel {
  MyAttendanceModel({
    required this.status,
    required this.data,
    required this.message,
  });

  bool status;
  List<Data> data;
  String message;

  factory MyAttendanceModel.fromJson(Map<String, dynamic> json) =>
      MyAttendanceModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        message: json["message"] ?? null.toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Data {
  Data({
    required this.userid,
    required this.employeeid,
    required this.designation,
    required this.name,
    required this.branchid,
    required this.mobile,
    required this.email,
    required this.package,
    required this.otp,
    required this.status,
    required this.uniid,
    required this.leavespermonth,
    required this.totalleaves,
    required this.isMarketing,
    required this.dataLoginTime,
    required this.dataLogoutTime,
    required this.reportPerson,
    required this.attendanceId,
    required this.date,
    required this.employeeId,
    required this.loginTime,
    required this.logoutTime,
    required this.reason,
    required this.loginregularised,
    required this.logoutregularised,
    required this.isLatelogin,
    required this.lateLoginReason,
    required this.isEarlyLogout,
    required this.earlyLogoutReason,
    required this.absentregularised,
    required this.absenttype,
    required this.absentReason,
  });

  String userid;
  String employeeid;
  String designation;
  String name;
  String branchid;
  String mobile;
  String email;
  String package;
  String otp;
  String status;
  String uniid;
  String leavespermonth;
  String totalleaves;
  String isMarketing;
  String dataLoginTime;
  String dataLogoutTime;
  String reportPerson;
  String attendanceId;
  String date;
  String employeeId;
  String loginTime;
  String logoutTime;
  String reason;
  String loginregularised;
  String logoutregularised;
  String isLatelogin;
  String lateLoginReason;
  String isEarlyLogout;
  String earlyLogoutReason;
  dynamic absentregularised;
  dynamic absenttype;
  dynamic absentReason;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userid: json["userid"] ?? null ?? null.toString(),
        employeeid: json["employeeid"] ?? null ?? null.toString(),
        designation: json["designation"] ?? null ?? null.toString(),
        name: json["name"] ?? null.toString(),
        branchid: json["branchid"] ?? null.toString(),
        mobile: json["mobile"] ?? null.toString(),
        email: json["email"] ?? null.toString(),
        package: json["package"] ?? null.toString(),
        otp: json["otp"] ?? null.toString(),
        status: json["status"] ?? null.toString(),
        uniid: json["uniid"] ?? null.toString(),
        leavespermonth: json["leavespermonth"] ?? null.toString(),
        totalleaves: json["totalleaves"] ?? null.toString(),
        isMarketing: json["is_marketing"] ?? null.toString(),
        dataLoginTime: json["login_time"] ?? null.toString(),
        dataLogoutTime: json["logout_time"] ?? null.toString(),
        reportPerson: json["report_person"] ?? null.toString(),
        attendanceId: json["attendance_id"] ?? null.toString(),
        date: json["date"] ?? null.toString(),
        employeeId: json["employee_id"] ?? null.toString(),
        loginTime: json["loginTime"] ?? null.toString(),
        logoutTime: json["logoutTime"] ?? null.toString(),
        reason: json["reason"] ?? null.toString(),
        loginregularised: json["loginregularised"] ?? null.toString(),
        logoutregularised: json["logoutregularised"] ?? null.toString(),
        isLatelogin: json["isLatelogin"] ?? null.toString(),
        lateLoginReason: json["lateLoginReason"] ?? null.toString(),
        isEarlyLogout: json["isEarlyLogout"] ?? null.toString(),
        earlyLogoutReason: json["earlyLogoutReason"] ?? null.toString(),
        absentregularised: json["absentregularised"],
        absenttype: json["absenttype"],
        absentReason: json["absentReason"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "employeeid": employeeid,
        "designation": designation,
        "name": name,
        "branchid": branchid,
        "mobile": mobile,
        "email": email,
        "package": package,
        "otp": otp,
        "status": status,
        "uniid": uniid,
        "leavespermonth": leavespermonth,
        "totalleaves": totalleaves,
        "is_marketing": isMarketing,
        "login_time": dataLoginTime,
        "logout_time": dataLogoutTime,
        "report_person": reportPerson,
        "attendance_id": attendanceId,
        "date": date,
        "employee_id": employeeId,
        "loginTime": loginTime,
        "logoutTime": logoutTime,
        "reason": reason,
        "loginregularised": loginregularised,
        "logoutregularised": logoutregularised,
        "isLatelogin": isLatelogin,
        "lateLoginReason": lateLoginReason,
        "isEarlyLogout": isEarlyLogout,
        "earlyLogoutReason": earlyLogoutReason,
        "absentregularised": absentregularised,
        "absenttype": absenttype,
        "absentReason": absentReason,
      };
}
