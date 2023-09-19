import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/biometric_model.dart';
import 'package:attendance/model/outside_work_model.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AbsentService {
  Future<void> absent({
    required dynamic attendanceid,
    required dynamic reason,
    required dynamic biometric,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://maidendropgroup.com/public/api/absentregularise'),
        body: {
          'type': biometric.toString(),
          'attendanceid': attendanceid.toString(),
          'reason': reason.toString(),
        },
      );

      print('Request URL --> ${Strings.baseUrl}approveabsentregularise');
      log('absent response --> \n${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(
          title: "Success",
          body: "Reason is recorded",
        );
        log('Post request successful');
      } else {
        CustomSnackBar.atBottom(
          title: "Failed",
          body: "Failed To Add Details",
          status: false,
        );
        print('Post request failed');
      }
    } catch (e) {
      debugPrint('Exception: $e');
      // You may want to handle the exception properly here.
    }
  }

  Future<Biometric?> biometricList() async {
    try {
      final response =
          await http.get(Uri.parse('${Strings.baseUrl}absenttype'));
      log('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return Biometric.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<OutsideWork?> outsideWorkList(dynamic userid) async {
    try {
      final response = await http.get(
          Uri.parse('${Strings.baseUrl}absentregulariselist?userid=$userid'));
      log('outsideWork response -->  ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return OutsideWork.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<dynamic> outsideWorkApproveOrReject(
      BuildContext context, dynamic status) async {
    try {
      final response = await http.post(
        Uri.parse('${Strings.baseUrl}approveabsentregularise?attendanceid'),
        body: {
          'status': status.toString(),
        },
      );
      // final response = await http.get(Uri.parse(
      //     '${Strings.baseUrl}approveabsentregularise?attendanceid&status=$status'));
      log('approveOutsideWork response -->  ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(
            title: 'Success',
            body: status == 1
                ? 'Approved'
                : status == 2
                    ? 'Rejected'
                    : '');
      } else {
        CustomSnackBar.atBottom(
            title: 'Failed',
            body: status == 1
                ? 'Failed to approved'
                : status == 2
                    ? 'Failed to Reject'
                    : '');
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }
}
