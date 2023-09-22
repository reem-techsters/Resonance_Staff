import 'dart:convert';

import 'package:attendance/model/leave_request_model.dart';
import 'package:get/get.dart';
//import 'package:attendance/model/user_model.dart';

import '../../service/services_api/api.dart';
import '../../view/widgets/custom_snackbar.dart';

class LeaveRequestController extends GetxController {
  var stateLeaveRequestModel = <LeaveRequestModel>[].obs;

  updateLeaveRequestModel(LeaveRequestModel obj) {
    stateLeaveRequestModel.add(obj);
  }

  Future<bool> getLeaveRequestModel(String userid, String branchId) async {
    print("init $userid");
    var res =
        await LeaveRequestApi(userid: userid, branchId: branchId).callApi();

    if (res.statusCode == 201) {
      var body = res.body;
      final decodedbody = jsonDecode(body);
      print(" ${decodedbody["status"]}");
      print("getLeaveRequestModel ---$body");

      if (decodedbody["status"]) {
        //UserModel userData = UserModel(data: body["data"],status: body["status"],message: body["message"]).fromJson;
        LeaveRequestModel userData = leaveRequestModelFromJson(body.toString());
        await updateLeaveRequestModel(userData);
        return true;
      } else {
        CustomSnackBar.atBottom(
            title: "Leave Request", body: "error", status: false);
        return false;
      }
    } else {
      CustomSnackBar.atBottom(
          title: "Leave Request",
          body: res.statusCode.toString(),
          status: false);
      return false;
    }
  }
}
