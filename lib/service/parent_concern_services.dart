import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/parent_concern_model.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:http/http.dart' as http;

class ParentConcernService {
  Future<Parent?> getParentConcernList(dynamic userid) async {
    try {
      log('userrr-->${userid.toString()}');
      final response = await http.get(Uri.parse(
          //userid
          '${Strings.baseUrl}Studentconcerns?branchid=$userid'));
      log('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return Parent.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

//--------------------------------------------------*Sending status (Pending --> In Progress)
  Future<int?> getInProgressList(int studentId, int id) async {
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}concerninprogress?student_id=$studentId&id=$id'));

      log('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(title: "STATUS", body: "Success");
        return response.statusCode;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

//--------------------------------------------------*Sending status (In Progress --> Resolved)
  Future<int?> getResolvedList(int studentId, int id) async {
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}concern_status_changed?student_id=$studentId&id=$id'));

      log('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final resp = response.statusCode;
        return resp;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }
}
