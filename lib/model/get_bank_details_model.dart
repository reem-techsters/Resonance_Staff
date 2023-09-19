// To parse this JSON data, do
//
//     final bankDetails = bankDetailsFromJson(jsonString);

import 'dart:convert';

BankDetails bankDetailsFromJson(String str) => BankDetails.fromJson(json.decode(str));

String bankDetailsToJson(BankDetails data) => json.encode(data.toJson());

class BankDetails {
    bool? status;
    List<Datum>? data;
    String? message;

    BankDetails({
        this.status,
        this.data,
        this.message,
    });

    factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    String? id;
    String? employeeid;
    String? bankName;
    String? branchName;
    String? accountNo;
    String? ifscCode;
    String? isActive;
    dynamic createdBy;
    DateTime? createdAt;

    Datum({
        this.id,
        this.employeeid,
        this.bankName,
        this.branchName,
        this.accountNo,
        this.ifscCode,
        this.isActive,
        this.createdBy,
        this.createdAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        employeeid: json["employeeid"],
        bankName: json["bank_name"],
        branchName: json["branch_name"],
        accountNo: json["account_no"],
        ifscCode: json["ifsc_code"],
        isActive: json["is_active"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employeeid": employeeid,
        "bank_name": bankName,
        "branch_name": branchName,
        "account_no": accountNo,
        "ifsc_code": ifscCode,
        "is_active": isActive,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
    };
}
