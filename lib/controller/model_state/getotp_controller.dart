import 'dart:developer';

import 'package:attendance/service/getotp_services.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class OtpGetx extends GetxController {
  var successmessage = ''.obs;
  late bool status;

  Future<void> getOTP(String phone, context) async {
    dynamic response = await GetOTPService().getOTP(phone, context);
    if (response["status"] == true) {
      status = response["status"];
      successmessage.value = response["message"];
      update();
      CustomSnackBar.atBottom(title: "Otp Successful", body: "Otp is sent");
      update();
    } else if (response["status"] == false) {
      status = response["status"];

      CustomSnackBar.atBottom(
          title: "Otp Failed", body: response["message"], status: false);
    }
    update();
  }

  bool showPinPut = true;
  bool isVisible2 = true;
  bool isVisible = false;

  void toggleVisibility() {
    showPinPut = false;
    isVisible2 = false;
    isVisible = true;
    update();
  }
}
