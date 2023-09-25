import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/my_attendance_ctrl.dart';
import 'package:attendance/controller/model_state/reporting_employee_ctrl.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/controller/widget_state/log_ctrl.dart';
import 'package:attendance/model/all_reporting_emp_attendance_model.dart';
import 'package:attendance/model/my_attendance_model.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:attendance/view/widgets/preLoader.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:attendance/model/regularisation_model.dart';
import 'package:get/get.dart';

class RegulariseSearchScreen extends StatefulWidget {
  final List<ToRegularise> regulList;
  final String title;
  const RegulariseSearchScreen({
    Key? key,
    required this.title,
    required this.regulList,
  });

  @override
  State<RegulariseSearchScreen> createState() => _RegulariseSearchScreenState();
}

class _RegulariseSearchScreenState extends State<RegulariseSearchScreen> {
  final myAttendanceCtrl = Get.put(MyAttendanceModelController());
  late DateTime intialDate;
  final userModelCtrl = Get.find<UserModelController>();
  // bool loading = true;
  AsyncSnapshot<dynamic> globalSnapshot = AsyncSnapshot.waiting();
  final logStateCtrl = Get.put(LogController());
  String selectedMonth = "Last 30 days";

  TextEditingController nullCtrl = TextEditingController();
  TextEditingController fromCtrl = TextEditingController();
  TextEditingController toCtrl = TextEditingController();
  bool dateChanged = false;

  late Future<dynamic> getToRegulariseAttend = Future<bool>.value(true);
  late Future<List<MyAttendanceModel>> allReportingEmpAttendanceModel;
  ReportingEmployeeController reportingEmployeeCtrl =
      Get.put(ReportingEmployeeController());

  final searchCtrl = TextEditingController();

  List<ToRegularise> searchData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            searchData.clear();
            searchCtrl.clear();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.title,
        ),
        backgroundColor: Strings.primaryColor,
      ),
      body: widget.regulList.isEmpty
          ? Column(children: const [Text('context')])
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    autofocus: true,
                    controller: searchCtrl,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Strings.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Strings.primaryColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Strings.primaryColor),
                      ),
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Strings.primaryColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    onChanged: (value) async {
                      log('inside');
                      log('regulList --> ${widget.regulList.toString()}');

                      setState(() {
                        searchData.clear();
                        for (var i in widget.regulList) {
                          if (i.name
                              .toString()
                              .toLowerCase()
                              .contains(value.toLowerCase())) {
                            log('inside2');
                            ToRegularise data = ToRegularise(
                                employeeid: i.employeeid,
                                name: i.name,
                                branchid: i.branchid,
                                inOut: i.inOut,
                                uniid: i.uniid,
                                inOutTime: i.inOutTime,
                                attendanceId: i.attendanceId,
                                date: i.date,
                                reason: i.reason,
                                lateLoginReason: i.lateLoginReason,
                                earlyLoginReason: i.earlyLoginReason,
                                loginregularised: i.loginregularised,
                                logoutregularised: i.logoutregularised,
                                isLatelogin: i.isLatelogin,
                                isEarlyLogout: i.isEarlyLogout);
                            searchData.add(data);
                          }
                        }
                      });
                      log(searchData.toString());
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final dataList = searchData[index];
                      String log = searchData[index].inOut == "0"
                          ? "regularizelogin"
                          : "regularizelogout";
                      return dataList.name!
                              .toLowerCase()
                              .contains(searchCtrl.text.toLowerCase())
                          // ? Text(data.name.toString())
                          ? Card(
                              color: Color.fromRGBO(246, 244, 238, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomRichText.customRichText(
                                        "Type :",
                                        dataList!.inOut == "0"
                                            ? "Late Login"
                                            : "Early Logout"),
                                    CustomRichText.customRichText(
                                        "Employee Name :", dataList!.name!),
                                    CustomRichText.customRichText(
                                      "Date :",
                                      dataList!.date!,
                                    ),
                                    dataList!.loginregularised != "1" &&
                                            dataList!.loginregularised != "0"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                                CustomRichText.customRichText(
                                                    "Late Login ${Strings.reason} :",
                                                    dataList.lateLoginReason!),
                                                SizedBox(height: 10.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    //------------------------------APPROVE BTN
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        try {
                                                          CustomDialog
                                                              .showDialogTransperent(
                                                                  context);
                                                          http.Response res =
                                                              await http.get(
                                                                  Uri.parse(
                                                                      "${Strings.baseUrl}$log?attendanceId=${dataList.attendanceId}&regularised=1"));
                                                          print(
                                                              "login REGULARISED api called ${res.statusCode}");

                                                          if (res.statusCode ==
                                                              201) {
                                                            Navigator.pop(
                                                                context);

                                                            var body =
                                                                jsonDecode(
                                                                    res.body);
                                                            if (body[
                                                                "status"]) {
                                                              MyAttendanceModelController()
                                                                  .loadresources(
                                                                      true);
                                                              CustomSnackBar
                                                                  .atBottom(
                                                                title: "Status",
                                                                body: log,
                                                              );
                                                            } else {
                                                              CustomSnackBar.atBottom(
                                                                  title:
                                                                      "Status",
                                                                  body:
                                                                      "Failed",
                                                                  status:
                                                                      false);
                                                            }
                                                          } else {
                                                            Navigator.pop(
                                                                context);
                                                            CustomSnackBar
                                                                .atBottom(
                                                                    title:
                                                                        "Status",
                                                                    body:
                                                                        "Failed",
                                                                    status:
                                                                        false);
                                                          }
                                                        } catch (e) {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                          print("OTP error$e");
                                                        }
                                                      },
                                                      style: Styles.blueButton,
                                                      child: Text(
                                                          style: Styles
                                                              .latoButtonText,
                                                          "Approve"),
                                                    ),
                                                    SizedBox(
                                                      width: Strings.width(
                                                              context) /
                                                          15,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        try {
                                                          CustomDialog
                                                              .showDialogTransperent(
                                                                  context);
                                                          http.Response res =
                                                              await http.get(
                                                                  Uri.parse(
                                                                      "${Strings.baseUrl}$log?attendanceId=${dataList.attendanceId}&regularised=0"));
                                                          print(
                                                              "login REGULARISED api called ${res.statusCode}");

                                                          if (res.statusCode ==
                                                              201) {
                                                            Navigator.pop(
                                                                context);

                                                            var body =
                                                                jsonDecode(
                                                                    res.body);
                                                            if (body[
                                                                "status"]) {
                                                              CustomSnackBar.atBottom(
                                                                  title:
                                                                      "Status",
                                                                  body:
                                                                      "Request Rejected");
                                                            } else {
                                                              CustomSnackBar.atBottom(
                                                                  title:
                                                                      "Status",
                                                                  body:
                                                                      "Failed",
                                                                  status:
                                                                      false);
                                                            }
                                                          } else {
                                                            Navigator.pop(
                                                                context);
                                                            CustomSnackBar
                                                                .atBottom(
                                                                    title:
                                                                        "Status",
                                                                    body:
                                                                        "Failed",
                                                                    status:
                                                                        false);
                                                          }
                                                        } catch (e) {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                          print("OTP error$e");
                                                        }
                                                      },
                                                      style: Styles.redButton,
                                                      child: Text(
                                                          style: Styles
                                                              .latoButtonText,
                                                          "   Reject   "),
                                                    )
                                                  ],
                                                ),
                                                // RegularisationButton(
                                                //   index: index,
                                                //   dataList: dataList,
                                                // ),
                                                SizedBox(height: 10.0),
                                              ])
                                        : SizedBox(),
                                    dataList.logoutregularised != "1" &&
                                            dataList.logoutregularised != "0"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomRichText.customRichText(
                                                  "Early Logout ${Strings.reason} :",
                                                  dataList.earlyLoginReason!),
                                              SizedBox(height: 10.0),
                                              // RegularisationButton(
                                              //   index: index,
                                              //   dataList: dataList,
                                              // )
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  //------------------------------APPROVE BTN
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      try {
                                                        CustomDialog
                                                            .showDialogTransperent(
                                                                context);
                                                        http.Response res =
                                                            await http.get(
                                                                Uri.parse(
                                                                    "${Strings.baseUrl}$log?attendanceId=${dataList.attendanceId}&regularised=1"));
                                                        print(
                                                            "login REGULARISED api called ${res.statusCode}");

                                                        if (res.statusCode ==
                                                            201) {
                                                          Navigator.pop(
                                                              context);

                                                          var body = jsonDecode(
                                                              res.body);
                                                          if (body["status"]) {
                                                            MyAttendanceModelController()
                                                                .loadresources(
                                                                    true);
                                                            CustomSnackBar
                                                                .atBottom(
                                                              title: "Status",
                                                              body: log,
                                                            );
                                                          } else {
                                                            CustomSnackBar
                                                                .atBottom(
                                                                    title:
                                                                        "Status",
                                                                    body:
                                                                        "Failed",
                                                                    status:
                                                                        false);
                                                          }
                                                        } else {
                                                          Navigator.pop(
                                                              context);
                                                          CustomSnackBar
                                                              .atBottom(
                                                                  title:
                                                                      "Status",
                                                                  body:
                                                                      "Failed",
                                                                  status:
                                                                      false);
                                                        }
                                                      } catch (e) {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        print("OTP error$e");
                                                      }
                                                    },
                                                    style: Styles.blueButton,
                                                    child: Text(
                                                        style: Styles
                                                            .latoButtonText,
                                                        "Approve"),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        Strings.width(context) /
                                                            15,
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      try {
                                                        CustomDialog
                                                            .showDialogTransperent(
                                                                context);
                                                        http.Response res =
                                                            await http.get(
                                                                Uri.parse(
                                                                    "${Strings.baseUrl}$log?attendanceId=${dataList.attendanceId}&regularised=0"));
                                                        print(
                                                            "login REGULARISED api called ${res.statusCode}");

                                                        if (res.statusCode ==
                                                            201) {
                                                          Navigator.pop(
                                                              context);

                                                          var body = jsonDecode(
                                                              res.body);
                                                          if (body["status"]) {
                                                            CustomSnackBar.atBottom(
                                                                title: "Status",
                                                                body:
                                                                    "Request Rejected");
                                                          } else {
                                                            CustomSnackBar
                                                                .atBottom(
                                                                    title:
                                                                        "Status",
                                                                    body:
                                                                        "Failed",
                                                                    status:
                                                                        false);
                                                          }
                                                        } else {
                                                          Navigator.pop(
                                                              context);
                                                          CustomSnackBar
                                                              .atBottom(
                                                                  title:
                                                                      "Status",
                                                                  body:
                                                                      "Failed",
                                                                  status:
                                                                      false);
                                                        }
                                                      } catch (e) {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        print("OTP error$e");
                                                      }
                                                    },
                                                    style: Styles.redButton,
                                                    child: Text(
                                                        style: Styles
                                                            .latoButtonText,
                                                        "   Reject   "),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ))
                          : SizedBox();
                    },
                    itemCount: searchData.length,
                  ),
                ),
              ],
            ),
    );
  }
}
