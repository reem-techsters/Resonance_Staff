// To parse this JSON data, do
//
//     final GatePassModel = LeaveRequestModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GatePassModel gatePassModelFromJson(String str) =>
    GatePassModel.fromJson(json.decode(str));

// String gatePassModelToJson(GatePassModel data) =>
//     json.encode(data.toJson());

class GatePassModel {
  GatePassModel({
    required this.status,
    required this.data,
    //required this.message,
  });

  bool status;
  List<Data> data;

  factory GatePassModel.fromJson(Map<String, dynamic> json) => GatePassModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        // message: json["message"],
      );

  // Map<String, dynamic> toJson() => {
  //       "status": status,
  //       "data": List<dynamic>.from(data.map((x) => x.toJson()).toList()),
  //       "message": message,
  //     };
}

class Data {
  Data({
    required this.formrequestid,
    required this.approveddate,
    required this.approvedby,
    required this.status,
    required this.createdtimestamp,
    required this.updatedtimestamp,
    required this.name,
    required this.purpose,
    required this.toDate,
    required this.fromDate,
    required this.gaurdian,
    required this.indata,
    required this.updatedby,
    required this.applicationnumber,
  });

  String formrequestid;
  String approveddate;
  String approvedby;
  String status;
  String createdtimestamp;
  String updatedtimestamp;
  String name;
  String toDate;
  String fromDate;
  String purpose;
  String gaurdian;
  dynamic indata;
  dynamic updatedby;
  String applicationnumber;

  factory Data.fromJson(Map<String, dynamic> json) {
    // Map data = json.decode(json["data"].toString());

    return Data(
      formrequestid: json["form_request_id"] ?? '',
      approveddate: json["approved_date"] ?? '',
      approvedby: json["approved_by"] ?? '',
      status: json["status"] ?? '',
      createdtimestamp: json["created_timestamp"] ?? '',
      updatedtimestamp: json["updated_timestamp"] ?? '',
      name: json["name"] ?? '',
      //data: json["data"] ?? null.toString(),
      toDate: json["Todate"] ?? '',
      fromDate: json["FromDate"] ?? '',
      purpose: json["Purpose"] ?? '',
      gaurdian: json["accompanied_by"] ?? '',
      indata: json["indata"] ?? 'NULL',
      updatedby: json["updated_by"] ?? '',
      applicationnumber: json["applicationnumber"] ?? '',
    );
  }

  // @override
  // toString() {
  //   return "name: " + leaverequestid + ", address: " + reason;
  // }

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
