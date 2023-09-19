import 'package:attendance/model/guest_model.dart';
import 'package:attendance/service/guest_registration_services.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestGetx extends GetxController {
  String? selectedOption;
  List<String> options = [
    'Vani Institute',
    'Resonance Hyderabad',
    'Resonance Warangal',
    'Motion Hyderabad',
    'Nkidz'
  ];
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  List<Guest> parentConcernlist = [];

  bool showLoader = true;

  Future<void> signupGuest(
      String name, String email, String phone, String password) async {
    dynamic response =
        await GuestLoginService().guestLogin(name, email, phone, password);
    if (response != null && response == true) {
      update();
      CustomSnackBar.atBottom(
          title: "REGISTRATION SUCCESSFUL", body: "You may login now");
      update();
    } else {
      CustomSnackBar.atBottom(
          status: false, title: "REGISTRATION SUCCESSFUL", body: "Try Again");
    }
    showLoader = false;
    update();
  }

  Future<void> userAccountDelete(String userId) async {
    dynamic response = await GuestLoginService().userAccountDelete(userId);
    if (response != null && response == true) {
      update();
      CustomSnackBar.atBottom(
          title: "Succesful", body: "Account Deletion Succesful");
      update();
    } else {
      CustomSnackBar.atBottom(
          status: false, title: "Failed", body: "Account Deletion Failed");
    }
    showLoader = false;
    update();
  }

  Future<void> guestAccountDelete(String userId) async {
    dynamic response = await GuestLoginService().userAccountDelete(userId);
    if (response != null && response == true) {
      update();
      CustomSnackBar.atBottom(
          title: "Succesful", body: "Account Deletion Succesful");
      update();
    } else {
      CustomSnackBar.atBottom(
          status: false, title: "Failed", body: "Account Deletion Failed");
    }
    showLoader = false;
    update();
  }

  nameValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return 'This is required';
    }
    // else if (value.length < 3) {
    //   update();
    //   return 'Should contain minimum of 4 letters';
    // }
    return null;
  }

  emailValdation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This is required';
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return 'Invalid email , please enter correct email';
    } else {
      return null;
    }
  }

  phoneValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return 'This is required';
    } else if (value.length <= 9) {
      update();
      return 'please enter correct phone number';
    }
    return null;
  }

  passwordValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return 'This is required';
    } else if (value.length <= 3) {
      update();
      return 'Length should exceed or be 4';
    }
    return null;
  }
}
