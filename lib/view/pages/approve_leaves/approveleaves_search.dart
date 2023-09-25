import 'dart:developer';

import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/leave_request_ctrl.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/service/services_api/api.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApproveLeaveSearchScreen extends StatefulWidget {
  final String title;
  final UserModelController UserModelCtrl;
  const ApproveLeaveSearchScreen({
    super.key,
    required this.title,
    required this.UserModelCtrl,
  });

  @override
  State<ApproveLeaveSearchScreen> createState() =>
      _ApproveLeaveSearchScreenState();
}

class _ApproveLeaveSearchScreenState extends State<ApproveLeaveSearchScreen> {
  late Future<bool> getLeaveRequest;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LeaveRequestController>(
        init: LeaveRequestController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.searchData.clear();
                  controller.searchCtrl.clear();
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: Text(widget.title),
              backgroundColor: Strings.primaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    controller: controller.searchCtrl,
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
                    onChanged: (value) {
                      setState(() {
                        controller.getSearchResult(value);
                      });
                    },
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final data = controller.searchData[index];

                          return data.name.toLowerCase().contains(controller
                                      .searchCtrl.text
                                      .toLowerCase()) ||
                                  data.employeeid.toLowerCase().contains(
                                      controller.searchCtrl.text.toLowerCase())
                              ? Card(
                                  color: Color.fromRGBO(246, 244, 238, 1),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomRichText.customRichText(
                                            "Employee Name : ",
                                            data.name.toString().trim()),
                                        CustomRichText.customRichText(
                                            "Employee id : ",
                                            data.employeeid.toString().trim()),
                                        CustomRichText.customRichText(
                                            "${Strings.leaveFrom} : ",
                                            data.leavefrom
                                                .toString()
                                                .split("")[0]),
                                        CustomRichText.customRichText(
                                            "${Strings.leaveFrom} : ",
                                            data.leavefrom),
                                        CustomRichText.customRichText(
                                            "${Strings.leaveTo} : ",
                                            data.leaveto),
                                        CustomRichText.customRichText(
                                            "${Strings.reason} : ",
                                            data.reason),

                                        CustomRichText.customRichText(
                                            "${Strings.leaveBl} : ",
                                            data.totalleaves.toString()),

                                        SizedBox(height: 20.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                await ApproveLeaveApi(
                                                        status: "1",
                                                        userid:
                                                            widget.UserModelCtrl
                                                                .getUserId(),
                                                        days: data.days
                                                            .toString(),
                                                        fcm:
                                                            data.fcm.toString(),
                                                        leaverequestid: data
                                                            .leaverequestid
                                                            .toString())
                                                    .callApi(context);

                                                setState(() {
                                                  getLeaveRequest =
                                                      data.getLeaveRequestModel(
                                                          widget.UserModelCtrl
                                                              .getUserId(),
                                                          widget.UserModelCtrl
                                                              .getBranchId());
                                                });
                                              },
                                              style: Styles.blueButton,
                                              child: Text(
                                                  style: Styles.latoButtonText,
                                                  "Accept"),
                                            ),
                                            SizedBox(
                                                width: Strings.width(context) /
                                                    15),
                                            ElevatedButton(
                                              onPressed: () async {
                                                await ApproveLeaveApi(
                                                        status: "0",
                                                        userid:
                                                            widget.UserModelCtrl
                                                                .getUserId(),
                                                        fcm:
                                                            data.fcm.toString(),
                                                        days: data.days
                                                            .toString(),
                                                        leaverequestid: data
                                                            .leaverequestid
                                                            .toString())
                                                    .callApi(context);
                                                setState(() {
                                                  getLeaveRequest =
                                                      data.getLeaveRequestModel(
                                                          widget.UserModelCtrl
                                                              .getUserId(),
                                                          widget.UserModelCtrl
                                                              .getBranchId());
                                                });
                                              },
                                              style: Styles.redButton,
                                              child: Text(
                                                  style: Styles.latoButtonText,
                                                  "   Reject   "),
                                            )
                                          ],
                                        )
                                        // buttons(i, context, width)
                                      ],
                                    ),
                                  ))
                              : SizedBox();
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox();
                        },
                        itemCount: controller.searchData.length),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
