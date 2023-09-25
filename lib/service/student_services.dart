import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/student_model.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentService {
  Future<StudentLeave?> getStudentList() async {
    final brandchid = GetUserData().getUserBranch();
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}StudentLeaverequests?branchid=$brandchid'));
      print('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return StudentLeave.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<void> studentApproveorReject(
      {required dynamic leaverequestid,
      required dynamic status,
      required dynamic days,
      required dynamic userid}) async {
    try {
      final snackBarMsg = status == "1" ? "Approved" : "Rejected";
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}approveRejectLeave/$leaverequestid/$status/$days/$userid'));
      print('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        // return StudentLeave.fromJson(json.decode(response.body));
        CustomSnackBar.atBottom(title: "Leave", body: "Leave $snackBarMsg");
      } else {
        CustomSnackBar.atBottom(
            title: "Failed", body: "Failed to Approve/Reject");
      }
    } catch (e) {
      debugPrint('catche is $e');
    }
  }
}
