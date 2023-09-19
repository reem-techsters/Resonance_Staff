// import 'dart:convert';
// import 'package:attendance/controller/widget_state/sharedprefs_controller.dart';
// import 'package:attendance/controller/model_state/leave_info_ctrl.dart';
// import 'package:attendance/controller/widget_state/selected_page.dart';
// import 'package:attendance/routes/getRoutes.dart';
// import 'package:attendance/view/widgets/buttons.dart';
// import 'package:attendance/view/widgets/custom_dialog.dart';
// import 'package:attendance/view/widgets/custom_snackbar.dart';
// import 'package:attendance/view/widgets/custom_text_filed.dart';
// import 'package:attendance/view/widgets/preLoader.dart';
// import 'package:flutter/material.dart';
// import 'package:badges/badges.dart' as badges;
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:upgrader/upgrader.dart';
// import '../../constant/strings.dart';
// import '../../controller/widget_state/badge_status.dart';
// import '../../controller/model_state/my_attendance_ctrl.dart';
// import '../../controller/model_state/user_model_ctrl.dart';
// import '../../service/services_api/api.dart';
// import '../widgets/custom_appbar.dart';
// import '../widgets/custom_drawer.dart';
// import '../widgets/custom_error.dart';
// import '../widgets/richText.dart';

// class TodayAttendance extends StatefulWidget {
//   const TodayAttendance({super.key});

//   @override
//   State<TodayAttendance> createState() => _TodayAttendanceState();
// }

// class _TodayAttendanceState extends State<TodayAttendance> {
//   TextEditingController loginReasonCtrl = TextEditingController();

//   TextEditingController logoutReasonCtrl = TextEditingController();
//   late String leavesApplied;
//   late String leavesApprove;
//   late String leavesBl;

//   BadgeStatusController? BadgeStatusCtrl = Get.put(BadgeStatusController());
//   late LeaveInfoController? stateLeaveInfoCtrl;
//   UserModelController stateUserModelCtrl = Get.find<UserModelController>();
//   MyAttendanceModelController myAttendanceModelCtrl =
//       Get.put(MyAttendanceModelController());
//   late Future<bool> _getAttendance;
//   ProvGetnSet roleid = Get.put(ProvGetnSet());

//   addStringToSF({required String key, required String val}) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, key);
//   }

//   SelectedPage SelectedPageCtrl = Get.put(SelectedPage());
//   @override
//   void initState() {
//     roleid.getSavedResponse();
//     Strings().getDrawerRoute(roleid.savedResponse);
//     SelectedPageCtrl.stateSelectedPage.value = 0;
//     super.initState();

//     stateLeaveInfoCtrl = Get.put(LeaveInfoController());
//     _getAttendance = myAttendanceModelCtrl
//         .getMyAttendance(stateUserModelCtrl.stateUserModel.last.data[0].userid,
//             branch: stateUserModelCtrl.stateUserModel.last.data[0].branchid)
//         .then((value) {
//       leavesApplied =
//           stateLeaveInfoCtrl!.stateLeaveInfoModel.last.data.appliedleaves == 1
//               //
//               ? "Leave"
//               : "Leaves";
//       leavesApprove =
//           stateLeaveInfoCtrl!.stateLeaveInfoModel.last.data.approveleaves == 1
//               ? "Leave"
//               : "Leaves";
//       leavesBl = int.parse(stateLeaveInfoCtrl!
//                   .stateLeaveInfoModel.last.data.leavebalance) ==
//               1
//           ? "Leave"
//           : "Leaves";
//       return true;
//     });

//     addStringToSF(
//         key: Strings.login,
//         val: stateUserModelCtrl.stateUserModel.last.data[0].userid);
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = Strings.width(context);
//     double height = Strings.height(context);
//     return UpgradeAlert(
//       child: SafeArea(
//           child: Scaffold(
//               drawer: CustomDrawer(),
//               body: FutureBuilder(
//                   future: _getAttendance,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       if (snapshot.hasError) {
//                         return Center(child: Text("No data available"));
//                       } else if (snapshot.hasData) {
//                         return LayoutBuilder(builder: (context, constraint) {
//                           return SingleChildScrollView(
//                             child: ConstrainedBox(
//                               constraints: BoxConstraints(
//                                   minHeight: constraint.maxHeight),
//                               child: IntrinsicHeight(
//                                 child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       CustomAppBar(Strings.todayAttendance),
//                                       Expanded(
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 25.0, top: 50, bottom: 50),
//                                           child: Row(
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.only(right: 20),
//                                                 child: loginInfoCard(
//                                                     width, height, context),
//                                               ),
//                                               logoutInfoCard(
//                                                   width, height, context),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                             left: 25,
//                                             right: 25,
//                                           ),
//                                           child:
//                                               //  SingleChildScrollView(
//                                               //   child:
//                                               Column(children: [
//                                             GestureDetector(
//                                               onTap: () => Navigator.pushNamed(
//                                                   context,
//                                                   GetRoutes.pageAppliedLeaves),
//                                               child: Obx(
//                                                 () => infoCard(
//                                                     width,
//                                                     height / 3.4,
//                                                     Strings.appliedLeave,
//                                                     "${stateLeaveInfoCtrl!.stateLeaveInfoModel.last.data.appliedleaves.toString()} $leavesApplied"),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 20,
//                                             ),
//                                             Obx(
//                                               () => infoCard(
//                                                   width,
//                                                   height / 3.4,
//                                                   Strings.leaveBl,
//                                                   "${stateLeaveInfoCtrl!.stateLeaveInfoModel.last.data.leavebalance.toString()} $leavesBl Left"),
//                                             ),
//                                             SizedBox(
//                                               height: 20,
//                                             ),
//                                             GestureDetector(
//                                               onTap: () => Navigator.pushNamed(
//                                                   context,
//                                                   GetRoutes.pageApproveLeaves),
//                                               child: Obx(() => infoCard(
//                                                   width,
//                                                   height / 3.4,
//                                                   Strings.approveLeave,
//                                                   "${stateLeaveInfoCtrl!.stateLeaveInfoModel.last.data.approveleaves.toString()} $leavesApprove ")),
//                                             ),
//                                             SizedBox(
//                                               height: 20,
//                                             ),
//                                             //                               GestureDetector(
//                                             // onTap: () => Navigator.pushNamed(
//                                             //     context, GetRoutes.pageApproveLeaves),
//                                             // child:
//                                             // // Obx(() =>
//                                             // infoCard(
//                                             //     width,
//                                             //     height / 3.4,
//                                             //     Strings.gatePass,
//                                             //     "0 Passes")

//                                             //     // "${stateLeaveInfoCtrl!.stateLeaveInfoModel.last.data.approveleaves.toString()} $leavesApprove ")
//                                             //     ),
//                                             //   )
//                                           ]),
//                                         ),
//                                       ),
//                                       //),
//                                     ]),
//                               ),
//                             ),
//                           );
//                         });
//                       } else {
//                         return CustomError.noData();
//                       }
//                     } else {
//                       return Column(children: [Preloader.circular(context)]);
//                     }
//                   }))),
//     );
//   }

//   Widget infoCard(double width, double height, String txt1, String txt2) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       elevation: 10,
//       shadowColor: Colors.black,
//       color: Strings.bgColor,
//       child: SizedBox(
//         width: width,
//         height: height / 3,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 20.0),
//           child: Column(
//             children: [
//               //SizedBox
//               Text(
//                 txt1,
//                 style: Styles.poppinsRegular
//                     .copyWith(fontSize: 18, color: Colors.black
//                         // decoration: TextDecoration.underline,
//                         // decorationThickness: 2,
//                         ), //Textstyle
//               ), //Text
//               // const SizedBox(
//               //   height: 5,
//               // ), //SizedBox

//               Text(
//                 txt2,
//                 style: Styles.poppinsBold
//                     .copyWith(color: Colors.black, fontSize: 16), //Textstyle
//               ), //Text
//               // const SizedBox(
//               //   height: 0,
//               // ), //SizedBox
//             ],
//           ), //Column
//         ), //Padding
//       ), //SizedBox
//     );
//   }

//   Card attendanceCard(
//     BuildContext context, {
//     required bool visible,
//     String? title,
//     String? data,
//     required Icon icon,
//   }) {
//     double width = Strings.width(context);
//     double height = Strings.width(context);
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       elevation: 10,
//       shadowColor: Colors.black,
//       color: Strings.bgColor,
//       child: SizedBox(
//         width: width / 2.5,
//         height: height / 2,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 10,
//               ), //SizedBox
//               FittedBox(
//                 child: Text(
//                   title!,
//                   style: Styles.poppinsBold
//                       .copyWith(color: Colors.black), //Textstyle
//                 ),
//               ), //Text
//               const SizedBox(
//                 height: 10,
//               ), //SizedBox

//               CustomRichText.customRichText(
//                 "",
//                 data!,
//               ),
//               Spacer(), //Text
//               //SizedBoxS

//               Visibility(
//                 visible: visible,
//                 child: Buttons.iconButton(
//                     color: Strings.ColorBlue,
//                     text: Strings.reason,
//                     icon: icon,
//                     func: () {
//                       title.contains("Login")
//                           ? loginReasonDialogs(context)
//                           : logoutReasonDialogs(context);
//                       // BadgeStatusCtrl!.updateIsVisible(true);
//                       // print("badge stauts ${BadgeStatusCtrl!.stateIsVisible.value}");

//                       // CustomDialog.customDialog(
//                       //     absentDialogChild(
//                       //         context, nullCtrl),
//                       //     // dialogChild(context, nullCtrl),
//                       //     context);
//                     }),
//               ),
//             ],
//           ), //Column
//         ), //Padding
//       ), //SizedBox
//     );
//   }

//   void loginReasonDialogs(BuildContext context) {
//     loginReasonCtrl.text = myAttendanceModelCtrl
//                 .stateMyAttendanceModel.last.data[0].lateLoginReason
//                 .toString() ==
//             "null"
//         ? ''
//         : myAttendanceModelCtrl
//             .stateMyAttendanceModel.last.data[0].lateLoginReason
//             .toString();
//     CustomDialog.customDialog(
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(bottom: 20.0),
//               child: Text(
//                 "Reason for ${Strings.lateLogin}",
//                 style: Styles.poppinsRegular.copyWith(fontSize: 17),
//               ),
//             ),
//             IgnorePointer(
//                 ignoring: myAttendanceModelCtrl
//                         .stateMyAttendanceModel.last.data[0].lateLoginReason !=
//                     "null",
//                 child: CustomTextField.dialogDescTextField(loginReasonCtrl)),
//             Visibility(
//               visible: myAttendanceModelCtrl
//                       .stateMyAttendanceModel.last.data[0].lateLoginReason ==
//                   "null",
//               child: Buttons.blueButtonReason("Submit", () async {
//                 CustomDialog.showDialogTransperent(context);
//                 var res = await RecordReasonApi(
//                         attendanceId: myAttendanceModelCtrl
//                             .stateMyAttendanceModel.last.data[0].attendanceId,
//                         type: "login",
//                         reason: loginReasonCtrl.text)
//                     .callApi();
//                 print(res.toString());
//                 Navigator.pop(context);

//                 if (res.statusCode == 201) {
//                   var body = jsonDecode(res.body);
//                   if (body["status"]) {
//                     Navigator.pop(context);
//                     setState(() {
//                       _getAttendance = myAttendanceModelCtrl.getMyAttendance(
//                           stateUserModelCtrl.stateUserModel.last.data[0].userid,
//                           branch: stateUserModelCtrl
//                               .stateUserModel.last.data[0].branchid);
//                     });
//                     CustomSnackBar.atBottom(
//                         title: "Success", body: "Login reason is recorded");
//                   } else {
//                     print("Login Reason recorded failed");
//                   }
//                 }
//               }),
//             )
//           ],
//         ),
//         context,
//         () {});
//   }

//   void logoutReasonDialogs(BuildContext context) {
//     logoutReasonCtrl.text = myAttendanceModelCtrl
//                 .stateMyAttendanceModel.last.data[0].earlyLogoutReason
//                 .toString() ==
//             "null"
//         ? ''
//         : myAttendanceModelCtrl
//             .stateMyAttendanceModel.last.data[0].earlyLogoutReason
//             .toString();
//     CustomDialog.customDialog(
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(bottom: 20.0),
//               child: Text(
//                 "${Strings.earlyLogout} Reason",
//                 style: Styles.poppinsRegular.copyWith(fontSize: 17),
//               ),
//             ),
//             CustomTextField.dialogDescTextField(logoutReasonCtrl),
//             Buttons.redButtonReason("Submit", () async {
//               CustomDialog.showDialogTransperent(context);
//               var res = await RecordReasonApi(
//                       attendanceId: myAttendanceModelCtrl
//                           .stateMyAttendanceModel.last.data[0].attendanceId,
//                       type: "logout",
//                       reason: logoutReasonCtrl.text)
//                   .callApi();
//               print(res.toString());
//               Navigator.of(context)
//                   .popUntil(ModalRoute.withName(GetRoutes.pageTodayAttendance));

//               if (res.statusCode == 201) {
//                 var body = jsonDecode(res.body);
//                 if (body["status"]) {
//                   CustomSnackBar.atBottom(
//                       title: "Success", body: "Logout reason is recorded");
//                 } else {
//                   print("logout Reason recorded failed");
//                 }
//               }
//             })
//           ],
//         ),
//         context,
//         () {});
//   }

//   Widget loginInfoCard(double width, double height, BuildContext context) {
//     return Obx(() => badges.Badge(
//         badgeColor:
//             BadgeStatusCtrl!.stateBadgeStatus.value ? Colors.green : Colors.red,
//         showBadge: BadgeStatusCtrl!.stateIsVisible.value,
//         //badgeContent:SizedBox(width:20,height:20,child: Center(child: Text("!",style: Styles.poppinsBold.copyWith(fontSize: 16)))),
//         // ignore: unrelated_type_equality_checks
//         badgeContent: (BadgeStatusCtrl!.stateBadgeStatus.value == false)
//             ? SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: Center(
//                     child: Text("!",
//                         style: Styles.poppinsBold.copyWith(fontSize: 16))))
//             : SizedBox(
//                 child: Icon(
//                 Icons.check,
//                 color: Colors.white,
//               )),
//         position: badges.BadgePosition.topEnd(),
//         child: Obx(() {
//           //        GetBuilder<UserModelController>(
//           // builder: (viewModel) {

//           return attendanceCard(context,
//               visible: myAttendanceModelCtrl
//                       .stateMyAttendanceModel.last.data[0].isLatelogin ==
//                   "1",
//               title: myAttendanceModelCtrl
//                           .stateMyAttendanceModel.last.data[0].isLatelogin ==
//                       "1"
//                   ? "Late ${Strings.login}"
//                   : Strings.login,
//               icon: myAttendanceModelCtrl
//                           .stateMyAttendanceModel.last.data[0].lateLoginReason
//                           .toString() ==
//                       "null"
//                   ? Icon(Icons.add)
//                   : Icon(Icons.info),
//               data: myAttendanceModelCtrl.stateMyAttendanceModel.last.data[0].loginTime ==
//                       "null"
//                   ? "----"
//                   : myAttendanceModelCtrl
//                       .stateMyAttendanceModel.last.data[0].loginTime
//                       .split(" ")[1]);
//         })));
//   }

//   Widget logoutInfoCard(double width, double height, BuildContext context) {
//     return Obx(() => badges.Badge(
//         badgeColor: !BadgeStatusCtrl!.stateBadgeStatus.value
//             ? Colors.green
//             : Colors.red,
//         showBadge: BadgeStatusCtrl!.stateIsVisible.value,
//         //badgeContent:SizedBox(width:20,height:20,child: Center(child: Text("!",style: Styles.poppinsBold.copyWith(fontSize: 16)))),
//         // ignore: unrelated_type_equality_checks
//         badgeContent: (!BadgeStatusCtrl!.stateBadgeStatus.value == false)
//             ? SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: Center(
//                     child: Text("!",
//                         style: Styles.poppinsBold.copyWith(fontSize: 16))))
//             : SizedBox(
//                 child: Icon(
//                 Icons.check,
//                 color: Colors.white,
//               )),
//         position: badges.BadgePosition.topEnd(),
//         child: Obx(() => attendanceCard(
//               context,
//               visible: myAttendanceModelCtrl
//                       .stateMyAttendanceModel.last.data[0].isEarlyLogout ==
//                   "1",
//               icon: myAttendanceModelCtrl
//                           .stateMyAttendanceModel.last.data[0].earlyLogoutReason
//                           .toString() ==
//                       "null"
//                   ? Icon(Icons.add)
//                   : Icon(Icons.info),
//               title: myAttendanceModelCtrl
//                           .stateMyAttendanceModel.last.data[0].isEarlyLogout ==
//                       "1"
//                   ? "Early ${Strings.logout}"
//                   : Strings.logout,
//               data: myAttendanceModelCtrl
//                           .stateMyAttendanceModel.last.data[0].logoutTime ==
//                       "null"
//                   ? "----"
//                   : myAttendanceModelCtrl
//                       .stateMyAttendanceModel.last.data[0].logoutTime
//                       .split(" ")[1],
//             ))));
//   }
// }
