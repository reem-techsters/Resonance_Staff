import 'package:attendance/constant/dateformat.dart';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/gate_pass_ctrl.dart';
import 'package:attendance/controller/model_state/parent_concern_controller.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/service/services_api/api.dart';
import 'package:attendance/view/widgets/intime_widget.dart';
import 'package:attendance/view/widgets/list_cards.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutPassSearchSearchScreen extends StatefulWidget {
  final String title;
  final UserModelController userModelCtrl;
  const OutPassSearchSearchScreen({
    super.key,
    required this.title,
    required this.userModelCtrl,
  });

  @override
  State<OutPassSearchSearchScreen> createState() =>
      _OutPassSearchSearchScreenState();
}

class _OutPassSearchSearchScreenState extends State<OutPassSearchSearchScreen> {
  late Future<bool> getLeaveRequest;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<GatePassController>(
        init: GatePassController(),
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
                                  data.applicationnumber.toLowerCase().contains(
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
                                            "Application Number :",
                                            data.applicationnumber.toString()),
                                        CustomRichText.customRichText(
                                            "Student Name :",
                                            data.name.toString()),
                                        CustomRichText.customRichText(
                                            "Accompanied By :",
                                            data.gaurdian.toString()),
                                        CustomRichText.customRichText("From :",
                                            '${gateformatDateWithTime(data.fromDate.split(' ')[0])} ${data.fromDate.split(' ')[1].toString()}'),
                                        CustomRichText.customRichText("To :",
                                            "${gateformatDateWithTime(data.toDate.split(' ')[0])} ${data.toDate.split(' ')[1].toString()}"),
                                        CustomRichText.customRichText(
                                            "Purpose :",
                                            data.purpose.toString()),
                                        data.status == 'created'
                                            ? SizedBox(height: 10)
                                            : SizedBox(),
                                        data.status == 'created'
                                            // ? buttons(i, context, width)
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        await ApproveGatePass(
                                                                approveform:
                                                                    "approved",
                                                                formreqid: data
                                                                    .formrequestid
                                                                    .toString(),
                                                                userid: widget
                                                                    .userModelCtrl
                                                                    .getUserId())
                                                            .callApi(context);

                                                        setState(() {
                                                          getLeaveRequest = data
                                                              .getGatePassModel(
                                                                  widget
                                                                      .userModelCtrl
                                                                      .getUserId(),
                                                                  widget
                                                                      .userModelCtrl
                                                                      .getBranchId());
                                                        });
                                                      },
                                                      style: Styles.blueButton,
                                                      child: Text(
                                                          style: Styles
                                                              .latoButtonText,
                                                          "Accept"),
                                                    ),
                                                    SizedBox(
                                                        width: Strings.width(
                                                                context) /
                                                            10),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        await ApproveGatePass(
                                                                approveform:
                                                                    "rejected",
                                                                formreqid: data
                                                                    .formrequestid
                                                                    .toString(),
                                                                userid: widget
                                                                    .userModelCtrl
                                                                    .getUserId())
                                                            .callApi(context);
                                                        setState(() {
                                                          getLeaveRequest = data
                                                              .getGatePassModel(
                                                                  widget
                                                                      .userModelCtrl
                                                                      .getUserId(),
                                                                  widget
                                                                      .userModelCtrl
                                                                      .getBranchId());
                                                        });
                                                      },
                                                      style: Styles.redButton,
                                                      child: Text(
                                                          style: Styles
                                                              .latoButtonText,
                                                          "   Reject   "),
                                                    )
                                                  ])
                                            : data.status == 'rejected'
                                                ? CustomRichText.customRichText(
                                                    "Status :", 'rejected')
                                                : CustomRichText.customRichText(
                                                    "Status :", 'approved'),
                                        data.indata == 'NULL' &&
                                                data.status == "approved"
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: 55,
                                                      width: 55,
                                                      decoration: BoxDecoration(
                                                          color: Strings
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: GetBuilder<
                                                          GatePassController>(
                                                        init:
                                                            GatePassController(),
                                                        builder: (controller) {
                                                          return IconButton(
                                                              onPressed: () {
                                                                controller
                                                                    .intimectrl
                                                                    .clear();
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return IntimeWidget(
                                                                      formid: data
                                                                          .formrequestid,
                                                                      userModelCtrl:
                                                                          widget
                                                                              .userModelCtrl,
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              icon: Icon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .white));
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : data.status == "approved" &&
                                                    data.indata != 'NULL'
                                                ? CustomRichText.customRichText(
                                                    "IN TIME :",
                                                    '${gateformatDateWithTime(data.indata.split(' ')[0].toString())} ${data.indata.split(' ')[1].toString()}')
                                                : SizedBox(),
                                        SizedBox(height: 10.0)
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
// GatePassController