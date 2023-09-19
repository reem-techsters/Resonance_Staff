class Parent {
  bool? status;
  List<Datum>? data;
  String? message;

  Parent({
    this.status,
    this.data,
    this.message,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  String? id;
  String? concernId;
  String? studentId;
  String? category;
  String? subCategory;
  String? details;
  String? image;
  String? fromTime;
  String? toTime;
  String? status;
  dynamic feedback;
  dynamic feedbackreason;
  String? createdDate;
  String? categoryname;
  String? subcategoryname;

  Datum({
    this.id,
    this.concernId,
    this.studentId,
    this.category,
    this.subCategory,
    this.details,
    this.image,
    this.fromTime,
    this.toTime,
    this.status,
    this.feedback,
    this.feedbackreason,
    this.createdDate,
    this.categoryname,
    this.subcategoryname,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        concernId: json["concern_id"],
        studentId: json["student_id"],
        category: json["category"],
        subCategory: json["sub_category"],
        details: json["details"],
        image: json["image"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        status: json["status"],
        feedback: json["feedback"],
        feedbackreason: json["feedbackreason"],
        createdDate: json["created_date"],
        categoryname: json["categoryname"],
        subcategoryname: json["subcategoryname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "concern_id": concernId,
        "student_id": studentId,
        "category": category,
        "sub_category": subCategory,
        "details": details,
        "image": image,
        "from_time": fromTime,
        "to_time": toTime,
        "status": status,
        "feedback": feedback,
        "feedbackreason": feedbackreason,
        "created_date": createdDate,
        "categoryname": categoryname,
        "subcategoryname": subcategoryname,
      };
}

//------------------------------------------Mark as in Progress (Pending --> In Progress)
class InProgressStatus {
  bool? status;
  String? message;

  InProgressStatus({
    this.status,
    this.message,
  });

  factory InProgressStatus.fromJson(Map<String, dynamic> json) =>
      InProgressStatus(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

//--------------------------------------------------*Sending status (In Progress --> Resolved)
class ResolvedStatus {
  bool? status;
  String? message;

  ResolvedStatus({
    this.status,
    this.message,
  });

  factory ResolvedStatus.fromJson(Map<String, dynamic> json) => ResolvedStatus(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
