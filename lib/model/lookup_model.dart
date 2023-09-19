// To parse this JSON data, do
//
//     final lookUp = lookUpFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LookUp? lookUpFromJson(String str) => LookUp.fromJson(json.decode(str));

String lookUpToJson(LookUp data) => json.encode(data.toJson());

class LookUp {
  LookUp({
    required this.status,
    required this.branch,
    required this.section,
    required this.message,
  });

  bool? status;
  List<Branch?>? branch;
  List<Section?>? section;
  String? message;

  factory LookUp.fromJson(Map<String, dynamic> json) => LookUp(
        status: json["status"],
        branch: json["branch"] == null
            ? []
            : json["branch"] == null
                ? []
                : List<Branch?>.from(
                    json["branch"]!.map((x) => Branch.fromJson(x))),
        section: json["section"] == null
            ? []
            : json["section"] == null
                ? []
                : List<Section?>.from(
                    json["section"]!.map((x) => Section.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "branch": branch == null
            ? []
            : branch == null
                ? []
                : List<dynamic>.from(branch!.map((x) => x!.toJson())),
        "section": section == null
            ? []
            : section == null
                ? []
                : List<dynamic>.from(section!.map((x) => x!.toJson())),
        "message": message,
      };
}

class Branch {
  Branch({
    required this.branchid,
    required this.branchname,
    required this.latitude,
    required this.longitude,
    required this.branchAddress,
    required this.foundationtype,
    required this.campustype,
    required this.gendertype,
    required this.gatepassid,
  });

  String? branchid;
  String? branchname;
  String? latitude;
  String? longitude;
  String? branchAddress;
  String? foundationtype;
  String? campustype;
  String? gendertype;
  String? gatepassid;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        branchid: json["branchid"],
        branchname: json["branchname"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        branchAddress: json["branch_address"],
        foundationtype: json["foundationtype"],
        campustype: json["campustype"],
        gendertype: json["gendertype"],
        gatepassid: json["gatepassid"],
      );

  Map<String, dynamic> toJson() => {
        "branchid": branchid,
        "branchname": branchname,
        "latitude": latitude,
        "longitude": longitude,
        "branch_address": branchAddress,
        "foundationtype": foundationtype,
        "campustype": campustype,
        "gendertype": gendertype,
        "gatepassid": gatepassid,
      };

      @override
      toStrings(){
        return branchname!;

      }
}

class Section {
  Section({
    required this.sectionid,
    required this.sectionname,
  });

  String? sectionid;
  String? sectionname;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        sectionid: json["sectionid"],
        sectionname: json["sectionname"],
      );

  Map<String, dynamic> toJson() => {
        "sectionid": sectionid,
        "sectionname": sectionname,
      };
}
