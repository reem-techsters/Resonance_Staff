// To parse this JSON data, do
//
//     final LeaveRequestModel = LeaveRequestModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LeaveRequestModel leaveRequestModelFromJson(String str) =>
    LeaveRequestModel.fromJson(json.decode(str));

//String leaveRequestModelToJson(LeaveRequestModel data) => json.encode(data.toJson());

class LeaveRequestModel {
  LeaveRequestModel({
    required this.status,
    required this.data,
    required this.message,
  });

  bool status;
  List<Data> data;
  String message;

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) =>
      LeaveRequestModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        message: json["message"],
      );
//
  // Map<String, dynamic> toJson() => {
  //       "status": status,
  //       "data": List<dynamic>.from(data.map((x) => x.toJson()).toList()),
  //       "message": message,
  //     };
}

class Data {
  Data(
      {required this.leaverequestid,
      required this.leavefrom,
      required this.leaveto,
      required this.days,
      required this.reason,
      required this.isapproved,
      required this.statusupdatedby,
      required this.userid,
      required this.name,
      required this.totalleaves,
      required this.fcm,
      required this.employeeid});

  String leaverequestid;
  String leavefrom;
  String leaveto;
  String days;
  String reason;
  dynamic isapproved;
  dynamic statusupdatedby;
  String userid;
  String fcm;
  String name;
  String totalleaves;
  String employeeid;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      leaverequestid: json["leaverequestid"] ?? null.toString(),
      leavefrom:
          json["leavefrom"] == null ? null.toString() : json["leavefrom"],
      leaveto: json["leaveto"] == null ? null.toString() : json["leaveto"],
      days: json["days"] == null ? null.toString() : json["days"],
      reason: json["reason"] == null ? null.toString() : json["reason"],
      isapproved:
          json["isapproved"] == null ? null.toString() : json["isapproved"],
      statusupdatedby: json["statusupdatedby"] == null
          ? null.toString()
          : json["statusupdatedby"],
      userid: json["userid"] ?? null.toString(),
      name: json["name"] == null ? null.toString() : json["name"],
      totalleaves:
          json["totalleaves"] == null ? null.toString() : json["totalleaves"],
      fcm: json["firebase"] == null ? null.toString() : json["firebase"],
      employeeid: json["employeeid"] ?? '');

  @override
  toString() {
    return "name: " + leaverequestid + ", address: " + reason;
  }

  // Map<String, dynamic> toJson() => {
  //       "leaverequestid": leaverequestid,
  //       "leavefrom":
  //           "${leavefrom.year.toString().padLeft(4, '0')}-${leavefrom.month.toString().padLeft(2, '0')}-${leavefrom.day.toString().padLeft(2, '0')}",
  //       "leaveto":
  //           "${leaveto.year.toString().padLeft(4, '0')}-${leaveto.month.toString().padLeft(2, '0')}-${leaveto.day.toString().padLeft(2, '0')}",
  //       "days": days,
  //       "reason": reason,
  //       "isapproved": isapproved,
  //       "statusupdatedby": statusupdatedby,
  //       "userid": userid,
  //       "name": name,
  //       "totalleaves": totalleaves,
  //     };
}
