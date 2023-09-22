import 'dart:convert';
import 'package:get/get.dart';
import '../../model/leave_info_model.dart';
import '../../service/services_api/api.dart';

class LeaveInfoController extends GetxController {
  var stateLeaveInfoModel = <LeaveInfoModel>[].obs;

  updateLeaveInfoModel(LeaveInfoModel obj) {
    print("updateing ${obj.toJson()}");
    stateLeaveInfoModel.add(obj);
  }

  Future<bool> getLeaveInfoModel(String userid, String branch) async {
    print("getLeaveInfoModel $userid");
    var res = await GetLeaveInfo(userid: userid, branchid: branch).callApi();

    if (res.statusCode == 201) {
      var body = res.body;
      final decodedbody = jsonDecode(body);
      print(" ${decodedbody["status"]}");
      print("getLeaveInfoModel ---$body");

      if (decodedbody["status"]) {
        print(decodedbody["status"]);
        //UserModel userData = UserModel(data: body["data"],status: body["status"],message: body["message"]).fromJson;
        LeaveInfoModel userData = leaveInfoModelFromJson(body.toString());

        print("object LeaveInfoModel ${userData.toJson()}");
        await updateLeaveInfoModel(userData);
        return true;
      } else {
        // CustomSnackBar.atBottom(
        //     title: "Leave Request", body: "error", status: false);
        return false;
      }
    } else {
      // CustomSnackBar.atBottom(
      //     title: "Leave Request", body: res.statusCode.toString(), status: false);
      return false;
    }
  }
}
