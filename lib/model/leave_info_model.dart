// To parse this JSON data, do
//
//     final LeaveInfoModel = LeaveInfoModelFromJson(jsonString);


import 'dart:convert';

LeaveInfoModel leaveInfoModelFromJson(String str) => LeaveInfoModel.fromJson(json.decode(str));

String leaveInfoModelToJson(LeaveInfoModel data) => json.encode(data.toJson());

class LeaveInfoModel {
  LeaveInfoModel({
  required this.status,
  required this.data,
  required this.message,
  });

  bool status;
  Data data;
  String message;

  factory LeaveInfoModel.fromJson(Map<String, dynamic> json) => LeaveInfoModel(
        status: json["status"],
        data:  Data.fromJson(json["data"]),
        message: json["message"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
                "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
   required this.appliedleaves,
        required this.approveleaves,
        required this.leavebalance,
    });

    int appliedleaves;
    int approveleaves;
    String leavebalance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
         appliedleaves: json["appliedleaves"]??0,
        approveleaves: json["approveleaves"]??0,
        leavebalance: json["leavebalance"]??"0",
      );

  Map<String, dynamic> toJson() => {
        "appliedleaves": appliedleaves,
        "approveleaves":approveleaves,
        "leavebalance":leavebalance,
 
      };
}
