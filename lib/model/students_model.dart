// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    required this.status,
    required this.data,
    required this.message,
  });

  bool status;
  List<StudentList>? data;
  String message;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? []
            : List<StudentList>.from(
                json["data"].map((x) => StudentList.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message == null ? null : message,
      };
}

class StudentList {
  StudentList(
      {required this.userid,
      required this.name,
      required this.fatherName,
      required this.applicationnumber,
      required this.mobileNumber});

  String userid;
  String name;
  String fatherName;
  String mobileNumber;
  String applicationnumber;

  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
      userid: json["userid"] == null ? null : json["userid"],
      name: json["name"] == null ? null : json["name"],
      fatherName: json["fathername"] == null ? null : json["fathername"],
      mobileNumber: json["mobile1"] == null ? null : json["mobile1"],
      applicationnumber:
          json["applicationnumber"] == null ? null : json["applicationnumber"]);

  Map<String, dynamic> toJson() => {
        "userid": userid == null ? null : userid,
        "name": name == null ? null : name,
        "fathername": fatherName == null ? null : fatherName,
        "mobile1": mobileNumber == null ? null : mobileNumber,
        "applicationnumber":
            applicationnumber == null ? null : applicationnumber,
      };

  userFilterByCreationDate(String filter) {}
}
