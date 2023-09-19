// import 'package:attendance/controller/model_state/applied_leaves_ctrl.dart';
// import 'package:attendance/view/widgets/custom_error.dart';
// import 'package:attendance/view/widgets/custom_icon.dart';
// import 'package:attendance/view/widgets/preLoader.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../constant/strings.dart';
// import '../../controller/model_state/user_model_ctrl.dart';
// import '../widgets/custom_appbar.dart';
// import '../widgets/custom_drawer.dart';
// import '../widgets/richText.dart';

// class AppliedPass extends StatefulWidget {
//   const AppliedPass({Key? key}) : super(key: key);

//   @override
//   State<AppliedPass> createState() => _AppliedPassState();
// }

// class _AppliedPassState extends State<AppliedPass> {
//   late AppliedLeavesController appliedLeaveCtrl;
//   late UserModelController UserModelCtrl;
//   late Future<bool> _getLeaveRequest;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     UserModelCtrl = Get.find<UserModelController>();
//     appliedLeaveCtrl = Get.put(AppliedLeavesController());
//     _getLeaveRequest =
//         appliedLeaveCtrl.getLeaveRequestModel(UserModelCtrl.getUserId());
//   }

//   // @override
//   // void dispose() {
//   //   // TODO: implement dispose
//   //   appliedLeaveCtrl;
//   //   UserModelCtrl;
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     double interPad = 15.0;
//     double width = Strings.width(context);
//     double height = Strings.height(context);
//     return SafeArea(
//         child: Scaffold(
//             drawer: CustomDrawer(),
//             body: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   CustomAppBar("Applied Pass"),
//                   FutureBuilder(
//                       future: _getLeaveRequest,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           print("casse connect waiting");

//                           return Preloader.circular(context);
//                         } else if (snapshot.connectionState ==
//                             ConnectionState.done) {
//                           print("casse connect done");

//                           if (snapshot.hasData) {
//                             print("casse hasdata");

//                             if (appliedLeaveCtrl
//                                 .stateLeaveRequestModel.last.data.isNotEmpty) {
//                               print("casse isNotEmpty");
//                               return Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: SizedBox(
//                                     child: ListView.builder(
//                                         itemCount: appliedLeaveCtrl
//                                             .stateLeaveRequestModel
//                                             .last
//                                             .data
//                                             .length,
//                                         itemBuilder: (context, i) {
//                                           return Card(
//                                               color: Color.fromRGBO(
//                                                   246, 244, 238, 1),
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,

//                                                       // crossAxisAlignment:
//                                                       //     CrossAxisAlignment.stretch,
//                                                       children: [
//                                                         CustomRichText.customRichText(
//                                                             "${Strings.leaveFrom} :",
//                                                             appliedLeaveCtrl
//                                                                 .stateLeaveRequestModel
//                                                                 .last
//                                                                 .data[i]
//                                                                 .leavefrom
//                                                                 .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left),
//                                                         CustomRichText.customRichText(
//                                                             "${Strings.leaveTo} :",
//                                                             appliedLeaveCtrl
//                                                                 .stateLeaveRequestModel
//                                                                 .last
//                                                                 .data[i]
//                                                                 .leaveto
//                                                                 .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left),
//                                                         Container(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           width: width / 1.5,
//                                                           child: CustomRichText
//                                                               .customRichText(
//                                                                   "${Strings.reason} :",
//                                                                   appliedLeaveCtrl
//                                                                       .stateLeaveRequestModel
//                                                                       .last
//                                                                       .data[i]
//                                                                       .reason
//                                                                       .toString(),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left),
//                                                         ),
//                                                         // CustomRichText.customRichText(
//                                                         //     "${Strings.leaveStatus} :",
//                                                         //     appliedLeaveCtrl
//                                                         //                 .stateLeaveRequestModel
//                                                         //                 .last
//                                                         //                 .data[0]
//                                                         //                 .isapproved
//                                                         //                 .toString() ==
//                                                         //             "1"
//                                                         //         ? "Approved"
//                                                         //         : "Not Approved"),
//                                                       ],
//                                                     ),
//                                                     Spacer(),
//                                                     appliedLeaveCtrl
//                                                                 .stateLeaveRequestModel
//                                                                 .last
//                                                                 .data[i]
//                                                                 .isapproved
//                                                                 .toString() ==
//                                                             "null"
//                                                         ? CustomIcon
//                                                             .iconWaiting(width)
//                                                         : appliedLeaveCtrl
//                                                                     .stateLeaveRequestModel
//                                                                     .last
//                                                                     .data[i]
//                                                                     .isapproved
//                                                                     .toString() ==
//                                                                 "0"
//                                                             ? CustomIcon
//                                                                 .iconClose(
//                                                                     width,
//                                                                     height)
//                                                             : CustomIcon
//                                                                 .iconCheck(
//                                                                     width)
//                                                   ],
//                                                 ),
//                                               ));
//                                         }),
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               print("casse no data");

//                               return CustomError.noData();
//                             }
//                           } else {
//                             print("casse error1");

//                             return SizedBox();
//                           }
//                         } else {
//                           print("casse error2");

//                           return CustomError.noData();
//                         }
//                       })
//                 ])));
//   }
// }
