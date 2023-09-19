// To parse this JSON data, do
//
//     final biometric = biometricFromJson(jsonString);

import 'dart:convert';

Biometric biometricFromJson(String str) => Biometric.fromJson(json.decode(str));

String biometricToJson(Biometric data) => json.encode(data.toJson());

class Biometric {
  bool? status;
  BioData? data;
  String? message;

  Biometric({
    this.status,
    this.data,
    this.message,
  });

  factory Biometric.fromJson(Map<String, dynamic> json) => Biometric(
        status: json["status"],
        data: json["data"] == null ? null : BioData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class BioData {
  String? type1;
  String? type2;

  BioData({
    this.type1,
    this.type2,
  });

  factory BioData.fromJson(Map<String, dynamic> json) => BioData(
        type1: json["type1"],
        type2: json["type2"],
      );

  Map<String, dynamic> toJson() => {
        "type1": type1,
        "type2": type2,
      };
}
