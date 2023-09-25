import 'dart:developer';
import 'package:attendance/controller/model_state/bank_details_ctrl.dart';
import 'package:attendance/controller/model_state/leave_request_ctrl.dart';
import 'package:attendance/controller/model_state/my_attendance_ctrl.dart';
import 'package:attendance/controller/model_state/parent_concern_controller.dart';
import 'package:attendance/model/parent_concern_model.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

//---------------------------------------------------*ParentConcern Card Widget
class ParentConcernCardWidget extends StatelessWidget {
  final Datum? data;
  final int index;
  final ParentConcernGetx controller;
  const ParentConcernCardWidget({
    super.key,
    required this.index,
    required this.controller,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: Card(
          color: Color.fromRGBO(246, 244, 238, 1),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText.customRichText(
                    "Application Number :", data!.applicationnumber.toString()),
                CustomRichText.customRichText(
                    "Student Name :", data!.name.toString()),
                CustomRichText.customRichText(
                    "Father Name :", data!.fathername.toString()),
                CustomRichText.customRichText(
                    "Branch :", data!.branchname.toString()),
                CustomRichText.customRichText(
                    "Concern id :", data!.concernId.toString()),
                CustomRichText.customRichText(
                    textAlign: TextAlign.start,
                    "Category :",
                    '${data!.categoryname.toString()} > ${data!.subcategoryname.toString()}'),
                CustomRichText.customRichText(
                    "Description :", data!.details.toString()),
                CustomRichText.customRichText(
                    "Raised on :", data!.createdDate!.split(' ')[0].toString()),
                CustomRichText.customRichText("Prefered contact time :",
                    '${data!.fromTime.toString()} - ${data!.toTime.toString()}'),
                data!.status == 'Re-Open'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRichText.customRichText(
                              "Status :", data!.status.toString()),
                          CustomRichText.customRichText(
                              "Feedback :", data!.feedback.toString()),
                          CustomRichText.customRichText(
                              "Reason :", data!.feedbackreason.toString()),
                        ],
                      )
                    : CustomRichText.customRichText(
                        "Status :", data!.status.toString()),
                SizedBox(height: 8.0),
                ParentConcernButtonWidget(
                  index: index,
                  controller: controller,
                  data: data,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//---------------------------------------------------*ParentConcern Button Widget / Icon widget (if status == Resolved)
class ParentConcernButtonWidget extends StatelessWidget {
  final Datum? data;
  final int index;
  final ParentConcernGetx controller;
  const ParentConcernButtonWidget(
      {super.key, this.data, required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          data!.status == 'In Progress'
              ? Expanded(
                  child: TextFormField(
                    controller: controller.commentCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Comment',
                      hintText: 'Comment',
                      contentPadding: EdgeInsets.all(10.0),
                      // hintStyle:
                      //     TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(width: 10.0),
          data!.status == 'Resolved'
              ? Icon(Icons.check, color: Colors.green, size: 30.0)
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(25, 130, 198, 1)),
                  onPressed: () async {
                    if (data!.status == 'Pending') {
                      log('${data!.status} --> In Progress');

                      await controller.callInProgress(
                          int.parse(data!.studentId!), int.parse(data!.id!));

                      await controller.callParentConcernList(
                          int.parse(GetUserData().getCurrentUser().branchid));
                      await controller.loadresources();
                      ParentConcernGetx().callParentConcernList(
                          int.parse(GetUserData().getCurrentUser().userid));
                    } else if (data!.status == 'In Progress' ||
                        data!.status == 'Re-Open') {
                      if (controller.commentCtrl.text.isNotEmpty) {
                        log('${data!.status} --> Resolved');

                        await controller.callResolved(
                            int.parse(data!.studentId!),
                            int.parse(data!.id!),
                            controller.commentCtrl.text);

                        await controller.callParentConcernList(
                            int.parse(GetUserData().getCurrentUser().branchid));
                        await controller.loadresources();
                        ParentConcernGetx().callParentConcernList(
                            int.parse(GetUserData().getCurrentUser().userid));
                      } else {
                        CustomSnackBar.atBottom(
                            title: "Resolving Failed",
                            body: "Please Enter Comments",
                            status: false);
                      }
                    }
                  },
                  child: Text(data!.status == 'Pending'
                      ? 'Mark as In Progress'
                      : data!.status == 'In Progress' ||
                              data!.status == 'Re-Open'
                          ? 'Mark as Resolved'
                          : ''),
                ),
        ]);
  }
}

//-----BankDetailsCardWidget
class BankDetailsCardWidget extends StatelessWidget {
  final dynamic data;
  final int index;
  final BankDetailsGetx controller;
  const BankDetailsCardWidget({
    super.key,
    required this.index,
    required this.controller,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: Card(
          color: Color.fromRGBO(246, 244, 238, 1),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText.customRichText(
                    "Bank Name :", data!.bankName.toString()),
                CustomRichText.customRichText(
                    "Branch Name :", data!.branchName.toString()),
                CustomRichText.customRichText(
                    "Account No. :", data!.accountNo.toString()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRichText.customRichText(
                        "IFSC Code :", data!.ifscCode.toString()),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        controller.toEditScreenNavigation(data, context, index);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//-----OutsideCardWidget
class OutsideCardWidget extends StatelessWidget {
  final dynamic data;
  final int index;
  final MyAttendanceModelController controller;
  const OutsideCardWidget({
    super.key,
    required this.index,
    required this.controller,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: Card(
          color: Color.fromRGBO(246, 244, 238, 1),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText.customRichText("Name :", data!.name.toString()),
                CustomRichText.customRichText(
                    "Absent Type :", data!.absenttype.toString()),
                CustomRichText.customRichText(
                    "Absent Reason :", data!.absentReason.toString()),
                CustomRichText.customRichText(
                    "Date :", data!.date.toString().split(' ')[0]),
                SizedBox(height: 5.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          controller.outsideWorkApproveOrReject(context, 1);
                        },
                        child: Text('Approve')),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          controller.outsideWorkApproveOrReject(context, 2);
                        },
                        child: Text('Reject')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//-----StudentCardWidget
class StudentCardWidget extends StatelessWidget {
  final dynamic data;
  final int index;
  final LeaveRequestController controller;
  const StudentCardWidget({
    super.key,
    required this.index,
    required this.controller,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: Card(
          color: Color.fromRGBO(246, 244, 238, 1),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText.customRichText("Name :", data!.name.toString()),
                CustomRichText.customRichText(
                    "Application Number :", data!.applicationnumber.toString()),
                CustomRichText.customRichText(
                    "From :", data!.leavefrom.toString().split(' ')[0]),
                CustomRichText.customRichText(
                    "To :", data!.leaveto.toString().split(' ')[0]),
                CustomRichText.customRichText(
                    "Reason :", data!.reason.toString()),
                SizedBox(height: 5.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          controller.studentleaveApproveReject(
                              days: data!.days.toString(),
                              fcm: data!.leaverequestid.toString(),
                              leaverequestid: data!.leaverequestid.toString(),
                              status: '1',
                              userid: GetUserData().getUserId());
                        },
                        child: Text('Approve')),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          controller.studentleaveApproveReject(
                              days: data!.days.toString(),
                              fcm: data!.firebase.toString(),
                              leaverequestid: data!.leaverequestid.toString(),
                              status: '0',
                              userid: GetUserData().getUserId());
                        },
                        child: Text('Reject')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
