import 'dart:convert';

import 'package:attendance/model/reporting_employee_model.dart';
import 'package:attendance/model/user_model.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:attendance/model/user_model.dart';

import '../../service/services_api/api.dart';
import '../../model/my_attendance_model.dart';

class ReportingEmployeeController extends GetxController {
  var stateReportingEmployeeModel = <ReportingEmployeeModel>[].obs;

  updateReportingEmployeeModel(ReportingEmployeeModel obj) {
    stateReportingEmployeeModel.add(obj);
  }

  Future<bool> getReportingEmployee(String userid) async {
    print("repotingEmp $userid");
    var res = await ReportingEmployeeApi(userid: userid).callApi();

    if (res.statusCode == 201) {
      var body = res.body;
      print(" repotingEmp---$body");

          final decodedbody = jsonDecode(body);
      print(" ${decodedbody["status"]}");
      print("getReportingEmployee ---$body");

      if (decodedbody["status"]) { 
      
      //UserModel userData = UserModel(data: body["data"],status: body["status"],message: body["message"]).fromJson;
      ReportingEmployeeModel userData =
          reportingEmployeeModelFromJson(body.toString());
      await updateReportingEmployeeModel(userData);
      update();
      return true;
    }
    else{
      CustomSnackBar.atBottom(title: "Eeporting employee", body: "error",status: false);
      return false;
    }
    } else {

       CustomSnackBar.atBottom(
          title: "Reporting employee",
          body: res.statusCode.toString(),
          status: false);
      return false;
    }
  }
}
