// To parse this JSON data, do
//
//     final AppliedLeaveModel = AppliedLeaveModelFromJson(jsonString);

//import 'package:meta/meta.dart';
import 'dart:convert';

AppliedLeaveModel appliedLeaveModelFromJson(String str) {
  print("json.decode(str) ${json.decode(str)}");

  return AppliedLeaveModel.fromJson(json.decode(str));
}

String appliedLeaveModelToJson(AppliedLeaveModel data) =>
    json.encode(data.toJson());

class AppliedLeaveModel {
  AppliedLeaveModel({
    required this.status,
    required this.data,
    required this.message,
  });

  bool status;
  List<Data> data;
  String message;

  factory AppliedLeaveModel.fromJson(Map<String, dynamic> json) =>
      AppliedLeaveModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x)))
                .toList(),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson()).toList()),
        "message": message,
      };
}

class Data {
  Data({
    required this.leaverequestid,
    required this.leavefrom,
    required this.leaveto,
    required this.days,
    required this.reason,
    required this.isapproved,
    required this.statusupdatedby,
    required this.userid,
  });

  String leaverequestid;
  String leavefrom;
  String leaveto;
  String days;
  String reason;
  String isapproved;
  String statusupdatedby;
  String userid;

  factory Data.fromJson(Map<String, dynamic> json) {
    print("DATA " + json.toString());
    return Data(
      leaverequestid: json["leaverequestid"] ?? null.toString(),
      leavefrom: json["leavefrom"] ?? null.toString(),
      leaveto: json["leaveto"] ?? null.toString(),
      days: json["days"] ?? null.toString(),
      reason: json["reason"],
      isapproved: json["isapproved"] ?? null.toString(),
      statusupdatedby: json["statusupdatedby"] ?? null.toString(),
      userid: json["userid"] ?? null.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "leaverequestid": leaverequestid,
        "leavefrom": leavefrom ?? null.toString(),
        "leaveto": leaveto ?? null.toString(),
        "days": days,
        "reason": reason,
        "isapproved": isapproved,
        "statusupdatedby": statusupdatedby,
        "userid": userid,
      };
}
