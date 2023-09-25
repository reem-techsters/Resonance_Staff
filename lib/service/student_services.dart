import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/student_model.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentService {
  Future<StudentLeave?> getStudentList() async {
    final brandchid = GetUserData().getUserBranch();
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}StudentLeaverequests?branchid=$brandchid'));
      log('response --> \n ${response.body}');

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
}
