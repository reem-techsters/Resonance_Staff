class PaySlipModel {
  final bool? status;
  final List<PaySlipDatum>? data;
  final String? message;

  PaySlipModel({
    this.status,
    this.data,
    this.message,
  });

  factory PaySlipModel.fromJson(Map<String, dynamic> json) => PaySlipModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<PaySlipDatum>.from(
                json["data"]!.map((x) => PaySlipDatum.fromJson(x))),
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

class PaySlipDatum {
  final String? userid;
  final String? employeeid;
  final String? designation;
  final String? name;
  final String? branchid;
  final String? mobile;
  final String? email;
  final dynamic profileImage;
  final dynamic joiningdate;
  final dynamic gender;
  final dynamic pancard;
  final String? package;
  final String? otp;
  final String? status;
  final String? uniid;
  final String? leavespermonth;
  final String? totalleaves;
  final String? isMarketing;
  final String? loginTime;
  final String? logoutTime;
  final String? reportPerson;
  final String? firebase;
  final dynamic rfid;
  final String? active;
  final String? isDelete;
  final String? salarypaymentid;
  final String? ctc;
  final String? monthly;
  final String? daily;
  final String? basic;
  final String? houserentalallowance;
  final String? transportallowance;
  final String? childreneducationallowance;
  final String? medicalallowance;
  final String? specialallowance;
  final String? providentfundEmployer;
  final String? employeesstateinsuranceEmployer;
  final String? providentfundEmployee;
  final String? employeesstateinsuranceEmployee;
  final String? pt;
  final String? tds;
  final String? bonus;
  final String? penalty;
  final String? gross;
  final String? net;
  final dynamic comments;
  final DateTime? salarydate;
  final String? totalbusinessdays;
  final String? paiddays;
  final String? unpaiddays;
  final String? uniqueid;
  final String? username;
  final String? password;
  final String? roleid;
  final String? rolename;
  final String? candelete;
  final String? roleHierarchy;
  final String? payslip;

  PaySlipDatum({
    this.userid,
    this.employeeid,
    this.designation,
    this.name,
    this.branchid,
    this.mobile,
    this.email,
    this.profileImage,
    this.joiningdate,
    this.gender,
    this.pancard,
    this.package,
    this.otp,
    this.status,
    this.uniid,
    this.leavespermonth,
    this.totalleaves,
    this.isMarketing,
    this.loginTime,
    this.logoutTime,
    this.reportPerson,
    this.firebase,
    this.rfid,
    this.active,
    this.isDelete,
    this.salarypaymentid,
    this.ctc,
    this.monthly,
    this.daily,
    this.basic,
    this.houserentalallowance,
    this.transportallowance,
    this.childreneducationallowance,
    this.medicalallowance,
    this.specialallowance,
    this.providentfundEmployer,
    this.employeesstateinsuranceEmployer,
    this.providentfundEmployee,
    this.employeesstateinsuranceEmployee,
    this.pt,
    this.tds,
    this.bonus,
    this.penalty,
    this.gross,
    this.net,
    this.comments,
    this.salarydate,
    this.totalbusinessdays,
    this.paiddays,
    this.unpaiddays,
    this.uniqueid,
    this.username,
    this.password,
    this.roleid,
    this.rolename,
    this.candelete,
    this.roleHierarchy,
    this.payslip,
  });

  factory PaySlipDatum.fromJson(Map<String, dynamic> json) => PaySlipDatum(
        userid: json["userid"],
        employeeid: json["employeeid"],
        designation: json["designation"],
        name: json["name"],
        branchid: json["branchid"],
        mobile: json["mobile"],
        email: json["email"],
        profileImage: json["profile_image"],
        joiningdate: json["joiningdate"],
        gender: json["gender"],
        pancard: json["pancard"],
        package: json["package"],
        otp: json["otp"],
        status: json["status"],
        uniid: json["uniid"],
        leavespermonth: json["leavespermonth"],
        totalleaves: json["totalleaves"],
        isMarketing: json["is_marketing"],
        loginTime: json["login_time"],
        logoutTime: json["logout_time"],
        reportPerson: json["report_person"],
        firebase: json["firebase"],
        rfid: json["rfid"],
        active: json["active"],
        isDelete: json["is_delete"],
        salarypaymentid: json["salarypaymentid"],
        ctc: json["ctc"],
        monthly: json["monthly"],
        daily: json["daily"],
        basic: json["basic"],
        houserentalallowance: json["houserentalallowance"],
        transportallowance: json["transportallowance"],
        childreneducationallowance: json["childreneducationallowance"],
        medicalallowance: json["medicalallowance"],
        specialallowance: json["specialallowance"],
        providentfundEmployer: json["providentfund_employer"],
        employeesstateinsuranceEmployer:
            json["employeesstateinsurance_employer"],
        providentfundEmployee: json["providentfund_employee"],
        employeesstateinsuranceEmployee:
            json["employeesstateinsurance_employee"],
        pt: json["pt"],
        tds: json["tds"],
        bonus: json["bonus"],
        penalty: json["penalty"],
        gross: json["gross"],
        net: json["net"],
        comments: json["comments"],
        salarydate: json["salarydate"] == null
            ? null
            : DateTime.parse(json["salarydate"]),
        totalbusinessdays: json["totalbusinessdays"],
        paiddays: json["paiddays"],
        unpaiddays: json["unpaiddays"],
        uniqueid: json["uniqueid"],
        username: json["username"],
        password: json["password"],
        roleid: json["roleid"],
        rolename: json["rolename"],
        candelete: json["candelete"],
        roleHierarchy: json["role_hierarchy"],
        payslip: json["payslip"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "employeeid": employeeid,
        "designation": designation,
        "name": name,
        "branchid": branchid,
        "mobile": mobile,
        "email": email,
        "profile_image": profileImage,
        "joiningdate": joiningdate,
        "gender": gender,
        "pancard": pancard,
        "package": package,
        "otp": otp,
        "status": status,
        "uniid": uniid,
        "leavespermonth": leavespermonth,
        "totalleaves": totalleaves,
        "is_marketing": isMarketing,
        "login_time": loginTime,
        "logout_time": logoutTime,
        "report_person": reportPerson,
        "firebase": firebase,
        "rfid": rfid,
        "active": active,
        "is_delete": isDelete,
        "salarypaymentid": salarypaymentid,
        "ctc": ctc,
        "monthly": monthly,
        "daily": daily,
        "basic": basic,
        "houserentalallowance": houserentalallowance,
        "transportallowance": transportallowance,
        "childreneducationallowance": childreneducationallowance,
        "medicalallowance": medicalallowance,
        "specialallowance": specialallowance,
        "providentfund_employer": providentfundEmployer,
        "employeesstateinsurance_employer": employeesstateinsuranceEmployer,
        "providentfund_employee": providentfundEmployee,
        "employeesstateinsurance_employee": employeesstateinsuranceEmployee,
        "pt": pt,
        "tds": tds,
        "bonus": bonus,
        "penalty": penalty,
        "gross": gross,
        "net": net,
        "comments": comments,
        "salarydate":
            "${salarydate!.year.toString().padLeft(4, '0')}-${salarydate!.month.toString().padLeft(2, '0')}-${salarydate!.day.toString().padLeft(2, '0')}",
        "totalbusinessdays": totalbusinessdays,
        "paiddays": paiddays,
        "unpaiddays": unpaiddays,
        "uniqueid": uniqueid,
        "username": username,
        "password": password,
        "roleid": roleid,
        "rolename": rolename,
        "candelete": candelete,
        "role_hierarchy": roleHierarchy,
        "payslip": payslip,
      };
}
