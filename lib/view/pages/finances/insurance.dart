// import 'dart:developer';
// import 'package:attendance/controller/model_state/my_attendance_ctrl.dart';
// import 'package:attendance/utils/get_user_id.dart';
// import 'package:attendance/view/widgets/custom_appbar.dart';
// import 'package:attendance/view/widgets/custom_drawer.dart';
// import 'package:attendance/view/widgets/custom_error.dart';
// import 'package:attendance/view/widgets/list_cards.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:get/get.dart';

// class InsuranceScreen extends StatelessWidget {
//   const InsuranceScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//     //   Get.put(MyAttendanceModelController())
//     //       .getoutsideWorkList(GetUserData().getUserId());
//     //   log(GetUserData().getUserId());
//     // });
//     return SafeArea(
//       child: Scaffold(
//         drawer: CustomDrawer(),
//         body: GetBuilder<MyAttendanceModelController>(
//           init: MyAttendanceModelController(),
//           builder: (controller) {
//             return RefreshIndicator(
//               onRefresh: () async {
//                 await controller.outsideworkloadresources(true);
//               },
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomAppBar("Absent/Outside Work"),
//                   controller.isloader
//                       ? Expanded(
//                           child: Center(child: CircularProgressIndicator()),
//                         )
//                       : controller.outsideWorkList.isEmpty
//                           ? Expanded(
//                               child: Center(child: CustomError.noData()),
//                             )
//                           : AnimationLimiter(
//                               child: Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: ListView.builder(
//                                     shrinkWrap: true,
//                                     itemCount:
//                                         controller.outsideWorkList.length,
//                                     itemBuilder: (context, index) {
//                                       final data =
//                                           controller.outsideWorkList[index];
//                                       return OutsideCardWidget(
//                                         index: index,
//                                         data: data,
//                                         controller: controller,
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
