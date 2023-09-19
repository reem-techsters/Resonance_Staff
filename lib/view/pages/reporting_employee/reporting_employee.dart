import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/my_attendance_ctrl.dart';
import 'package:attendance/controller/model_state/reporting_employee_ctrl.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/view/widgets/buttons.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/preLoader.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/reporting_employee_card.dart';

class ReportingEmployee extends StatefulWidget {
  const ReportingEmployee({super.key});

  @override
  State<ReportingEmployee> createState() => _ReportingEmployeeState();
}

class _ReportingEmployeeState extends State<ReportingEmployee> {
  TextEditingController nullCtrl = TextEditingController();

  List drawerItems = Strings.drawerRoutes;
  ReportingEmployeeController ReportingEmployeeCtrl =
      Get.put(ReportingEmployeeController());
  MyAttendanceModelController MyAttendanceModelCtrl =
      Get.put(MyAttendanceModelController());

  UserModelController userModelCtrl = Get.find<UserModelController>();

  late Future<bool> _getReportingEmployee;

  // late List<Data> employeeList;

  @override
  // ignore: must_call_super
  initState() {
    _getReportingEmployee =
        ReportingEmployeeCtrl.getReportingEmployee(userModelCtrl.getUserId());
    // ignore: avoid_print
    print("ReportingEmployee initState Called");
    // ReportingEmployeeCtrl.getReportingEmployee("6611");

    // employeeList = ReportingEmployeeCtrl.stateReportingEmployeeModel.last.data;
    //employeeName = ReportingEmployeeCtrl.stateReportingEmployeeModel.last.data[0].username;
    //userId = ReportingEmployeeCtrl.stateReportingEmployeeModel.last.data[0].userid;
    //employeeid = ReportingEmployeeCtrl.stateReportingEmployeeModel.last.data[0].employeeid;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: CustomDrawer(),
      // drawer: CustomDrawer( drawerItems: drawerItems),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CustomAppBar(Strings.reportingEmp),
        FutureBuilder(
            future: _getReportingEmployee,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text("No data available"));
                } else if (snapshot.hasData) {
                  if (ReportingEmployeeCtrl
                      .stateReportingEmployeeModel.last.data.isNotEmpty) {
                    return Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        child: Obx(
                          () => ListView.builder(
                              itemCount: ReportingEmployeeCtrl
                                  .stateReportingEmployeeModel.last.data.length,
                              itemBuilder: (context, i) {
                                return ReportEmployeeCardWidget(
                                  index: i,
                                  ctrl: ReportingEmployeeCtrl,
                                );
                              }),
                        ),
                      ),
                    ));
                  } else {
                    return CustomError.noData();
                  }
                } else {
                  return CustomError.noData();
                }
              } else {
                return Preloader.circular(context);
              }
            })
      ]),
    ));
  }

  Column dialogChild(context, TextEditingController ctrl) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                child: attendanceCard(context,
                    title: Strings.login, data: "12345", function: () {}),
              ),
              attendanceCard(context,
                  title: Strings.logout, data: "12345", function: () {})
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Reason for ${Strings.lateLogin}",
          style: Styles.poppinsBold.copyWith(color: Colors.black),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Buttons.blueButtonReason(Strings.approve, () {}),
            SizedBox(
              width: 10,
            ),
            Buttons.redButtonReason("   ${Strings.reject}   ", () {}),
          ],
        )
      ],
    );
  }

  Column absentDialogChild(context, TextEditingController ctrl) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Absent 12-12-22",
          style: Styles.poppinsBold.copyWith(color: Colors.black),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Buttons.blueButtonReason(Strings.approve, () {}),
            SizedBox(
              width: 10,
            ),
            Buttons.redButtonReason("   ${Strings.reject}   ", () {}),
          ],
        )
      ],
    );
  }

  Card attendanceCard(BuildContext context,
      {String? title, String? data, var function}) {
    double width = Strings.width(context);
    double height = Strings.width(context);
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Strings.primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),

      shadowColor: Colors.black,

      child: SizedBox(
        width: width / 3,
        height: height / 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ), //SizedBox
              Text(
                title!,
                style: Styles.poppinsBold
                    .copyWith(color: Colors.black), //Textstyle
              ), //Text
              const SizedBox(
                height: 5,
              ), //SizedBox
              CustomRichText.customRichText("", data!), //Text
            ],
          ), //Column
        ), //Padding
      ), //SizedBox
    );
  }
}
