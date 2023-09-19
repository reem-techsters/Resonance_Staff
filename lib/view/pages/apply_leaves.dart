import 'dart:developer';
import 'dart:io' show Platform;
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/applyleaves_ctrl.dart';
import 'package:attendance/controller/model_state/leave_info_ctrl.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_textformfield.dart';
import 'package:attendance/view/widgets/datepicker_widget.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance/view/widgets/datePickerDialog.dart';

class ApplyLeaves extends StatefulWidget {
  const ApplyLeaves({super.key});

  @override
  State<ApplyLeaves> createState() => _ApplyLeavesState();
}

class _ApplyLeavesState extends State<ApplyLeaves> {
// DateTime selectedDate = DateTime.now();
  // late TextEditingController leavesReasonCtrl;
  // late TextEditingController fromDateCtrl;
  // late TextEditingController toDateCtrl;
  // late UserModelController UserModelCtrl;
  late LeaveInfoController? leaveInfoCtrl;
  late String userId;
  late DateTime intialDate;
  late TextEditingController nullCtrl;

  @override
  void initState() {
    // UserModelCtrl = Get.find<UserModelController>();
    // leavesReasonCtrl = TextEditingController();
    leaveInfoCtrl = Get.put(LeaveInfoController());
    intialDate = DateTime.now();
    nullCtrl = TextEditingController();
    super.initState();
  }

  //   @override
  // void dispose() {
  //   // TOdo
  //   LeaveInfoCtrl;
  //   leavesReasonCtrl;
  //   fromDateCtrl;
  //   fromDateCtrl;
  //   UserModelCtrl;
  //   super.dispose();
  // }
  final formleavesGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(children: [
            CustomAppBar(Strings.applyLeave,
                widget: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formleavesGlobalKey,
                child: GetBuilder<ApplyLeaveGetx>(
                    init: ApplyLeaveGetx(),
                    builder: (controller) {
                      return 
                           Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Obx(
                                    () => CustomRichText.customRichText(
                                        "${Strings.leaveBl} :",
                                        leaveInfoCtrl!.stateLeaveInfoModel.last
                                            .data.leavebalance
                                            .toString()),
                                  ),
                                  CustomRichText.customRichText(
                                      "${Strings.repoting} :",
                                      GetUserData().getReportingPerson()),
                                  SizedBox(height: 20.0),
                                  DatePickerWidget(
                                    textController: controller.fromDateCtrl,
                                    onTap: () async {
                                      CustomDatePickerDialog(
                                              intialDate: intialDate)
                                          .datePickerSingle(
                                              context, nullCtrl, () {})
                                          .then((value) {
                                        if (value != null) {
                                          value.toString();
                                          setState(() {
                                            controller.fromDateCtrl.text =
                                                value.toString().split(" ")[0];
                                          });
                                        }
                                      });
                                    },
                                    hintText: 'From',
                                    iconName: Icons.calendar_today,
                                  ),
                                  SizedBox(height: 15),
                                  DatePickerWidget(
                                    textController: controller.toDateCtrl,
                                    onTap: () async {
                                      log("$intialDate--//");
                                      CustomDatePickerDialog(
                                              intialDate: intialDate)
                                          .datePickerSingle(
                                              context, nullCtrl, () {})
                                          .then((value) {
                                        if (value != null) {
                                          setState(() {
                                            controller.toDateCtrl.text =
                                                value.toString().split(" ")[0];
                                          });
                                          intialDate = value;
                                        }
                                      });
                                    },
                                    hintText: 'To',
                                    iconName: Icons.timer_sharp,
                                  ),
                                  // SizedBox(height: 15),
                                  // CustomTextField.textField(
                                  //   controller.leavesReasonCtrl,
                                  //   "Enter your purpose for leave ${Strings.filler}",
                                  // ),
                                  SizedBox(height: 15),
                                  WidgetTextFormField(
                                    maxLines: true,
                                    textStyle: TextStyle(),
                                    leftandrightpadding: 0.0,
                                    keyboardtype: TextInputType.multiline,
                                    ctrl: controller.leavesReasonCtrl,
                                    hinttext:
                                        'Enter your purpose for leave ${Strings.filler}',
                                    validator: (value) => controller
                                        .leavesReasonValidation(value),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                    borderSide: BorderSide(
                                        color: Strings.ColorBlue, width: 2),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Strings.ColorBlue,
                                              minimumSize: Size(150, 50),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50))),
                                          onPressed: () async {
                                            controller.fromtoValidation();
                                            if (formleavesGlobalKey
                                                    .currentState!
                                                    .validate() &&
                                                controller.leavesReasonCtrl.text
                                                    .isNotEmpty &&
                                                controller.fromDateCtrl.text
                                                    .isNotEmpty &&
                                                controller.toDateCtrl.text
                                                    .isNotEmpty) {
                                              formleavesGlobalKey.currentState!
                                                  .save();

                                              controller
                                                  .applyleavesubmit(context);
                                            }
                                          },
                                          child: Text(
                                            "Submit",
                                            style: Styles.poppinsBold
                                                .copyWith(fontSize: 18),
                                          ),
                                        ),
                                      ]),
                                ]);
                    }),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


//----#COMMENTED ONES#----
  // ElevatedButton loginButton(BuildContext context) {
  //   return ElevatedButton(
  //       onPressed: () {},
  //       style: ButtonStyle(
  //           backgroundColor:
  //               MaterialStateProperty.all<Color>(Strings.ColorBlue)),
  //       child: Text("Login",
  //           style: TextStyle(
  //               fontFamily: 'Lato', fontSize: 16, color: Colors.white)));
  // }

  // ElevatedButton ReasonButton(BuildContext context) {
  //   return ElevatedButton(
  //       onPressed: () {},
  //       style: ButtonStyle(
  //           backgroundColor:
  //               MaterialStateProperty.all<Color>(Strings.ColorRed)),
  //       child: Text("Reason",
  //           style: TextStyle(
  //               fontFamily: 'Lato', fontSize: 16, color: Colors.white)));
  // }