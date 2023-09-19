import 'dart:developer';
import 'package:attendance/model/get_bank_details_model.dart';
import 'package:attendance/service/bank_service.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/pages/finances/bank/edit_bank_details_screen.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankDetailsGetx extends GetxController {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscController = TextEditingController();

  GlobalKey<FormState> bankformkey = GlobalKey<FormState>();

  bool showLoader = false;
  List<Datum> bankList = [];
  int initialIndex = 0;
  dynamic datam;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getBankList();
  }

  Future<void> getBankList() async {
    log(GetUserData().getUserId().toString());
    showLoader = true;
    update();
    BankDetails? response = await BankDetailService().getBankList();
    if (response != null) {
      if (response.data != null) {
        update();
        bankList = response.data ?? [];
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    showLoader = false;
    update();
  }

  Future<void> addBankList(BuildContext context) async {
    if (bankformkey.currentState!.validate()) {
      await BankDetailService().addBankList(
        userid: GetUserData().getUserId(),
        bankName: bankNameController.text,
        branchName: branchNameController.text,
        ifsc: ifscController.text,
        accNum: accountNumberController.text,
      );
      Navigator.pop(context);
      clearTextfield();
      getBankList();
    }
  }

  Future<void> editBankList(BuildContext context) async {
    log(bankList[initialIndex].id.toString());
    if (datam.bankName != bankNameController.text ||
        datam.branchName != branchNameController.text ||
        datam.ifscCode != ifscController.text ||
        datam.accountNo != accountNumberController.text) {
      if (bankformkey.currentState!.validate()) {
        await BankDetailService().editBankList(
          userid: GetUserData().getUserId(),
          bankName: bankNameController.text,
          branchName: branchNameController.text,
          ifsc: ifscController.text,
          accNum: accountNumberController.text,
          accountid: bankList[initialIndex].id.toString(),
        );
        Navigator.pop(context);
        getBankList();
      }
    } else {
      CustomSnackBar.atBottom(
        title: "No Edits Were Made",
        body: "Do Some Edits To Save ",
        status: false,
      );
    }
  }

  Future<void> toEditScreenNavigation(
      dynamic data, BuildContext context, int index) async {
    datam = data;
    bankNameController.text = await data.bankName;
    branchNameController.text = await data.branchName;
    accountNumberController.text = await data.accountNo;
    ifscController.text = await data.ifscCode;
    update();
    initialIndex = index;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditBankDetailsScreen(),
    ));
  }

  void clearTextfield() {
    bankNameController.clear();
    branchNameController.clear();
    ifscController.clear();
    accountNumberController.clear();
  }

  Future<void> loadresources() async {
    await getBankList();
  }

  textFormValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return 'This is required';
    }
    return null;
  }
}
