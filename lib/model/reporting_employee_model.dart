// To parse this JSON data, do
//
//     final ReporingEmployeeModel = ReporingEmployeeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ReportingEmployeeModel reportingEmployeeModelFromJson(String str) => ReportingEmployeeModel.fromJson(json.decode(str));

String reportingEmployeeModelToJson(ReportingEmployeeModel data) => json.encode(data.toJson());

class ReportingEmployeeModel {
  ReportingEmployeeModel({
    required this.status,
    required this.data,
    required this.message,
  });

  bool status;
  List<Data> data;
  String message;


  

  factory ReportingEmployeeModel.fromJson(Map<String, dynamic> json) => ReportingEmployeeModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Data {
  Data({
    required this.mobile,
    required this.leavespermonth,
    required this.package,
    required this.employeeid,
    required this.username,
    required this.roleid,
    required this.branchid,
    required this.userid,
    required this.name,
    required this.rolename,
  });

  String mobile;
  String leavespermonth;
  String package;
  String employeeid;
  String username;
  String roleid;
  String branchid;
  String userid;
  String name;
  String rolename;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mobile: json["mobile"] ?? null.toString(),
        leavespermonth: json["leavespermonth"] ?? null.toString(),
        package: json["package"] ?? null.toString(),
        employeeid: json["employeeid"] ?? null.toString(),
        username: json["username"] ?? null.toString(),
        roleid: json["roleid"] ?? null.toString(),
        branchid: json["branchid"] ?? null.toString(),
        userid: json["userid"] ?? null.toString(),
        name: json["name"] ?? null.toString(),
        rolename: json["rolename"] ?? null.toString(),
      );





  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "leavespermonth": leavespermonth,
        "package": package,
        "employeeid": employeeid,
        "username": username,
        "roleid": roleid,
        "branchid": branchid,
        "userid": userid,
        "name": name,
        "rolename": rolename,
      };
}
