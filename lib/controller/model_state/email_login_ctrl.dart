import 'package:attendance/model/get_bank_details_model.dart';
import 'package:attendance/service/email_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailGetx extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> emailformkey = GlobalKey<FormState>();

  bool showLoader = false;
  List<Datum> bankList = [];
  int initialIndex = 0;
  dynamic datam;

  @override
  Future<void> onInit() async {
    super.onInit();

    if (kReleaseMode) {
      emailController = TextEditingController();
      passwordController = TextEditingController();
    } else {
      emailController =
          TextEditingController(text: "nagarjuna.j@resonancehyderabad.com");
      passwordController = TextEditingController(text: "9154852727");
    }
  }

  var isTextObscured = true;

  

  Future<void> emailLogin(BuildContext context) async {
    if (emailformkey.currentState!.validate()) {
      await EmailService().emailLogin(
          username: emailController.text,
          password: passwordController.text,
          context: context);
      clearTextfield();
    }
  }

  void clearTextfield() {
    emailController.clear();
    passwordController.clear();
  }

  textFormValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return 'This is required';
    }
    return null;
  }
}
