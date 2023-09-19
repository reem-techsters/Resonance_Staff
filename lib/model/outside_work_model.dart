class OutsideWork {
  final bool? status;
  final List<OutsideWorkDatum>? data;
  final String? message;

  OutsideWork({
    this.status,
    this.data,
    this.message,
  });

  factory OutsideWork.fromJson(Map<String, dynamic> json) => OutsideWork(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<OutsideWorkDatum>.from(
                json["data"]!.map((x) => OutsideWorkDatum.fromJson(x))),
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

class OutsideWorkDatum {
  final String? absenttype;
  final String? absentregularised;
  final String? absentReason;
  final DateTime? date;
  final String? attendanceId;
  final String? employeeId;
  final String? name;

  OutsideWorkDatum({
    this.absenttype,
    this.absentregularised,
    this.absentReason,
    this.date,
    this.attendanceId,
    this.employeeId,
    this.name,
  });

  factory OutsideWorkDatum.fromJson(Map<String, dynamic> json) =>
      OutsideWorkDatum(
        absenttype: json["absenttype"],
        absentregularised: json["absentregularised"],
        absentReason: json["absentReason"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        attendanceId: json["attendance_id"],
        employeeId: json["employee_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "absenttype": absenttype,
        "absentregularised": absentregularised,
        "absentReason": absentReason,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "attendance_id": attendanceId,
        "employee_id": employeeId,
        "name": name,
      };
}
