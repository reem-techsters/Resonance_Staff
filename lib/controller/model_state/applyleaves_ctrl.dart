import 'dart:convert';
import 'package:attendance/controller/model_state/leave_info_ctrl.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/routes/getRoutes.dart';
import 'package:attendance/service/services_api/api.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyLeaveGetx extends GetxController {
  late UserModelController userModelCtrl;
  late LeaveInfoController? LeaveInfoCtrl;
  @override
  Future<void> onInit() async {
    super.onInit();
    userModelCtrl = await Get.find<UserModelController>();
    LeaveInfoCtrl = await Get.put(LeaveInfoController());
  }

  final TextEditingController leavesReasonCtrl = TextEditingController();
  final TextEditingController fromDateCtrl = TextEditingController();
  final TextEditingController toDateCtrl = TextEditingController();

  Future<void> applyleavesubmit(context) async {
    // https://maidendropgroup.com/public/api/studentoutpassedit?form_request_id=1939&intime=2023-06-26%2017:12
    CustomDialog.showDialogTransperent(context);
    var res = await RequestLeaveApi(
            fromDate: "${fromDateCtrl.text} 00.00.00.000",
            toDate: "${toDateCtrl.text} 00.00.00.000",
            reason: leavesReasonCtrl.text,
            userid: userModelCtrl.getUserId(),
            fcm: GetUserData().getReportingPersonToken(),
            name: GetUserData().getUserName())
        .callApi(context);

    update();
    if (res.statusCode == 201) {
      var body = jsonDecode(res.body);
      // if (body["status"]) {
        await LeaveInfoCtrl!.getLeaveInfoModel(
            GetUserData().getUserId(), GetUserData().getUserBranch());
        fromDateCtrl.text = "";

        leavesReasonCtrl.text = "";
        toDateCtrl.text = "";
        Navigator.pop(context);
        Navigator.pushNamed(context, GetRoutes.pageAppliedLeaves);

        CustomSnackBar.atBottom(title: "Leave", body: "Leave applied");
      // }
      // else {
      //   Navigator.pop(context);
      //   CustomSnackBar.atBottom(
      //       title: "Leave", body: "Cannot apply leave", status: false);
      // } //Strings.baseUrl+requestLeave?from=2022-11-04 00.00.00.000&to=2022-11-05 00.00.00.000&userid=6611&reason=hello world reason
    }
    update();
  }

  //---------------------------------------------*LEAVES
  fromtoValidation() {
    if (fromDateCtrl.text.isEmpty && toDateCtrl.text.isEmpty) {
      CustomSnackBar.atBottom(
          title: 'Enter From & To Date',
          body: 'This is required',
          status: false);
    } else if (fromDateCtrl.text.isEmpty) {
      CustomSnackBar.atBottom(
          title: 'Enter From Date', body: 'This is required', status: false);
    } else if (toDateCtrl.text.isEmpty) {
      CustomSnackBar.atBottom(
          title: 'Enter To Date', body: 'This is required', status: false);
    }
    return null;
  }

  leavesReasonValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return 'This is required';
    }
    return null;
  }
  /*-----------------------------*/
}
