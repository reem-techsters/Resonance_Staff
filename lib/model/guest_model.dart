class Guest {
  bool status;
  String message;

  Guest({
    required this.status,
    required this.message,
  });
}

class GuestModel {
  bool? status;
  List<Datum>? data;
  String? message;

  GuestModel({
    this.status,
    this.data,
    this.message,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json) => GuestModel(
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
  String? name;
  String? email;
  String? phone;
  String? password;
  String? otp;
  String? isDelete;
  DateTime? createdDate;

  Datum({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.otp,
    this.isDelete,
    this.createdDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        otp: json["otp"],
        isDelete: json["is_delete"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "otp": otp,
        "is_delete": isDelete,
        "created_date": createdDate?.toIso8601String(),
      };
}
