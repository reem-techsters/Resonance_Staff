import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/get_bank_details_model.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:http/http.dart' as http;

class BankDetailService {
  Future<BankDetails?> getBankList() async {
    final userid = GetUserData().getUserId();
    try {
      final response = await http
          .get(Uri.parse('${Strings.baseUrl}bankAccounts?userid=$userid'));
      log('Bank response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return BankDetails.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<BankDetails?> addBankList({
    required String userid,
    required String bankName,
    required String branchName,
    required String ifsc,
    required String accNum,
  }) async {
    try {
      final response =
          await http.post(Uri.parse('${Strings.baseUrl}addaccount'), body: {
        'userid': userid,
        'bank_name': bankName,
        'branch_name': branchName,
        'account_no': accNum,
        'ifsc_code': ifsc,
      });
      log('Add Bank response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(
          title: "Successful",
          body: "Bank Details Added Succesfully",
        );
        log('Post request successful');
      } else {
        CustomSnackBar.atBottom(
          title: "Failed",
          body: "Failed To Add Bank Details",
          status: false,
        );
        print('Post request failed');
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
    return null;
  }

  Future<BankDetails?> editBankList({
    required String userid,
    required String bankName,
    required String branchName,
    required String ifsc,
    required String accNum,
    required String accountid,
  }) async {
    try {
      final response =
          await http.post(Uri.parse('${Strings.baseUrl}editaccount'), body: {
        'userid': userid,
        'bank_name': bankName,
        'branch_name': branchName,
        'account_no': accNum,
        'ifsc_code': ifsc,
        'accountid':accountid,
      });
      log('Edit Bank response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(
          title: "Successful",
          body: "Bank Details Edited Succesfully",
        );
        log('Post request successful');
      } else {
        CustomSnackBar.atBottom(
          title: "Failed",
          body: "Failed To Edit Bank Details",
          status: false,
        );
        print('Post request failed');
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
    return null;
  }
}
