import 'package:attendance/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static void atBottom({required title, required body, status = true}) {
    Get.snackbar(
      title,
      body,
      colorText: Colors.white,
      icon: status
          ? Icon(Icons.person, color: Colors.white)
          : Icon(Icons.error_outline, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: status ? Colors.green : Strings.colorRed,
    );
  }

  static void atTop({required title, required body, status = true}) {
    Get.snackbar(
      title,
      body,
      colorText: Colors.white,
      icon: Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: status ? Colors.green : Strings.colorRed,
    );
  }
}
