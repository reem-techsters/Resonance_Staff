import 'dart:convert';
import 'dart:developer';

import 'package:attendance/model/leave_request_model.dart';
import 'package:attendance/model/student_model.dart';
import 'package:attendance/service/student_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:attendance/model/user_model.dart';

import '../../service/services_api/api.dart';
import '../../view/widgets/custom_snackbar.dart';

class LeaveRequestController extends GetxController {
  var stateLeaveRequestModel = <LeaveRequestModel>[].obs;
  bool showLoader = false;
  updateLeaveRequestModel(LeaveRequestModel obj) {
    stateLeaveRequestModel.add(obj);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getStudentList();
  }

  List<StudentDatum> studentlist = [];

  Future<void> getStudentList() async {
    showLoader = true;
    StudentLeave? response = await StudentService().getStudentList();
    if (response != null) {
      if (response.data != null) {
        update();
        studentlist = response.data ?? [];
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

  //-------------------------------------------------------*Refresh Loader
  Future<void> loadresources() async {
    Get.put(LeaveRequestController());

    await Get.find<LeaveRequestController>().getStudentList();
  }

//------
  //------------
  final TextEditingController searchStudentCtrl = TextEditingController();
  List<dynamic> searchDataStudent = [];
  getSearchResultStudent(String value) {
    searchDataStudent.clear();
    for (var i in studentlist) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.applicationnumber
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase())) {
        StudentDatum data = StudentDatum(
            leaverequestid: i.leaverequestid,
            leavefrom: i.leavefrom,
            leaveto: i.leaveto,
            days: i.days,
            reason: i.reason,
            isapproved: i.isapproved,
            statusupdatedby: i.statusupdatedby,
            userid: i.userid,
            name: i.name,
            applicationnumber: i.applicationnumber);
        update();
        searchDataStudent.add(data);
        update();
      }
    }
  }

  //------------
  final TextEditingController searchCtrl = TextEditingController();
  List<dynamic> searchData = [];
  List<Data> approveLeaveslist = [];
  getSearchResult(String value) {
    searchData.clear();
    for (var i in approveLeaveslist) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.employeeid.toString().toLowerCase().contains(value.toLowerCase())) {
        Data data = Data(
          leaverequestid: i.leaverequestid,
          leavefrom: i.leavefrom,
          leaveto: i.leaveto,
          days: i.days,
          reason: i.reason,
          isapproved: i.isapproved,
          statusupdatedby: i.statusupdatedby,
          userid: i.userid,
          fcm: i.fcm,
          name: i.name,
          totalleaves: i.totalleaves,
          employeeid: i.employeeid,
        );
        update();
        searchData.add(data);
        update();
      }
    }
  }

  Future<void> studentleaveApproveReject(
      {dynamic days,
      dynamic fcm,
      dynamic leaverequestid,
      dynamic status,
      dynamic userid}) async {
    log("Inside Controller");
    log('days = ${days}');
    log('fcm = ${fcm}');
    log('leaverequestid = ${leaverequestid}');
    log('status = ${status}');
    log('userid = ${userid}');
    await StudentService().studentApproveorReject(
        leaverequestid: leaverequestid,
        status: status,
        days: days,
        userid: userid);
    // ApproveLeaveApi(
    //     days: days,
    //     fcm: fcm,
    //     leaverequestid: leaverequestid,
    //     status: status,
    //     userid: userid);
    getStudentList();
    update();
  }

  Future<bool> getLeaveRequestModel(String userid, String branchId) async {
    print("init $userid");
    var res =
        await LeaveRequestApi(userid: userid, branchId: branchId).callApi();

    if (res.statusCode == 201) {
      var body = res.body;
      final decodedbody = jsonDecode(body);
      print(" ${decodedbody["status"]}");

      print("getLeaveRequestModel ---$body");

      if (decodedbody["status"]) {
        //UserModel userData = UserModel(data: body["data"],status: body["status"],message: body["message"]).fromJson;
        LeaveRequestModel userData = leaveRequestModelFromJson(body.toString());
        await updateLeaveRequestModel(userData);
        approveLeaveslist = userData.data;
        log('testing ${userData.data[0].name}');
        return true;
      } else {
        CustomSnackBar.atBottom(
            title: "Leave Request", body: "error", status: false);
        return false;
      }
    } else {
      CustomSnackBar.atBottom(
          title: "Leave Request",
          body: res.statusCode.toString(),
          status: false);
      return false;
    }
  }
}
