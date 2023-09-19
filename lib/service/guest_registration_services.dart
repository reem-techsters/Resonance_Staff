import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:http/http.dart' as http;

class GuestLoginService {
  Future<dynamic?> guestLogin(
      String name, String email, String phone, String password) async {
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}AddEmployee?name=$name&email=$email&phone=$phone&password=$password'));
      log('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic res = json.decode(response.body);
        return res['status'];
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<dynamic?> userAccountDelete(String userId) async {
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}deleteGuestaccount?userid=$userId'));
      log('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic res = json.decode(response.body);
        return res['status'];
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<dynamic?> guestAccountDelete(String userId) async {
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}deleteaccount?userid=$userId'));
      log('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic res = json.decode(response.body);
        return res['status'];
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }
}
