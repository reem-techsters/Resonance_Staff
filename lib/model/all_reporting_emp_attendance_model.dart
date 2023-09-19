// To parse required this JSON data, do
//
//     final AllReportingEmpAttendanceModel = AllReportingEmpAttendanceModelFromJson(jsonString);

import 'package:attendance/controller/model_state/my_attendance_ctrl.dart';
import 'package:attendance/controller/model_state/reporting_employee_ctrl.dart';
import 'package:get/get.dart';
import 'my_attendance_model.dart';

class AllReportingEmpAttendanceModel {
  ReportingEmployeeController reportingEmpCtrl =
      Get.put(ReportingEmployeeController());
  MyAttendanceModelController myAttendanceCtrl =
      Get.put(MyAttendanceModelController());

  Future<List<MyAttendanceModel>> getAllEmpAttendance(
    List data, {
    fromDate = "null",
    toDate = "null",
  }) async {
    List<MyAttendanceModel> dataReturn = [];

    for (var element in data) {
      await myAttendanceCtrl
          .getMyAttendance(element.userid, fromDate: fromDate, toDate: toDate)
          .then((value) {
        dataReturn.add(myAttendanceCtrl.stateMyAttendanceModel.last);
        print("before" + dataReturn.length.toString());
      });
    }

    print(" after" + dataReturn.length.toString());
    return dataReturn;
  }
}
