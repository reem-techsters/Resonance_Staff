import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:flutter/material.dart' show Navigator, debugPrint;
import 'package:http/http.dart' as http;

class GetOTPService {
  Future<dynamic?> getOTP(String phone, context) async {
    try {
      CustomDialog.showDialogTransperent(context);
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}login?phone=$phone'));
      log('GET OTP LOGIN --> ${response.statusCode}\n${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        Navigator.pop(context);
        dynamic res = json.decode(response.body);
        return res;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }
}
