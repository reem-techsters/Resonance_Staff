import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/guest_model.dart';
import 'package:attendance/model/user_model.dart';
import 'package:attendance/utils/remove_leave_request.dart';
import 'package:attendance/utils/send_notification.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/remove_gate_pass.dart';

class Api {
  static String login = "${Strings.baseUrl}login";
}

class LoginApi extends GetxController {
  final String url = "${Strings.baseUrl}login?phone=";
  // http://maidendropgroup.com/public/api/login?phone=9154902064
  String phone;
  final String successKey = "status";
  final bool successVal = true;

  LoginApi({
    required this.phone,
  });
  var successmsg = ''.obs;
  Future<http.Response> callApi(BuildContext context) async {
    try {
      CustomDialog.showDialogTransperent(context);
      http.Response res = await http.get(Uri.parse(url + phone));
      print("login api called ${res.statusCode}");
      log('response otp ----> ${res.body}');

      if (res.statusCode == 201) {
        Navigator.pop(context);
        update();
        dynamic body = jsonDecode(res.body);
        update();
        if (body["status"]) {
          successmsg.value = body['message'];
          CustomSnackBar.atBottom(title: "OTP", body: "Otp is sent");
        } else {
          CustomSnackBar.atBottom(
              title: "OTP", body: "Otp cannot be sent", status: false);
        }
        update();
        log('sucmsg -- > $successmsg');
        update();
      }
      return res;
    } catch (e) {
      Navigator.pop(context);
      print("OTP error$e");
      throw "";
    }
  }
}

// class CheckLoginApi {
//   final String url = "${Strings.baseUrl}check_login";
//   final String paramUsername = "username";
//   String valUsername;
//   final String paramPassword = "password";
//   String valPassword;
//   final String successKey = "status";
//   final bool successVal = true;

//   CheckLoginApi({
//     required this.valUsername,
//     required this.valPassword,
//   });

//   Future<http.Response> callApi() async {
//     var data = {paramUsername: valUsername, paramPassword: valPassword};
//     try {
//       http.Response res = await http.get(Uri.parse(url), body: (data));
//       print("login api called ${res.statusCode}");
//       return res;
//     } catch (e) {
//       print("loginApi res$e");
//       throw "";
//     }
//   }
// }

class VerifyOtp {
  String phone;
  String otp;
  final String successKey = "status";
  final bool successVal = true;

  VerifyOtp({
    required this.phone,
    required this.otp,
  });

  Future<http.Response> callApi() async {
    // https://maidendropgroup.com/public/api/verifyotp?phone=9154902064&otp=1111
    String url = "${Strings.baseUrl}verifyotp?phone=$phone&otp=$otp";

    http.Response res = await http.get(Uri.parse(url));
    log("VERIFY OTP --> ${res.body}");
    dynamic decodedres = json.decode(res.body);
    // Save Roleid to shared preferences.
    if (res.statusCode >= 200 &&
        res.statusCode <= 299 &&
        decodedres["status"] == true) {
      final roleid = UserModel.fromJson(jsonDecode(res.body)).data[0].roleid;
      SharedPreferences preffs = await SharedPreferences.getInstance();
      preffs.setString('apiRoleid', roleid);
      return res;
    }
    return res;
  }

  //-----------------/. guest otp
  Future<http.Response> callguestApi() async {
    String url = "${Strings.baseUrl}verifyguestotp?phone=$phone&otp=$otp";

    http.Response res = await http.get(Uri.parse(url));
    log("VERIFY OTP GUEST --> ${res.body}");
    dynamic decodedres = json.decode(res.body);
    if (res.statusCode >= 200 &&
        res.statusCode <= 299 &&
        decodedres["status"] == true) {
      final guestid = GuestModel.fromJson(jsonDecode(res.body)).data![0].id;
      log('id is ${guestid.toString()}');
      // Save Roleid to shared preferences
      // final roleid = UserModel.fromJson(jsonDecode(res.body)).data[0].roleid;
      SharedPreferences idprefs = await SharedPreferences.getInstance();
      idprefs.setString('guestid', guestid!);
      return res;
    }
    return res;
  }
}

class MyAttendanceApi {
  String userid;
  final String successKey = "status";
  final bool successVal = true;
  final String intialDate = "";
  String toDate;
  String fromDate;
  final List DateFormat = DateTime.now().toString().split(" ")[0].split("-");

  MyAttendanceApi(
      {required this.userid, this.toDate = "null", this.fromDate = "null"});

  Future<http.Response> callApi() async {
    if (toDate == "null") {
      toDate = DateFormat[2] + "/" + DateFormat[1] + "/" + DateFormat[0];
    }

    if (fromDate == "null") {
      fromDate = DateFormat[2] +
          "/" +
          (int.parse(DateFormat[1]) - 1).toString() +
          "/" +
          DateFormat[0];
    }

    String url2 =
        "${Strings.baseUrl}MyattendanceFilter?userid=$userid&DateFrom=$fromDate&DateTo=$toDate";
    log("url_attendance --> $url2");
    String url = "${Strings.baseUrl}Myattendance?userid=$userid";
    log(url.toString());
    try {
      http.Response res = await http.get(Uri.parse(url2));
      print("MyAttendanceApi api called --------------> ${res.body}");
      // print("MyAttendanceApi body ${res.body}");
      return res;
    } catch (e) {
      print("MyAttendanceApi res$e");
      throw "";
    }
  }
}

class ReportingEmployeeApi {
  String userid;
  final String successKey = "status";
  final bool successVal = true;

  ReportingEmployeeApi({
    required this.userid,
  });

  Future<http.Response> callApi() async {
    // http://maidendropgroup.com/public/api/employeelist?userid=8735
    String url = "${Strings.baseUrl}employeelist?userid=$userid";
    log('needed url --> ${url.toString()}');
    try {
      http.Response res = await http.get(Uri.parse(url));
      log('REPORTING EMPLOYEE --> ${res.body}');
      print("verify api called ${res.statusCode}");
      return res;
    } catch (e) {
      print("verify res$e");
      throw "error in 124";
    }
  }
}

class LookUpApi {
  Future<http.Response> callApi() async {
    String url = "${Strings.baseUrl}lookups";
    try {
      http.Response res = await http.get(Uri.parse(url));
      print("lookups api called ${res.statusCode}");
      print(json.decode(res.body));
      return res;
    } catch (e) {
      print("lookups res$e");
      throw "error in 124";
    }
  }
}

class RequestLeaveApi {
  String userid;
  String fromDate;
  String toDate;
  String reason;
  String name;
  String fcm;
  final String successKey = "status";
  final bool successVal = true;

  RequestLeaveApi({
    required this.userid,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.name,
    required this.fcm,
  });

  Future<http.Response> callApi(BuildContext context) async {
    String url =
        "${Strings.baseUrl}requestLeave?from=$fromDate&to=$toDate&userid=$userid&reason=$reason";
    print(url);
    try {
      http.Response res = await http.get(Uri.parse(url));

      print("RequestLeaveApi api called ${res.statusCode}");
      var body = jsonDecode(res.body);
      print("RequestLeaveApi body $body");

      if (body["status"]) {
        SendNotification(
                body: "Leave Request",
                title: "A new leave request has been applied by $name ",
                fcm: fcm)
            .callApi();

        //send notification
      }

      return res;
    } catch (e) {
      print("RequestLeaveApi res$e");

      throw "";
    }
  }
}

class ApproveLeaveApi {
  String userid;
  String leaverequestid;
  String days;
  String status;
  String fcm;

  ApproveLeaveApi({
    required this.userid,
    required this.leaverequestid,
    required this.days,
    required this.status,
    required this.fcm,
  });

  Future<http.Response> callApi(BuildContext context) async {
    CustomDialog.showDialogTransperent(context);

    final snackBarMsg = status == "1" ? "Approved" : "Rejected";
    String url =
        "${Strings.baseUrl}approveRejectLeave/$leaverequestid/$status/$days/$userid";
    try {
      http.Response res = await http.get(Uri.parse(url));
      print("ApproveLeaveApi api called ${res.statusCode}");

      if (res.statusCode == 201) {
        Navigator.pop(context);

        var body = jsonDecode(res.body);
        print("ApproveLeaveApi body $body");
        if (body["status"]) {
          RemoveLeaveRequest().removeRequest(leaverequestid);

          SendNotification(
                  body: "Your leave request has been $snackBarMsg",
                  title: "Leave $snackBarMsg",
                  fcm: fcm)
              .callApi();
          //send notification
          CustomSnackBar.atBottom(title: "Leave", body: "Leave $snackBarMsg");
        }
      } else {
        Navigator.pop(context);

        CustomSnackBar.atBottom(
            title: "Leave", body: "Failed to change status", status: false);
      }
      return res;
    } catch (e) {
      print("ApproveLeaveApi res$e");
      CustomSnackBar.atBottom(
          title: "Leave",
          body: "Failed to change status (error)",
          status: false);

      throw "";
    }
  }
}

class GetStudents {
  String userid;
  String roleId;
  String branchId;
  final String successKey = "status";
  final bool successVal = true;

  GetStudents({
    required this.userid,
    required this.roleId,
    required this.branchId,
  });

  Future<http.Response> callApi() async {
    String url =
        "${Strings.baseUrl}getStudents?userid=$userid&roleId=$roleId&branchid=$branchId";
    try {
      print(url);
      http.Response res = await http.get(Uri.parse(url));
      print("GetStudents api called ${res.statusCode}");
      print("res api called ${res.body}");
      return res;
    } catch (e) {
      print("GetStudents res$e");
      throw "error in GetStudents";
    }
  }
}

class RequestGatePass {
  String userid;
  String fromDate;
  String toDate;
  String fromTime;
  String toTime;
  String reason;
  String studentid;
  String gaurdian;
  String otp;
  String phone;
  dynamic applicationnumber;

  RequestGatePass({
    required this.userid,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.reason,
    required this.studentid,
    required this.otp,
    required this.gaurdian,
    required this.phone,
    required this.applicationnumber,
  });
  // http://maidendropgroup.com/public/api/saveoutpass?userid=2120&studentid=7700&fromdate=2022-10-11&todate=2022-10-11&purpose=test

  Future<http.Response> callApi(BuildContext context) async {
    log(applicationnumber.toString());
    String url =
        "${Strings.baseUrl}saveoutpass?userid=$userid&studentid=$studentid&fromdate=$fromDate $fromTime&todate=$toDate $toTime&purpose=$reason&gardian=$gaurdian&otp=$otp&phone=$phone&phoneapplicationnumber=$applicationnumber";
    print(url);
    try {
      http.Response res = await http.post(Uri.parse(url));

      print("RequestGatePass api called ${res.statusCode}");
      var body = jsonDecode(res.body);
      print("RequestGatePass body $body");

      if (body["status"]) {
        // SendNotification(
        //         body: "Leave Request",
        //         title: "A new leave request has been applied by $name ",
        //         fcm: fcm)
        //     .callApi();

        //send notification
      }

      return res;
    } catch (e) {
      print("RequestGatePass res$e");

      throw "";
    }
  }
}

class ApplyBulkGatePassApi {
  String userid;
  String fromDate;
  String toDate;
  String section;
  String branch;
  String fromTime;
  String toTime;
  String reason;
  String gaurdian;

  ApplyBulkGatePassApi({
    required this.userid,
    required this.branch,
    required this.section,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.reason,
    required this.gaurdian,
  });

//http://maidendropgroup.com/public/api/savebulkoutpass?branchid=3&sectionid=93&ApplyBulkGatePassApi=6590&fromdate=2023-1-9
  Future<http.Response> callApi(BuildContext context) async {
    String url =
        "${Strings.baseUrl}savebulkoutpass?branchid=$branch&sectionid=$section&userid=$userid&fromdate=$fromDate $fromTime&todate=$toDate $toTime&purpose=$reason&gardian=$gaurdian";
    print(url);
    try {
      http.Response res = await http.post(Uri.parse(url));

      print("BulkApi api called ${res.statusCode}");
      var body = jsonDecode(res.body);
      print("BulkApi body $body");

      if (body["status"]) {
        // SendNotification(
        //         body: "Leave Request",
        //         title: "A new leave request has been applied by $name ",
        //         fcm: fcm)
        //     .callApi();

        //send notification
      }

      return res;
    } catch (e) {
      print("BulkApi res$e");

      throw "";
    }
  }
}

//-------------------------------------------------------*APPROVE GATEPASS
class ApproveGatePass {
  String formreqid;
  String approveform;
  String userid;

  ApproveGatePass({
    required this.formreqid,
    required this.approveform,
    required this.userid,
  });

  Future<http.StreamedResponse> callApi(BuildContext context) async {
    CustomDialog.showDialogTransperent(context);

    final snackBarMsg = approveform == "approved" ? "Approved" : "Rejected";
    // String url =
    // "${Strings.baseUrl}formRequestApprovalflow/form_request_id=$form_request_id&approveform=$approveform";
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Strings.baseUrl}formRequestApprovalflow'));
      request.fields.addAll({
        'form_request_id': formreqid,
        'approveform': approveform,
        'userid': userid
      });
      http.StreamedResponse res = await request.send();

      // print("ApproveGatePass api called ${res.statusCode}");

      if (res.statusCode == 201) {
        Navigator.pop(context);

        var body = jsonDecode(await res.stream.bytesToString());
        // log("GatePass body $body");
        if (body["status"]) {
          RemoveGatePass().removeRequest(formreqid);
          // SendNotification(
          //     body: "Your leave request has been approved",
          //     title: "Leave approved",
          //     fcm: fcm).callApi();
          //send notification
          CustomSnackBar.atBottom(
              status: approveform == 'rejected' ? false : true,
              title: "Gatepass",
              body: "Gatepass $snackBarMsg");
        }
      } else {
        Navigator.pop(context);

        CustomSnackBar.atBottom(
            title: "Gate Pass", body: "Failed to change status", status: false);
      }
      return res;
    } catch (e) {
      print("Gate Pass res$e");
      CustomSnackBar.atBottom(
          title: "Gate Pass",
          body: "Failed to change status (error)",
          status: false);

      throw "";
    }
  }
}

class FilterAttendanceApi {
  String userid;
  String fromDate;
  String toDate;

  FilterAttendanceApi({
    required this.userid,
    required this.fromDate,
    required this.toDate,
  });

  Future<http.Response> callApi(BuildContext context) async {
    CustomDialog.showDialogTransperent(context);

    // final snackBarMsg =  status=="1"?"Approved":"Rejected";
    String url =
        "${Strings.baseUrl}MyattendanceFilter?userid=$userid&DateFrom=$fromDate&DateTo=$toDate";

    print("FilterAttendanceApi api $url");

    // http: //maidendropgroup.com/public/api/MyattendanceFilter?userid=6611&DateFrom=16/11/2022&DateTo=18/11/2022
    try {
      http.Response res = await http.get(Uri.parse(url));
      print("FilterAttendanceApi api called ${res.statusCode}");

      if (res.statusCode == 201) {
        Navigator.pop(context);

        var body = jsonDecode(res.body);
        print("FilterAttendanceApi body $body");
        if (body["status"]) {
          //CustomSnackBar.atBottom(title: "Leave", body: "Leave $snackBarMsg");
        }
      } else {
        Navigator.pop(context);

        CustomSnackBar.atBottom(
            title: "Filter", body: "Failed to filter status", status: false);
      }
      return res;
    } catch (e) {
      print("FilterAttendanceApi res$e");
      CustomSnackBar.atBottom(
          title: "FilterAttendanceApi",
          body: "Failed status (error)",
          status: false);

      throw "";
    }
  }
}

class UpdateFcmApi {
  String fcm;
  String phone;
  //String toDate;

  UpdateFcmApi({
    required this.fcm,
    required this.phone,
  });

  Future<http.Response> callApi() async {
    String url = "${Strings.baseUrl}firebase?phone=$phone&firebase=$fcm";

    print("FilterAttendanceApi api $url");

    // http: //maidendropgroup.com/public/api/MyattendanceFilter?userid=6611&DateFrom=16/11/2022&DateTo=18/11/2022
    try {
      http.Response res = await http.get(Uri.parse(url));
      print("UpdateFcmApi api called ${res.statusCode}");

      return res;
    } catch (e) {
      print("UpdateFcmApi res$e");
      CustomSnackBar.atBottom(
          title: "UpdateFcmApi", body: "Failed status (error)", status: false);

      throw "";
    }
  }
}

class LeaveRequestApi {
  String userid;
  String branchId;

  LeaveRequestApi({
    required this.userid,
    required this.branchId,
  });

  Future<http.Response> callApi() async {
    String url =
        "${Strings.baseUrl}Leaverequests?userid=$userid&branchid=$branchId";
    log(url);
    try {
      http.Response res = await http.get(Uri.parse(url));
      print("verify api called ${res.statusCode}");

      return res;
    } catch (e) {
      print("verify res$e");
      throw "";
    }
  }
}

class GateOutApi {
  String userid;
  String branchId;

  GateOutApi({
    required this.userid,
    required this.branchId,
  });

  Future<http.Response> callApi() async {
    String url =
        "${Strings.baseUrl}studentoutpass?userid=$userid&branchid=$branchId";
        log(url);
    try {
      http.Response res = await http.get(Uri.parse(url));
      print("verify api called ${res.statusCode}");

      return res;
    } catch (e) {
      print("verify res$e");
      throw "";
    }
  }
}

class AppliedLeavesApi {
  String userid;

  AppliedLeavesApi({
    required this.userid,
  });

  Future<http.Response> callApi() async {
    String url = "${Strings.baseUrl}myLeaves?userid=$userid";
    try {
      http.Response res = await http.get(Uri.parse(url));
      print("verify api called ${res.statusCode}");

      return res;
    } catch (e) {
      print("verify res$e");
      throw "";
    }
  }
}

class GetReportingPerson {
  String userid;
  GetReportingPerson({
    required this.userid,
  });

  Future<String> callApi() async {
    String url = "${Strings.baseUrl}reportingperson?userid=$userid";
    // try {
    http.Response res = await http.get(Uri.parse(url));
    log("GetReportingPerson --> ${res.body}");

    if (res.statusCode == 201) {
      var body = jsonDecode(res.body);
      if (body["status"]) {
        return (body["data"][0]["name"]).toString();
      } else {
        return "";
      }
    } else {
      return "null";
    }
    // }
    //  catch (e) {
    //   print("verify res$e");
    //   throw "";
    // }
  }

  Future<String> getReportinPersonToken() async {
    String url = "${Strings.baseUrl}reportingperson?userid=$userid";
    try {
      http.Response res = await http.get(Uri.parse(url));
      print("verify api called ${res.statusCode}");

      if (res.statusCode == 201) {
        var body = jsonDecode(res.body);
        if (body["status"]) {
          return (body["data"][0]["firebase"]).toString();
        } else {
          return "null";
        }
      } else {
        return "null";
      }
    } catch (e) {
      print("verify res$e");
      throw "";
    }
  }
}

class GetLeaveInfo {
  String userid;
  String branchid;
  GetLeaveInfo({
    required this.userid,
    required this.branchid,
  });

  Future<http.Response> callApi() async {
    // http://maidendropgroup.com/public/api/appliedleavescount?userid=$userid&branchid=$branchid
    String url =
        "${Strings.baseUrl}appliedleavescount?userid=$userid&branchid=$branchid";
    try {
      http.Response res = await http.get(Uri.parse(url));
      return res;
    } catch (e) {
      print("LeaveInfo Error API e$e");
      throw "";
    }
  }
}

class RecordReasonApi {
  String attendanceId;
  String type;
  String reason;
  RecordReasonApi({
    required this.attendanceId,
    required this.type,
    required this.reason,
  });

  Future<http.Response> callApi() async {
    String url =
        "${Strings.baseUrl}recordReason?attendanceid=$attendanceId&type=$type&reason=$reason";
    try {
      http.Response res = await http.get(Uri.parse(url));
      log("RecordReason --> ${res.body}");
      return res;
    } catch (e) {
      print("RecordReason Error API e$e");
      throw "";
    }
  }
}
