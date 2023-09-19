import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/model/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserData {
  UserModelController UserModelCtrl = Get.find<UserModelController>();
  String? user = "";

  getSf(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = prefs.getString(key);
  }

  String getUserId() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      return UserModelCtrl.getUserId();
    } else {
      getSf(Strings.login);
      return user!;
    }
  }

  String getUserBranch() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      return UserModelCtrl.stateUserModel.last.data[0].branchid;
    } else {
      throw "";
    }
  }

  String getRoleId() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      print(
          'inside getroleid --> ${UserModelCtrl.stateUserModel.last.data[0].roleid}');
      return UserModelCtrl.stateUserModel.last.data[0].roleid;
    } else {
      throw "";
    }
  }

  String getUserName() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      return UserModelCtrl.stateUserModel.last.data[0].name;
    } else {
      throw "";
    }
  }

  String getUserFcm() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      return UserModelCtrl.stateUserModel.last.data[0].firebase;
    } else {
      throw "";
    }
  }
  String getJoiningDate() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      return UserModelCtrl.stateUserModel.last.data[0].joiningdate;
    } else {
      throw "";
    }
  }

  String getEmpCode() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      return UserModelCtrl.stateUserModel.last.data[0].employeeid;
    } else {
      throw "";
    }
  }

  String getReporingId() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      return UserModelCtrl.stateUserModel.last.data[0].employeeid;
    } else {
      throw "";
    }
  }

  Data getCurrentUser() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      return UserModelCtrl.stateUserModel.last.data[0];
    } else {
      throw "";
    }
  }

  String getReportingPerson() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      return UserModelCtrl.reportingPersonName.value;
    } else {
      return "null";
    }
  }

  String getReportingPersonToken() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      return UserModelCtrl.reportingPersonToken.value;
    } else {
      return "null";
    }
  }

  String getUserPhone() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      return UserModelCtrl.stateUserModel.last.data[0].mobile;
    } else {
      throw "";
    }
  }

  String branchId() {
    if (UserModelCtrl.stateUserModel.last.data.isNotEmpty) {
      return UserModelCtrl.stateUserModel.last.data[0].branchid;
    } else {
      throw "";
    }
  }
}
