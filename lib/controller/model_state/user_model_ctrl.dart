import 'dart:convert';
import 'package:attendance/model/user_model.dart';
import 'package:attendance/service/services_api/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModelController extends GetxController {
  var stateUserModel = <UserModel>[].obs;
  var reportingPersonName = "".obs;
  var reportingPersonToken = "".obs;

  updateUserModel(UserModel obj) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString("userModel", jsonEncode(obj));

    stateUserModel.add(obj);
    reportingPersonName.value = await GetReportingPerson(
            userid: stateUserModel.last.data[0].reportPerson)
        .callApi();
    reportingPersonToken.value = await GetReportingPerson(
            userid: stateUserModel.last.data[0].reportPerson)
        .getReportinPersonToken();
  }

  String getUserId() {
    return stateUserModel.last.data[0].userid;
  }

  String getBranchId() {
    return stateUserModel.last.data[0].branchid;
  }
}
