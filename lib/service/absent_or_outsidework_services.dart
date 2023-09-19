// import 'dart:convert';
// import 'dart:developer';
// import 'package:attendance/constant/strings.dart';
// import 'package:attendance/model/payslip_model.dart';
// import 'package:attendance/utils/get_user_id.dart';
// import 'package:flutter/material.dart' show debugPrint;
// import 'package:http/http.dart' as http;

// class notLoginServices {
//   // Future<PaySlipModel?> notLoginReason() async {
//     try {
//       final userid = GetUserData().getUserId();
// //  final response =
// //           await http.post(Uri.parse('${Strings.baseUrl}'), body: {
// //         'userid': userid,
// //         'bank_name': bankName,
// //         'branch_name': branchName,
// //         'account_no': accNum,
// //         'ifsc_code': ifsc,
//       // });
//       final response = await http.get(Uri.parse('${Strings.baseUrl}'));
//       // log('notLoginReason response --> \n ${response.body}');

//       if (response.statusCode >= 200 && response.statusCode <= 299) {
//         final data = PaySlipModel.fromJson(json.decode(response.body));
//         return data;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       debugPrint('catche is $e');
//       return null;
//     }
//   }
// }
