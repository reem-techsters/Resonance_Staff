// https://maidendropgroup.com/public/api/verifyguestotp?phone=8977245573&otp=1111

import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:http/http.dart' as http;

class GuestService {
  Future<dynamic?> guestOTP(String phone, dynamic otp) async {
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}verifyguestotp?phone=$phone&otp=$otp'));
      log('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
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
