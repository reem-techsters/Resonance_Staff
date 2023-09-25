import 'dart:convert';
import 'package:get/get.dart';
//import 'package:attendance/model/user_model.dart';
import '../../model/applied_leave_model.dart';
import '../../service/services_api/api.dart';
import '../../view/widgets/custom_snackbar.dart';

class AppliedLeavesController extends GetxController {
  var stateLeaveRequestModel = <AppliedLeaveModel>[].obs;

  updateLeaveRequestModel(AppliedLeaveModel obj) {
    print("updateing ${obj.toJson()}");
    stateLeaveRequestModel.add(obj);
  }

  Future<bool> getLeaveRequestModel(String userid) async {
    print("init $userid");
    var res =
        await AppliedLeavesApi(
          userid: userid
          ).callApi();

    if (res.statusCode == 201) {
      var body = res.body;
      final decodedbody = jsonDecode(body);
      // print(" ${decodedbody["status"]}");
      // print(" ---$body");

      if (decodedbody["status"]) {
        print(decodedbody["status"]);
        //UserModel userData = UserModel(data: body["data"],status: body["status"],message: body["message"]).fromJson;
        AppliedLeaveModel userData = appliedLeaveModelFromJson(body.toString());

        print("object AppliedLeaveModel ${userData.toJson()}");
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
