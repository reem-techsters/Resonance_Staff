import 'package:attendance/constant/dateformat.dart';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/leave_request_ctrl.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/service/services_api/api.dart';
import 'package:attendance/view/pages/approve_leaves/approveleaves_search.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/preLoader.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApproveLeaves extends StatefulWidget {
  const ApproveLeaves({super.key});

  @override
  State<ApproveLeaves> createState() => _ApproveLeavesState();
}

class _ApproveLeavesState extends State<ApproveLeaves> {
  late LeaveRequestController leaveRequestCtrl;
  late UserModelController UserModelCtrl;
  late Future<bool> getLeaveRequest;

  @override
  void initState() {
    super.initState();
    UserModelCtrl = Get.find<UserModelController>();
    leaveRequestCtrl = Get.put(LeaveRequestController());
    getLeaveRequest = leaveRequestCtrl.getLeaveRequestModel(
        UserModelCtrl.getUserId(), UserModelCtrl.getBranchId());
  }

  @override
  Widget build(BuildContext context) {
    double width = Strings.width(context);
    double height = Strings.width(context);
    return SafeArea(
        child: Scaffold(
            drawer: CustomDrawer(),
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomAppBar(Strings.approveLeave),
              GetBuilder<LeaveRequestController>(
                  init: LeaveRequestController(),
                  builder: (controller) {
                    return
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0),
                child: InkWell(
                  onTap: () {
                    controller.searchData.clear();
                    controller.searchCtrl.clear();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ApproveLeaveSearchScreen(
                          title: 'Approve Leaves',
                          UserModelCtrl: UserModelCtrl),
                    ));
                  },
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              );
              }),
              FutureBuilder(
                  future: getLeaveRequest,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Preloader.circular(context);
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(child: CustomError.noData());
                      } else if (snapshot.hasData) {
                        if (leaveRequestCtrl
                            .stateLeaveRequestModel.last.data.isNotEmpty) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                height: height,
                                child: Obx(
                                  () => ListView.builder(
                                      itemCount: leaveRequestCtrl
                                          .stateLeaveRequestModel
                                          .last
                                          .data
                                          .length,
                                      itemBuilder: (context, i) {
                                        return buildItems(i, context, width);
                                      }),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return CustomError.noData();
                        }
                      } else {
                        return CustomError.noData();
                      }
                    } else {
                      return CustomError.noData();
                    }
                  }),
            ])));
  }

  Widget buildItems(int i, BuildContext context, double width) {
    return Card(
        color: Color.fromRGBO(246, 244, 238, 1),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => CustomRichText.customRichText(
                    "Employee Name : ",
                    leaveRequestCtrl.stateLeaveRequestModel.last.data[i].name
                        .toString()
                        .trim()),
              ),
              Obx(
                () => CustomRichText.customRichText(
                    "Employee id : ",
                    leaveRequestCtrl
                        .stateLeaveRequestModel.last.data[i].employeeid
                        .toString()
                        .trim()),
              ),
              Obx(
                () => CustomRichText.customRichText(
                    "${Strings.leaveFrom} : ",
                    leaveRequestCtrl
                        .stateLeaveRequestModel.last.data[i].leavefrom
                        .toString()
                        .split("")[0]),
              ),
              Obx(() => CustomRichText.customRichText(
                  "${Strings.leaveFrom} : ",
                  gateformatDateWithoutTime(leaveRequestCtrl
                      .stateLeaveRequestModel.last.data[i].leavefrom))),
              Obx(
                () => CustomRichText.customRichText(
                    "${Strings.leaveTo} : ",
                    gateformatDateWithoutTime(leaveRequestCtrl
                        .stateLeaveRequestModel.last.data[i].leaveto)),
              ),
              Obx(
                () => CustomRichText.customRichText(
                    "${Strings.reason} : ",
                    leaveRequestCtrl
                        .stateLeaveRequestModel.last.data[i].reason),
              ),
              Obx(
                () => CustomRichText.customRichText(
                    "${Strings.leaveBl} : ",
                    leaveRequestCtrl
                        .stateLeaveRequestModel.last.data[i].totalleaves
                        .toString()),
              ),
              SizedBox(
                height: 20,
              ),
              buttons(i, context, width)
            ],
          ),
        ));
  }

  Widget buttons(int i, BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            await ApproveLeaveApi(
                    status: "1",
                    userid: UserModelCtrl.getUserId(),
                    days: leaveRequestCtrl
                        .stateLeaveRequestModel.last.data[i].days
                        .toString(),
                    fcm: leaveRequestCtrl
                        .stateLeaveRequestModel.last.data[i].fcm
                        .toString(),
                    leaverequestid: leaveRequestCtrl
                        .stateLeaveRequestModel.last.data[i].leaverequestid
                        .toString())
                .callApi(context);

            setState(() {
              getLeaveRequest = leaveRequestCtrl.getLeaveRequestModel(
                  UserModelCtrl.getUserId(), UserModelCtrl.getBranchId());
            });
          },
          style: Styles.blueButton,
          child: Text(style: Styles.latoButtonText, "Accept"),
        ),
        SizedBox(width: width / 15),
        ElevatedButton(
          onPressed: () async {
            await ApproveLeaveApi(
                    status: "0",
                    userid: UserModelCtrl.getUserId(),
                    fcm: leaveRequestCtrl
                        .stateLeaveRequestModel.last.data[i].fcm
                        .toString(),
                    days: leaveRequestCtrl
                        .stateLeaveRequestModel.last.data[i].days
                        .toString(),
                    leaverequestid: leaveRequestCtrl
                        .stateLeaveRequestModel.last.data[i].leaverequestid
                        .toString())
                .callApi(context);
            setState(() {
              getLeaveRequest = leaveRequestCtrl.getLeaveRequestModel(
                  UserModelCtrl.getUserId(), UserModelCtrl.getBranchId());
            });
          },
          style: Styles.redButton,
          child: Text(style: Styles.latoButtonText, "   Reject   "),
        )
      ],
    );
  }
}
