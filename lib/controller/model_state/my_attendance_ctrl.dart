import 'dart:convert';
import 'dart:developer';
import 'package:attendance/controller/model_state/leave_info_ctrl.dart';
import 'package:attendance/model/biometric_model.dart';
import 'package:attendance/model/outside_work_model.dart';
import 'package:attendance/service/outsidework_services.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../service/services_api/api.dart';
import '../../model/my_attendance_model.dart';
import '../../view/widgets/custom_snackbar.dart';

class MyAttendanceModelController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await getoutsideWorkList(GetUserData().getUserId());
  }

  TextEditingController notloginController = TextEditingController();
  String dropdownvalue = 'Select type'; // Initial value
  String type1 = '';
  String type2 = '';
  List<String> biometrics = [];
  List<OutsideWorkDatum> outsideWorkList = [];
  bool isloader = false;

  Future<void> outsideWorkApproveOrReject(
      BuildContext context, dynamic status) async {
    await AbsentService().outsideWorkApproveOrReject(context, status);
  }

  textFormValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return 'This is required';
    }
    return null;
  }

  Future<void> getoutsideWorkList(dynamic userid) async {
    isloader = true;
    OutsideWork? response = await AbsentService().outsideWorkList(userid);
    if (response != null) {
      if (response.data != null) {
        update();
        outsideWorkList = response.data ?? [];
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    isloader = false;
    update();
  }

  Future<void> biometricList() async {
    Biometric? response = await AbsentService().biometricList();
    if (response != null) {
      if (response.data != null) {
        update();
        type1 = response.data!.type1.toString();
        type2 = response.data!.type2.toString();
        biometrics = ['Select type', type1, type2];
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    showLoader = false;
    update();
  }

  Future<void> addAbsent(BuildContext context, dynamic attendenceid,
      dynamic biometric, dynamic reason) async {
    if (attendenceid != null && biometric != null && reason != null) {
      await AbsentService().absent(
          biometric: biometric, reason: reason, attendanceid: attendenceid);
      Navigator.pop(context);
    }
  }

  var stateMyAttendanceModel = <MyAttendanceModel>[].obs;

  updateMyAttendanceModel(MyAttendanceModel obj) {
    stateMyAttendanceModel.add(obj);
  }

  bool showLoader = true;

  Future<bool> getMyAttendance(String userid,
      {String branch = "", fromDate = "null", toDate = "null"}) async {
    LeaveInfoController? stateLeaveInfoCtrl = Get.put(LeaveInfoController());

    print("getMyAttendance $userid $branch");
    await stateLeaveInfoCtrl!.getLeaveInfoModel(userid, branch);

    var res = await MyAttendanceApi(
            userid: userid, fromDate: fromDate, toDate: toDate)
        .callApi();

    if (res.statusCode == 201) {
      var body = res.body;
      final decodedbody = jsonDecode(body);
      // print(" ${decodedbody["status"]}");
      print(" much needed RESPONSE ---$body");

      if (decodedbody["status"]) {
        //UserModel userData = UserModel(data: body["data"],status: body["status"],message: body["message"]).fromJson;
        MyAttendanceModel userData = myAttendanceFromJson(body.toString());
        // log('needed data --> ${body.toString()}');
        await updateMyAttendanceModel(userData);
        return true;
      } else {
        CustomSnackBar.atBottom(
            title: "My attendance", body: "error", status: false);
        return false;
      }
    } else {
      CustomSnackBar.atBottom(
          title: "My attendance",
          body: res.statusCode.toString(),
          status: false);
      return false;
    }
  }

  Future<bool> filterAttendance(BuildContext context, String userid,
      {String branch = "",
      required String fromDate,
      required String toDate}) async {
    var res = await FilterAttendanceApi(
            userid: userid, fromDate: fromDate, toDate: toDate)
        .callApi(context);

    if (res.statusCode == 201) {
      var body = res.body;
      final decodedbody = jsonDecode(body);
      print(" ${decodedbody["status"]}");
      print(" ---$body");

      if (decodedbody["status"]) {
        //UserModel userData = UserModel(data: body["data"],status: body["status"],message: body["message"]).fromJson;
        MyAttendanceModel userData = myAttendanceFromJson(body.toString());
        await updateMyAttendanceModel(userData);
        return true;
      } else {
        CustomSnackBar.atBottom(
            title: "My attendance", body: "error", status: false);
        return false;
      }
    } else {
      CustomSnackBar.atBottom(
          title: "My attendance",
          body: res.statusCode.toString(),
          status: false);
      return false;
    }
  }

  //-------------------------------------------------------*Refresh Loader
  Future<void> loadresources(bool reload) async {
    Get.put(MyAttendanceModelController());

    await Get.find<MyAttendanceModelController>()
        .getMyAttendance(GetUserData().getCurrentUser().userid);
  }

  Future<void> outsideworkloadresources(bool reload) async {
    Get.put(MyAttendanceModelController());

    await Get.find<MyAttendanceModelController>()
        .getoutsideWorkList(GetUserData().getUserId());
  }
}
