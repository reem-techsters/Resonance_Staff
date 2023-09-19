// To parse required this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class UserModel {
  UserModel({
    required this.status,
    required this.data,
    required this.message,
  });

  @HiveField(0)
  bool status;

  @HiveField(1)
  List<Data> data;

  @HiveField(2)
  String message;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print("rolleid");
    print(json["data"][0]["roleid"]);

    return UserModel(
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<Data>.from(json["data"].map((x) => Data.fromJson(x))).toList(),
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())).toList(),
        "message": message,
      };
}

class Data {
  Data({
    required this.userid,
    required this.roleid,
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
    required this.loginTime,
    required this.logoutTime,
    required this.reportPerson,
    required this.firebase,
    required this.joiningdate,
  });

  String userid;
  String roleid;
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
  String loginTime;
  String logoutTime;
  String reportPerson;
  String firebase;
  dynamic joiningdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userid: json["userid"] ?? null.toString(),
        roleid: json["roleid"] ?? "",
        employeeid: json["employeeid"] ?? null.toString(),
        designation: json["designation"] ?? null.toString(),
        name: json["name"] ?? null.toString(),
        branchid: json["branchid"] ?? null.toString(),
        mobile: json["mobile"] ?? null.toString(),
        email: json["email"] ?? null.toString(),
        package: json["package"] ?? null.toString(),
        otp: json["otp"] ?? null.toString(),
        status: json["status"] ?? null.toString(),
        uniid: json["uniid"] ?? null.toString(),
        leavespermonth: json["leavespermonth"] ?? null.toString(),
        totalleaves: json["totalleaves"] ?? "0",
        isMarketing: json["is_marketing"] ?? null.toString(),
        loginTime: json["login_time"] ?? null.toString(),
        logoutTime: json["logout_time"] ?? null.toString(),
        reportPerson: json["report_person"] ?? null.toString(),
        firebase: json["firebase"].toString() ?? "",
        joiningdate: json["joiningdate"] ?? null.toString(),
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
        "login_time": loginTime,
        "logout_time": logoutTime,
        "report_person": reportPerson,
        "firebase": firebase,
        "joiningdate": joiningdate,
      };
}
