import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/model/user_model.dart';
import 'package:attendance/service/services_api/api.dart';
import 'package:attendance/view/pages/dashboard/dashboard.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmailService {
  Future<UserModel?> emailLogin({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response =
          await http.post(Uri.parse('${Strings.baseUrl}check_login'), body: {
        'username': username,
        'password': password,
      });
      // http.Response res = await http.get(Uri.parse(
      //     '${Strings.baseUrl}check_login?username=nagarjuna.j@resonancehyderabad.com&password=9154852727'));
      log('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => DashBoardScreen(),
            ),
            (route) => false);
        UserModel userData = userModelFromJson(response.body.toString());

        FirebaseMessaging messaging = FirebaseMessaging.instance;
        final fcmToken = await FirebaseMessaging.instance.getToken();

        await UpdateFcmApi(fcm: fcmToken!, phone: userData.data[0].mobile)
            .callApi()
            .then((value) {
          if (value.statusCode == 201) {
            userData.data[0].firebase = fcmToken;
          }
        });

        //write fcm to database
        //update fcm to object

        await UserModelController().updateUserModel(userData);

        CustomSnackBar.atBottom(
          title: "Successful",
          body: "Login Successful",
        );
        // Navigator.of(context).pop();

        log('Post request successful');
      } else {
        CustomSnackBar.atBottom(
          title: "Failed",
          body: "Login Failed",
          status: false,
        );
        print('Post request failed');
      }
    } catch (e) {
      debugPrint('catche is $e');
    }
  }
}
