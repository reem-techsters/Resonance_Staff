// import 'package:attendance/controller/model_state/my_attendance_ctrl.dart';
// import 'package:attendance/controller/widget_state/log_ctrl.dart';
// import 'package:attendance/model/my_attendance_model.dart';
// import 'package:attendance/view/pages/Leaves/apply_leaves.dart';
// import 'package:attendance/view/widgets/custom_error.dart';
// import 'package:attendance/view/widgets/preLoader.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';

// import '../../service/services_api/api.dart';
// import '../../constant/strings.dart';
// import '../../controller/model_state/user_model_ctrl.dart';
// import '../widgets/buttons.dart';
// import '../widgets/custom_appbar.dart';
// import '../widgets/custom_dialog.dart';
// import '../widgets/custom_drawer.dart';
// import '../widgets/custom_icon.dart';
// import '../widgets/custom_snackbar.dart';
// import '../widgets/custom_text_filed.dart';
// import '../widgets/datePickerDialog.dart';
// import '../widgets/richText.dart';

// class EmployeeAttendance extends StatefulWidget {
//   final userid;

//   EmployeeAttendance({this.userid});

//   @override
//   State<EmployeeAttendance> createState() => _EmployeeAttendanceState();
// }

// class _EmployeeAttendanceState extends State<EmployeeAttendance> {
//   final myAttendanceCtrl = Get.put(MyAttendanceModelController());

//   final userModelCtrl = Get.find<UserModelController>();

//   final logStateCtrl = Get.put(LogController());

//   TextEditingController nullCtrl = TextEditingController();
//   TextEditingController fromCtrl = TextEditingController();
//   TextEditingController toCtrl = TextEditingController();
//   late Future<bool> getAttendance;
//   late DateTime intialDate;
//   var filterRange = "Last 30 days";

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     intialDate = DateTime.now();

//     getAttendance = myAttendanceCtrl.getMyAttendance(widget.userid);
//   }

//   filterDate() {
//     CustomDatePickerDialog(intialDate: intialDate)
//         .datePicker(context, fromCtrl, toCtrl, () {})
//         .then((value) {
// //filter function
//       print('${fromCtrl.text} &&${toCtrl.text}');
//       intialDate = value!;
//       myAttendanceCtrl.filterAttendance(context, widget.userid,
//           fromDate: fromCtrl.text, toDate: toCtrl.text);

//       setState(() {
//         filterRange = "${fromCtrl.text} to ${toCtrl.text}";
//       });
//     });
//   }

// //   void initState(){
//   @override
//   Widget build(BuildContext context) {
//     double interPad = 15.0;
//     double width = Strings.width(context);
//     double height = Strings.height(context);
//     print(
//         "length--- ${myAttendanceCtrl.stateMyAttendanceModel.last.data.length}");
//     return SafeArea(
//         child: Scaffold(
//       drawer: CustomDrawer(),
//       body: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           // mainAxisSize: MainAxisSize.min,
//           children: [
//             Obx(() => CustomAppBar(
//                 myAttendanceCtrl.stateMyAttendanceModel.last.data[0].name)),
//             Padding(
//               padding: const EdgeInsets.only(
//                   top: 0, bottom: 0, left: 0.0, right: 0.0),
//               child: GestureDetector(
//                 onTap: filterDate,
//                 child: Container(
//                   color: Colors.white,
//                   height: height / 20,

//                   // decoration: Strings.roundBoxDecoration.copyWith(
//                   //   borderRadius: BorderRadius.circular(5.0),
//                   //   boxShadow: []
//                   // ),

//                   child: Row(children: [
//                     SizedBox(
//                       width: 25,
//                     ),

//                     Text(
//                       filterRange,
//                       textAlign: TextAlign.end,
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Spacer(),

//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
//                       child: VerticalDivider(
//                         thickness: 2,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),

//                     // ignore: prefer_const_literals_to_create_immutables
//                     Icon(Icons.filter_list),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text("Filter"),
//                     SizedBox(
//                       width: 20,
//                     ),
//                   ]),
//                 ),
//               ),
//             ),
//             Container(
//               height: 50,
//               color: Colors.white,
//             ),
//             FutureBuilder(
//                 future: getAttendance,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.hasError) {
//                       return Center(child: Text("No data available"));
//                     } else if (snapshot.hasData) {
//                       if (myAttendanceCtrl
//                           .stateMyAttendanceModel.last.data.isNotEmpty) {
//                         return Expanded(
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
//                             child: SizedBox(
//                               child: RefreshIndicator(
//                                 onRefresh: () async {
//                                   setState(() {
//                                     getAttendance = myAttendanceCtrl
//                                         .getMyAttendance(widget.userid);
//                                   });
//                                 },
//                                 child: Obx(
//                                   () => ListView.separated(
//                                       separatorBuilder: (context, index) {
//                                         return Divider(
//                                           color: Colors.white,
//                                           height: height / 40,
//                                           thickness: 0,
//                                         );
//                                       },
//                                       itemCount: myAttendanceCtrl
//                                           .stateMyAttendanceModel
//                                           .last
//                                           .data
//                                           .length,
//                                       itemBuilder: (context, i) {
//                                         bool regPending = myAttendanceCtrl
//                                                     .stateMyAttendanceModel
//                                                     .last
//                                                     .data[i]
//                                                     .isLatelogin
//                                                     .toString() ==
//                                                 "1" ||
//                                             myAttendanceCtrl
//                                                         .stateMyAttendanceModel
//                                                         .last
//                                                         .data[i]
//                                                         .isEarlyLogout
//                                                         .toString() ==
//                                                     "1" &&
//                                                 myAttendanceCtrl
//                                                         .stateMyAttendanceModel
//                                                         .last
//                                                         .data[i]
//                                                         .loginregularised
//                                                         .toString() ==
//                                                     "null" ||
//                                             myAttendanceCtrl
//                                                     .stateMyAttendanceModel
//                                                     .last
//                                                     .data[i]
//                                                     .loginregularised
//                                                     .toString() ==
//                                                 "null";

//                                         return GestureDetector(
//                                           onTap: () {
//                                             CustomDialog.customDialog(
//                                                 dialogChild(
//                                                     context, nullCtrl, i),
//                                                 // dialogChild(context, nullCtrl),
//                                                 context, () {
//                                               logStateCtrl.updateLogState(true);
//                                             });
//                                           },
//                                           child: ListTile(
//                                             tileColor: Color.fromRGBO(
//                                                 246, 244, 238, 1),
//                                             leading: Obx(
//                                               () =>
//                                                   CustomRichText.customRichText(
//                                                       "Date",
//                                                       myAttendanceCtrl
//                                                           .stateMyAttendanceModel
//                                                           .last
//                                                           .data[i]
//                                                           .date
//                                                           .toString()),
//                                             ),

//                                             // Text("Regulaization Pending",style: Styles.poppinsRegular.copyWith(color: Strings.colorRed,fontSize: 12),),

//                                             title: Obx(
//                                               () => Text(
//                                                 (myAttendanceCtrl.stateMyAttendanceModel.last.data[i].isLatelogin.toString() == "1" &&
//                                                             myAttendanceCtrl
//                                                                     .stateMyAttendanceModel
//                                                                     .last
//                                                                     .data[i]
//                                                                     .loginregularised
//                                                                     .toString() ==
//                                                                 "null" ||
//                                                         myAttendanceCtrl
//                                                                     .stateMyAttendanceModel
//                                                                     .last
//                                                                     .data[i]
//                                                                     .isEarlyLogout
//                                                                     .toString() ==
//                                                                 "1" &&
//                                                             myAttendanceCtrl
//                                                                     .stateMyAttendanceModel
//                                                                     .last
//                                                                     .data[i]
//                                                                     .logoutregularised
//                                                                     .toString() ==
//                                                                 "null"
//                                                     ? "Regularization Pending"
//                                                     : myAttendanceCtrl.stateMyAttendanceModel.last.data[i].isLatelogin.toString() == "1" ||
//                                                             myAttendanceCtrl.stateMyAttendanceModel.last.data[i].isEarlyLogout.toString() == "1" &&
//                                                                 myAttendanceCtrl.stateMyAttendanceModel.last.data[i].loginregularised.toString() !=
//                                                                     "null" ||
//                                                             myAttendanceCtrl
//                                                                     .stateMyAttendanceModel
//                                                                     .last
//                                                                     .data[i]
//                                                                     .loginregularised
//                                                                     .toString() !=
//                                                                 "null"
//                                                         ? "Regularized"
//                                                         : ""),
//                                                 style: Styles.poppinsRegular
//                                                     .copyWith(
//                                                         color: regPending
//                                                             ? Strings.colorRed
//                                                             : Strings.primaryColor,
//                                                         fontSize: 12),
//                                                 textAlign: TextAlign.center,
//                                               ),
//                                             ),

//                                             // Icon(Icons.check_circle,color: Strings.primaryColor,size:width/10),
//                                             trailing: Obx(
//                                               () => (myAttendanceCtrl
//                                                           .stateMyAttendanceModel
//                                                           .last
//                                                           .data[i]
//                                                           .status ==
//                                                       "1")
//                                                   ? CustomIcon.iconCheck(width)
//                                                   : CustomIcon.iconClose(
//                                                       width, height),
//                                             ),
//                                           ),
//                                         );
//                                       }),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       } else {
//                         return CustomError.noData();
//                       }
//                     } else {
//                       return CustomError.noData();
//                     }
//                   } else {
//                     return Preloader.circular(context);
//                   }
//                 })
//           ]),
//     ));
//   }

//   Column dialogChild(context, TextEditingController ctrl, int index) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: InkWell(
//                 onTap: () {
//                   print("log switched");
//                   logStateCtrl.updateLogState(true);
//                 },
//                 child: Obx(
//                   () => attendanceLoginCard(context,
//                       title: Strings.login,
//                       data: myAttendanceCtrl.stateMyAttendanceModel.last
//                                   .data[index].loginTime
//                                   .toString() ==
//                               "null"
//                           ? "----"
//                           : myAttendanceCtrl
//                               .stateMyAttendanceModel.last.data[index].loginTime
//                               .toString(),
//                       color: logStateCtrl.logState.value
//                           ? Strings.primaryColor
//                           : Strings.bgColor),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: InkWell(
//                 onTap: () {
//                   print("log switched");
//                   logStateCtrl.updateLogState(false);
//                 },
//                 child: Obx(
//                   () => attendanceLoginCard(context,
//                       title: Strings.logout,
//                       data: myAttendanceCtrl.stateMyAttendanceModel.last
//                                   .data[index].logoutTime
//                                   .toString() ==
//                               "null"
//                           ? "----"
//                           : myAttendanceCtrl.stateMyAttendanceModel.last
//                               .data[index].logoutTime
//                               .toString(),
//                       color: logStateCtrl.logState.value
//                           ? Strings.bgColor
//                           : Strings.primaryColor),
//                 ),
//               ),
//             )
//           ],
//         ),

//         SizedBox(
//           height: 15,
//         ),

//         //         ||
//         // (myAttendanceCtrl
//         //         .stateMyAttendanceModel.last.data[index].status
//         //         .toString() ==
//         //     "0"),
//         Column(
//           children: [
//             FittedBox(
//               child: Obx(
//                 () => Text(
//                   (logStateCtrl.logState.value
//                       ? ("Reason for ${Strings.lateLogin} ")
//                       : ("Reason for  ${Strings.earlyLogout}")),
//                   style: Styles.poppinsBold.copyWith(color: Colors.black),
//                 ),
//               ),
//             ),
//             IgnorePointer(
//               child: Obx(
//                 () => CustomTextField.textField(
//                     ctrl,
//                     logStateCtrl.logState.value
//                         ? myAttendanceCtrl.stateMyAttendanceModel.last
//                             .data[index].lateLoginReason
//                             .toString()
//                         : myAttendanceCtrl.stateMyAttendanceModel.last
//                             .data[index].earlyLogoutReason
//                             .toString()),
//               ),
//             ),
//             Obx(() => Visibility(
//                   visible: (myAttendanceCtrl.stateMyAttendanceModel.last
//                                   .data[index].isLatelogin
//                                   .toString() ==
//                               "1" &&
//                           myAttendanceCtrl.stateMyAttendanceModel.last
//                                   .data[index].loginregularised
//                                   .toString() ==
//                               "null") ||
//                       (myAttendanceCtrl.stateMyAttendanceModel.last.data[index]
//                                   .isEarlyLogout
//                                   .toString() ==
//                               "1" &&
//                           myAttendanceCtrl.stateMyAttendanceModel.last
//                                   .data[index].logoutregularised
//                                   .toString() ==
//                               "null"),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Buttons.blueButtonReason(Strings.approve, () async {
//                         String log = logStateCtrl.logState.value
//                             ? "regularizelogin"
//                             : "regularizelogout";

//                         try {
//                           CustomDialog.showDialogTransperent(context);
//                           http.Response res = await http.get(Uri.parse(
//                               "${Strings.baseUrl}$log?attendanceId=${myAttendanceCtrl.stateMyAttendanceModel.last.data[index].attendanceId}&regularised=1"));
//                           print(
//                               "login REGULARISED api called ${res.statusCode}");

//                           if (res.statusCode == 201) {
//                             Navigator.pop(context);
//                             Navigator.pop(context);
//                             var body = jsonDecode(res.body);
//                             if (body["status"]) {
//                               getAttendance = myAttendanceCtrl
//                                   .getMyAttendance(widget.userid);

//                               CustomSnackBar.atBottom(
//                                   title: "Status", body: "$log");
//                             } else {
//                               CustomSnackBar.atBottom(
//                                   title: "Status",
//                                   body: "Failed",
//                                   status: false);
//                             }
//                           }
//                         } catch (e) {
//                           Navigator.pop(context);
//                           Navigator.pop(context);
//                           print("OTP error$e");
//                         }
//                       }),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Buttons.redButtonReason("   ${Strings.reject}   ",
//                           () async {
//                         String log = logStateCtrl.logState.value
//                             ? "regularizelogin"
//                             : "regularizelogout";

//                         try {
//                           CustomDialog.showDialogTransperent(context);
//                           http.Response res = await http.get(Uri.parse(
//                               "${Strings.baseUrl}$log?attendanceId=${myAttendanceCtrl.stateMyAttendanceModel.last.data[index].attendanceId}&regularised=0"));
//                           print(
//                               "login REGULARISED api called ${res.statusCode}");

//                           if (res.statusCode == 201) {
//                             Navigator.pop(context);
//                             Navigator.pop(context);
//                             var body = jsonDecode(res.body);
//                             if (body["status"]) {
//                               getAttendance = myAttendanceCtrl
//                                   .getMyAttendance(widget.userid);

//                               CustomSnackBar.atBottom(
//                                   title: "Status", body: "$log");
//                             } else {
//                               CustomSnackBar.atBottom(
//                                   title: "Status",
//                                   body: "Failed",
//                                   status: false);
//                             }
//                           }
//                         } catch (e) {
//                           Navigator.pop(context);
//                           Navigator.pop(context);
//                           print("OTP error$e");
//                         }
//                       }),
//                     ],
//                   ),
//                 ))
//           ],
//         ),
//       ],
//     );
//   }

//   Card attendanceLoginCard(BuildContext context,
//       {String? title, String? data, required Color color}) {
//     double width = Strings.width(context);
//     double height = Strings.width(context);
//     return Card(
//       shape: RoundedRectangleBorder(
//         side: BorderSide(
//           color: color,
//           width: 2,
//         ),
//         borderRadius: BorderRadius.circular(15.0),
//       ),

//       shadowColor: Colors.black,

//       child: SizedBox(
//         width: width / 3,
//         height: height / 3,
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 5,
//               ), //SizedBox
//               Text(
//                 title!,
//                 style: Styles.poppinsBold
//                     .copyWith(color: Colors.black), //Textstyle
//               ), //Text
//               const SizedBox(
//                 height: 5,
//               ), //SizedBox

//               CustomRichText.customRichText("", data!), //Text
//             ],
//           ), //Column
//         ), //Padding
//       ), //SizedBox
//     );
//   }
// }
