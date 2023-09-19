import 'dart:convert';
import 'dart:developer';
// import 'dart:developer';

import 'package:attendance/controller/model_state/my_attendance_ctrl.dart';
import 'package:attendance/controller/widget_state/log_ctrl.dart';
import 'package:attendance/model/my_attendance_model.dart';
import 'package:attendance/view/pages/apply_leaves.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/preLoader.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../service/services_api/api.dart';
import '../../constant/strings.dart';
import '../../controller/model_state/user_model_ctrl.dart';
import '../widgets/buttons.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_icon.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/custom_text_filed.dart';
import '../widgets/datePickerDialog.dart';
import '../widgets/richText.dart';

class MyAttendance extends StatefulWidget {
  @override
  State<MyAttendance> createState() => _MyAttendanceState();
}

class _MyAttendanceState extends State<MyAttendance> {
  final myAttendanceCtrl = Get.put(MyAttendanceModelController());
  late DateTime intialDate;
  final userModelCtrl = Get.find<UserModelController>();

  final logStateCtrl = Get.put(LogController());
  String selectedMonth = "Last 30 days";

  TextEditingController nullCtrl = TextEditingController();
  TextEditingController fromCtrl = TextEditingController();
  TextEditingController toCtrl = TextEditingController();
  late Future<bool> _getAttendance;
  bool dateChanged = false;

  @override
  void initState() {
    myAttendanceCtrl.biometricList();
    // dropdownvalue = 'Select type';
    getLastNDates();
    super.initState();
    intialDate = DateTime.now();
    _getAttendance = myAttendanceCtrl
        .getMyAttendance(userModelCtrl.stateUserModel.last.data[0].userid);
  }

  GlobalKey<FormState> formSubmitGlobalKey = GlobalKey<FormState>();
  List<DateTime> getLastNDates() {
    DateTime currentDateTime = DateTime.now();
    List<DateTime> lastNDates = [];

    for (int i = 0; i < 6; i++) {
      DateTime date = currentDateTime.subtract(Duration(days: i));
      lastNDates.add(date);
    }

    return lastNDates;
  }

  String? submitValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This is required';
    } else {
      return null;
    }
  }

// Your items list
  // var items = [];
  var items = ['Select type', '1', '2'];
  // var items = [
  //   'Select type',
  //   MyAttendanceModelController().parentConcernlist[0],
  //   MyAttendanceModelController().parentConcernlist[1],
  // ];
  @override
  Widget build(BuildContext context) {
    double interPad = 15.0;
    double width = Strings.width(context);
    double height = Strings.height(context);
    print(
        "length-- ${myAttendanceCtrl.stateMyAttendanceModel.last.data.length}");
    return SafeArea(
        child: Scaffold(
            drawer: CustomDrawer(),
            body: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => CustomAppBar(
                        userModelCtrl.stateUserModel.last.data[0].name)),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 0, left: 0.0, right: 0.0),
                      child: GestureDetector(
                        onTap: filterDate,
                        child: Container(
                          color: Colors.white,
                          height: height / 20,

                          // decoration: Strings.roundBoxDecoration.copyWith(
                          //   borderRadius: BorderRadius.circular(5.0),
                          //   boxShadow: []
                          // ),

                          child: Row(children: [
                            SizedBox(
                              width: 25,
                            ),
                            !dateChanged
                                ? Text(
                                    "Last 30 days",
                                    textAlign: TextAlign.end,
                                  )
                                : Text(
                                    "${fromCtrl.text} to ${toCtrl.text}",
                                    textAlign: TextAlign.end,
                                  ),
                            SizedBox(
                              width: 20,
                            ),
                            Spacer(),

                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8.0),
                              child: VerticalDivider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),

                            // ignore: prefer_const_literals_to_create_immutables
                            Icon(Icons.filter_list),
                            SizedBox(width: 10.0),
                            Text("Filter"),
                            SizedBox(width: 20.0),
                          ]),
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: _getAttendance,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Preloader.circular(context);
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              if (myAttendanceCtrl.stateMyAttendanceModel.last
                                  .data.isNotEmpty) {
                                return buildItems(height, width);
                              } else {
                                return CustomError.noData();
                              }
                            } else {
                              return CustomError.noData();
                            }
                          } else {
                            return CustomError.noData();
                          }

                          // return buildItems(height, width);
                        })
                  ]),
            )));
  }

  Expanded buildItems(double height, double width) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
        child: SizedBox(
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _getAttendance = myAttendanceCtrl.getMyAttendance(
                    userModelCtrl.stateUserModel.last.data[0].userid);
              });
            },
            child: Obx(
              () => ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.white,
                      height: height / 40,
                      thickness: 0,
                    );
                  },
                  itemCount:
                      myAttendanceCtrl.stateMyAttendanceModel.last.data.length,
                  itemBuilder: (context, i) {
                    bool regPending = myAttendanceCtrl
                                .stateMyAttendanceModel.last.data[i].isLatelogin
                                .toString() ==
                            "1" ||
                        myAttendanceCtrl.stateMyAttendanceModel.last.data[i]
                                    .isEarlyLogout
                                    .toString() ==
                                "1" &&
                            myAttendanceCtrl.stateMyAttendanceModel.last.data[i]
                                    .loginregularised
                                    .toString() ==
                                "null" ||
                        myAttendanceCtrl.stateMyAttendanceModel.last.data[i]
                                .loginregularised
                                .toString() ==
                            "null";

                    return GestureDetector(
                      onTap: () {
                        print("index $i");
                        myAttendanceCtrl.notloginController.clear();
                        myAttendanceCtrl.dropdownvalue = 'Select type';
                        CustomDialog.customDialog(
                            dialogChild(context, nullCtrl, i),
                            // dialogChild(context, nullCtrl),
                            context,
                            dialogClose);
                      },
                      child: ListTile(
                        tileColor: Color.fromRGBO(246, 244, 238, 1),
                        leading: Obx(
                          () => CustomRichText.customRichText(
                              "Date",
                              myAttendanceCtrl
                                  .stateMyAttendanceModel.last.data[i].date
                                  .toString()),
                        ),

                        title: Obx(
                          () => Text(
                            (myAttendanceCtrl.stateMyAttendanceModel.last.data[i].status == "0" &&
                                    myAttendanceCtrl.stateMyAttendanceModel.last
                                            .data[i].absentregularised ==
                                        "0"
                                ? 'Absent Regularization Pending'
                                : myAttendanceCtrl.stateMyAttendanceModel.last.data[i].status == "0" &&
                                        myAttendanceCtrl
                                                .stateMyAttendanceModel
                                                .last
                                                .data[i]
                                                .absentregularised ==
                                            "1"
                                    ? 'Absent Regularization Approved'
                                    : myAttendanceCtrl.stateMyAttendanceModel.last.data[i].status == "0" &&
                                            myAttendanceCtrl
                                                    .stateMyAttendanceModel
                                                    .last
                                                    .data[i]
                                                    .absentregularised ==
                                                "2"
                                        ? 'Absent Regularization Rejected'
                                        : myAttendanceCtrl.stateMyAttendanceModel.last.data[i].status == "0" &&
                                                myAttendanceCtrl
                                                        .stateMyAttendanceModel
                                                        .last
                                                        .data[i]
                                                        .absentregularised ==
                                                    "null"
                                            ? ''
                                            : myAttendanceCtrl.stateMyAttendanceModel.last.data[i].isLatelogin.toString() == "1" &&
                                                        myAttendanceCtrl.stateMyAttendanceModel.last.data[i].loginregularised.toString() ==
                                                            "null" ||
                                                    myAttendanceCtrl.stateMyAttendanceModel.last.data[i].isEarlyLogout.toString() == "1" && myAttendanceCtrl.stateMyAttendanceModel.last.data[i].logoutregularised.toString() == "null"
                                                ? "Regularization Pending"
                                                : myAttendanceCtrl.stateMyAttendanceModel.last.data[i].isLatelogin.toString() == "1" || myAttendanceCtrl.stateMyAttendanceModel.last.data[i].isEarlyLogout.toString() == "1" && myAttendanceCtrl.stateMyAttendanceModel.last.data[i].loginregularised.toString() != "null" || myAttendanceCtrl.stateMyAttendanceModel.last.data[i].loginregularised.toString() != "null"
                                                    ? "Regularized"
                                                    : ""),
                            style: Styles.poppinsRegular.copyWith(
                                color: regPending
                                    ? Strings.ColorRed
                                    : Strings.ColorBlue,
                                fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // Text("Regulaization Pending",style: Styles.poppinsRegular.copyWith(color: Strings.ColorRed,fontSize: 12),),

                        // title: Obx(
                        //   () => Text(
                        //     // myAttendanceCtrl.stateMyAttendanceModel.last.data[i]
                        //     //     .loginregularised
                        //     //     .toString(),
                        //     myAttendanceCtrl.stateMyAttendanceModel.last.data[i]
                        //         .loginregularised
                        //         .toString(),
                        //     style: Styles.poppinsRegular
                        //         .copyWith(color: Strings.ColorBlue, fontSize: 12),
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),

                        // Icon(Icons.check_circle,color: Strings.ColorBlue,size:width/10),
                        trailing: Obx(
                          () => (myAttendanceCtrl.stateMyAttendanceModel.last
                                      .data[i].status ==
                                  "1")
                              ? CustomIcon.iconCheck(width)
                              : CustomIcon.iconClose(width, height),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }

  dialogClose() {
    logStateCtrl.updateLogState(true);
    nullCtrl = TextEditingController();
  }

  filterDate() {
    CustomDatePickerDialog(intialDate: intialDate)
        .datePicker(context, fromCtrl, toCtrl, () {})
        .then((value) {
//filter function
      print('${fromCtrl.text} &&${toCtrl.text}');
      intialDate = value!;
      myAttendanceCtrl.filterAttendance(
          context, userModelCtrl.stateUserModel.last.data[0].userid,
          fromDate: fromCtrl.text, toDate: toCtrl.text);

      setState(() {
        if (!dateChanged) {
          dateChanged = true;
        }
      });
    });
  }
  // void openFilterDelegate() async {
  //   await FilterListDelegate.show(
  //     context: context,
  //     list: ['Last 30 days','January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
  //     enableOnlySingleSelection: true,
  //     onItemSearch: (data, query) {
  //       print("data ${data.toString()} query $query");
  //       return data.toString().toLowerCase().contains(query.toLowerCase());
  //     },
  //     tileLabel: (user) => user.toString(),
  //     emptySearchChild: Center(child: Text('No user found')),
  //     searchFieldHint: 'Search Here..',
  //     onApplyButtonClick: (list) {

  //       print("onApplyButtonClick ${list.toString()}");
  //       selectedMonth = list![0].toString();
  //       // Do something with selected list
  //     },
  //   );
  // }

  Form dialogChild(context, TextEditingController ctrl, int index) {
    return Form(
      key: formSubmitGlobalKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    print("log switched");
                    logStateCtrl.updateLogState(true);
                    ctrl = TextEditingController();
                  },
                  child: Obx(
                    () => attendanceLoginCard(
                      context,
                      title: myAttendanceCtrl.stateMyAttendanceModel.last
                                  .data[index].isLatelogin ==
                              "1"
                          ? "Late ${Strings.login}"
                          : Strings.login,
                      data: myAttendanceCtrl.stateMyAttendanceModel.last
                                  .data[index].loginTime
                                  .toString() !=
                              "null"
                          ? myAttendanceCtrl
                              .stateMyAttendanceModel.last.data[index].loginTime
                              .toString()
                              .split(" ")[1]
                          : "----",
                      color: logStateCtrl.logState.value
                          ? Strings.ColorBlue
                          : Strings.bgColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: InkWell(
                onTap: () {
                  print("log switched");
                  logStateCtrl.updateLogState(false);
                  ctrl = TextEditingController();
                },
                child: Obx(
                  () => attendanceLoginCard(
                    //title, data
                    context,
                    title: myAttendanceCtrl.stateMyAttendanceModel.last
                                .data[index].isEarlyLogout ==
                            "1"
                        ? "Early ${Strings.logout}"
                        : Strings.logout,
                    data: myAttendanceCtrl.stateMyAttendanceModel.last
                                .data[index].logoutTime
                                .toString() ==
                            "null"
                        ? "----"
                        : myAttendanceCtrl
                            .stateMyAttendanceModel.last.data[index].logoutTime
                            .toString()
                            .split(" ")[1],
                    color: logStateCtrl.logState.value
                        ? Strings.bgColor
                        : Strings.ColorBlue,
                    //textColor: !logStateCtrl.logState.value?Colors.white: Colors.black),
                  ),
                ),
              ))
            ],
          ),
          SizedBox(height: 15.0),
          myAttendanceCtrl.stateMyAttendanceModel.last.data[index].status == '0'
              ? Obx(
                  () => Visibility(
                    visible: (myAttendanceCtrl.stateMyAttendanceModel.last
                                .data[index].isLatelogin
                                .toString() ==
                            "0") ||
                        (myAttendanceCtrl.stateMyAttendanceModel.last
                                .data[index].isEarlyLogout
                                .toString() ==
                            "0"),
                    child: GetBuilder<MyAttendanceModelController>(
                      init: MyAttendanceModelController(),
                      builder: (controller) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Absent Type',
                                  style: Styles.poppinsBold.copyWith(
                                      color: getLastNDates()
                                              .toString()
                                              .contains(myAttendanceCtrl
                                                  .stateMyAttendanceModel
                                                  .last
                                                  .data[index]
                                                  .date)
                                          ? Colors.black
                                          : Colors.grey.shade400),
                                ),
                              ],
                            ),
                            getLastNDates().toString().contains(myAttendanceCtrl
                                    .stateMyAttendanceModel
                                    .last
                                    .data[index]
                                    .date)
                                ? StatefulBuilder(
                                    builder: (context, setState) {
                                      return DropdownButton(
                                        value: controller.dropdownvalue,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: controller.biometrics
                                            .map((String item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                  color: item == 'Select type'
                                                      ? Colors.grey
                                                      : Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          if (newValue != 'Select type') {
                                            setState(() {
                                              controller.dropdownvalue =
                                                  newValue!;
                                              // log(controller.dropdownvalue.toString());
                                            });
                                          } else {
                                            controller.dropdownvalue = 'null';
                                          }
                                        },
                                      );
                                    },
                                  )
                                : SizedBox(),
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Reason',
                                  style: Styles.poppinsBold.copyWith(
                                      color: getLastNDates()
                                              .toString()
                                              .contains(myAttendanceCtrl
                                                  .stateMyAttendanceModel
                                                  .last
                                                  .data[index]
                                                  .date)
                                          ? Colors.black
                                          : Colors.grey.shade400),
                                ),
                              ],
                            ),
                            CustomTextField.textField(
                              controller.notloginController,
                              myAttendanceCtrl.stateMyAttendanceModel.last
                                          .data[index].absentregularised ==
                                      null
                                  ? 'Enter Reason'
                                  : 'Absent Type: ${myAttendanceCtrl.stateMyAttendanceModel.last.data[index].absenttype}\nAbsent Reason: ${myAttendanceCtrl.stateMyAttendanceModel.last.data[index].absentReason}',
                              enabled: getLastNDates().toString().contains(
                                          myAttendanceCtrl
                                              .stateMyAttendanceModel
                                              .last
                                              .data[index]
                                              .date) &&
                                      myAttendanceCtrl
                                              .stateMyAttendanceModel
                                              .last
                                              .data[index]
                                              .absentregularised ==
                                          null
                                  ? true
                                  : false,
                            ),
                            SizedBox(height: 2.0),
                            ElevatedButton(
                                onPressed: getLastNDates().toString().contains(
                                            myAttendanceCtrl
                                                .stateMyAttendanceModel
                                                .last
                                                .data[index]
                                                .date) &&
                                        myAttendanceCtrl
                                                .stateMyAttendanceModel
                                                .last
                                                .data[index]
                                                .absentregularised ==
                                            null
                                    ? () async {
                                        if (controller.notloginController.text
                                            .isNotEmpty) {
                                          if (controller.dropdownvalue !=
                                              'Select type') {
                                            CustomDialog.showDialogTransperent(
                                                context);

                                            await myAttendanceCtrl.addAbsent(
                                              context,
                                              myAttendanceCtrl
                                                  .stateMyAttendanceModel
                                                  .last
                                                  .data[index]
                                                  .attendanceId,
                                              controller.dropdownvalue,
                                              controller
                                                  .notloginController.text,
                                            );
                                            Navigator.pop(context);
                                          } else {
                                            CustomSnackBar.atBottom(
                                                title: "Biometric",
                                                body: 'This is required',
                                                status: false);
                                          }
                                        } else {
                                          CustomSnackBar.atBottom(
                                              title: "Reason",
                                              body: 'This is required',
                                              status: false);
                                        }
                                      }
                                    : null,
                                child: Text('Submit'))
                          ],
                        );
                      },
                    ),
                  ),
                )
              : SizedBox(),
          Obx(
            () => Visibility(
              visible: (myAttendanceCtrl
                          .stateMyAttendanceModel.last.data[index].isLatelogin
                          .toString() ==
                      "1") ||
                  (myAttendanceCtrl
                          .stateMyAttendanceModel.last.data[index].isEarlyLogout
                          .toString() ==
                      "1"),
              child: Column(
                children: [
                  Obx(
                    () => Text(
                      (myAttendanceCtrl.stateMyAttendanceModel.last.data[index]
                                  .isLatelogin ==
                              '1'
                          ? ("Reason for ${Strings.lateLogin}")
                          : myAttendanceCtrl.stateMyAttendanceModel.last
                                      .data[index].isLatelogin ==
                                  '1'
                              ? ("Reason for ${Strings.earlyLogout}")
                              : 'w'),
                      style: Styles.poppinsBold.copyWith(
                          color: getLastNDates().toString().contains(
                                  myAttendanceCtrl.stateMyAttendanceModel.last
                                      .data[index].date)
                              ? Colors.black
                              : Colors.grey.shade400),
                    ),
                  ),
                  Obx(
                    () => IgnorePointer(
                      ignoring: myAttendanceCtrl.stateMyAttendanceModel.last
                                      .data[index].lateLoginReason !=
                                  "null" &&
                              logStateCtrl.logState.value ||
                          myAttendanceCtrl.stateMyAttendanceModel.last
                                      .data[index].earlyLogoutReason !=
                                  "null" &&
                              !logStateCtrl.logState.value,
                      child: CustomTextField.textField(
                          ctrl,
                          logStateCtrl.logState.value
                              ? myAttendanceCtrl.stateMyAttendanceModel.last
                                          .data[index].lateLoginReason
                                          .toString() ==
                                      "null"
                                  ? "Enter reason"
                                  : myAttendanceCtrl.stateMyAttendanceModel.last
                                      .data[index].lateLoginReason
                                      .toString()
                              : myAttendanceCtrl.stateMyAttendanceModel.last
                                          .data[index].earlyLogoutReason
                                          .toString() ==
                                      "null"
                                  ? "Enter reason"
                                  : myAttendanceCtrl.stateMyAttendanceModel.last
                                      .data[index].earlyLogoutReason
                                      .toString(),
                          enabled: getLastNDates().toString().contains(
                                  myAttendanceCtrl.stateMyAttendanceModel.last
                                      .data[index].date)
                              ? true
                              : false,
                          validator: submitValidation(ctrl.text),
                          submitHint: 1),
                    ),
                  ),
                  Visibility(
                    visible: myAttendanceCtrl.stateMyAttendanceModel.last
                                    .data[index].lateLoginReason ==
                                "null" &&
                            logStateCtrl.logState.value ||
                        myAttendanceCtrl.stateMyAttendanceModel.last.data[index]
                                    .earlyLogoutReason ==
                                "null" &&
                            !logStateCtrl.logState.value,
                    child: getLastNDates().toString().contains(myAttendanceCtrl
                            .stateMyAttendanceModel.last.data[index].date)
                        ? Buttons.blueButtonReason(
                            "Submit",
                            () async {
                              log('value--> ${ctrl.text}');
                              if (ctrl.text.isNotEmpty) {
                                // if (formSubmitGlobalKey.currentState!
                                //     .validate()) {
                                //   formSubmitGlobalKey.currentState!.save();
                                CustomDialog.showDialogTransperent(context);
                                var res = await RecordReasonApi(
                                        attendanceId: myAttendanceCtrl
                                            .stateMyAttendanceModel
                                            .last
                                            .data[index]
                                            .attendanceId,
                                        type: logStateCtrl.logState.value
                                            ? "login"
                                            : "logout",
                                        reason: ctrl.text)
                                    .callApi();
                                print(res.toString());
                                Navigator.pop(context);

                                if (res.statusCode == 201) {
                                  var body = jsonDecode(res.body);
                                  if (body["status"]) {
                                    Navigator.pop(context);
                                    setState(() {
                                      _getAttendance = myAttendanceCtrl
                                          .getMyAttendance(userModelCtrl
                                              .stateUserModel
                                              .last
                                              .data[0]
                                              .userid);
                                    });

                                    CustomSnackBar.atBottom(
                                        title: "Success",
                                        body: "Reason is recorded");
                                  } else {
                                    print(" Reason recorded failed");
                                  }
                                }
                                // }
                              } else {
                                CustomSnackBar.atBottom(
                                    title: "Reason",
                                    body: 'This is required',
                                    status: false);
                              }
                            },
                          )
                        : ElevatedButton(
                            onPressed: null,
                            child: Text('Submit'),
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card attendanceLoginCard(
    BuildContext context, {
    String? title,
    String? data,
    required Color color,
  }) {
    double width = Strings.width(context);
    double height = Strings.height(context);
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          // color: logStateCtrl.logState.value? Strings.ColorBlue:Strings.bgColor,
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: height / 8,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                const SizedBox(height: 5.0),
                FittedBox(
                  child: Text(
                    title!,
                    style: Styles.poppinsBold.copyWith(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 5.0),
                CustomRichText.customRichText("", data!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
