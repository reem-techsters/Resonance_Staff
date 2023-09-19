import 'dart:developer';
import 'package:attendance/model/payslip_model.dart';
import 'package:attendance/service/payslip_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaySlipGetx extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await payslip();
  }

  List<PaySlipDatum> payslipList = [];

  bool showLoader = true;

  Future<void> payslip() async {
    PaySlipModel? response = await PayslipService().getPayslipList();
    if (response != null) {
      if (response.data != null) {
        update();
        payslipList = response.data ?? [];
        showLoader = false;
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

  String payslipformatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    final String formattedDate = formatter.format(date);
    return formattedDate;
  }
}
