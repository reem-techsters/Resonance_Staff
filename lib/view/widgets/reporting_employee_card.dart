import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/reporting_employee_ctrl.dart';
import 'package:attendance/routes/getRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ReportEmployeeCardWidget extends StatelessWidget {
  final int index;
  final ReportingEmployeeController ctrl;
  const ReportEmployeeCardWidget(
      {super.key, required this.index, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color.fromRGBO(246, 244, 238, 1),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Strings.width(context) / 4,
                height: Strings.height(context) / 12,
                child: Image.network(
                    fit: BoxFit.fill,
                    'https://picsum.photos/seed/picsum/200/300'),
              ),
              //1
              SizedBox(width: 30),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: ctrl.stateReportingEmployeeModel.last
                                    .data[index].name,
                                style: Styles.poppinsBold.copyWith(
                                  fontSize: 20,
                                  color: Colors.black,
                                ))),
                      ),
                      Obx(
                        () => RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text:
                                    "${Strings.employeeCode}: ${ctrl.stateReportingEmployeeModel.last.data[index].employeeid}",
                                style: Styles.poppinsBold.copyWith(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: " ",
                                    style: Styles.poppinsRegular,
                                  ),
                                ])),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pushNamed(
                              context, GetRoutes.pageEmployeeAttendance,
                              arguments: ctrl.stateReportingEmployeeModel.last
                                  .data[index].userid);
                        },
                        style: Styles.blueButton,
                        child: Text(
                          "View Attendance",
                          style: Styles.latoButtonText,
                        ),
                      ),
                      //  ),
                    ]),
              ),
            ],
          ),
        ));
  }
}
