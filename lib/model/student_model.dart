class StudentLeave {
  final bool? status;
  final List<StudentDatum>? data;
  final String? message;

  StudentLeave({
    this.status,
    this.data,
    this.message,
  });

  factory StudentLeave.fromJson(Map<String, dynamic> json) => StudentLeave(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<StudentDatum>.from(
                json["data"]!.map((x) => StudentDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class StudentDatum {
  final String? leaverequestid;
  final DateTime? leavefrom;
  final DateTime? leaveto;
  final String? days;
  final String? reason;
  final dynamic isapproved;
  final dynamic statusupdatedby;
  final String? userid;
  final String? name;
  final String? applicationnumber;
  final String? firebase;

  StudentDatum({
    this.leaverequestid,
    this.leavefrom,
    this.leaveto,
    this.days,
    this.reason,
    this.isapproved,
    this.statusupdatedby,
    this.userid,
    this.name,
    this.applicationnumber,
    this.firebase,
  });

  factory StudentDatum.fromJson(Map<String, dynamic> json) => StudentDatum(
        leaverequestid: json["leaverequestid"],
        leavefrom: json["leavefrom"] == null
            ? null
            : DateTime.parse(json["leavefrom"]),
        leaveto:
            json["leaveto"] == null ? null : DateTime.parse(json["leaveto"]),
        days: json["days"],
        reason: json["reason"],
        isapproved: json["isapproved"],
        statusupdatedby: json["statusupdatedby"],
        userid: json["userid"],
        name: json["name"],
        applicationnumber: json["applicationnumber"],
        firebase: json["firebase"],
      );

  Map<String, dynamic> toJson() => {
        "leaverequestid": leaverequestid,
        "leavefrom":
            "${leavefrom!.year.toString().padLeft(4, '0')}-${leavefrom!.month.toString().padLeft(2, '0')}-${leavefrom!.day.toString().padLeft(2, '0')}",
        "leaveto":
            "${leaveto!.year.toString().padLeft(4, '0')}-${leaveto!.month.toString().padLeft(2, '0')}-${leaveto!.day.toString().padLeft(2, '0')}",
        "days": days,
        "reason": reason,
        "isapproved": isapproved,
        "statusupdatedby": statusupdatedby,
        "userid": userid,
        "name": name,
        "applicationnumber": applicationnumber,
        "firebase": firebase,
      };
}
