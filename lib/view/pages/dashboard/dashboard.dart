import 'dart:convert';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/my_attendance_ctrl.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/controller/widget_state/badge_status.dart';
import 'package:attendance/controller/widget_state/sharedprefs_controller.dart';
import 'package:attendance/controller/model_state/leave_info_ctrl.dart';
import 'package:attendance/controller/widget_state/selected_page.dart';
import 'package:attendance/routes/getRoutes.dart';
import 'package:attendance/service/services_api/api.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/buttons.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:attendance/view/widgets/custom_text_filed.dart';
import 'package:attendance/view/widgets/preLoader.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  TextEditingController loginReasonCtrl = TextEditingController();

  TextEditingController logoutReasonCtrl = TextEditingController();
  late String leavesApplied;
  late String leavesApprove;
  late String leavesBl;

  BadgeStatusController? BadgeStatusCtrl = Get.put(BadgeStatusController());
  late LeaveInfoController? stateLeaveInfoCtrl;
  UserModelController stateUserModelCtrl = Get.find<UserModelController>();
  MyAttendanceModelController myAttendanceModelCtrl =
      Get.put(MyAttendanceModelController());
  late Future<bool> _getAttendance;
  ProvGetnSet roleid = Get.put(ProvGetnSet());

  addStringToSF({required String key, required String val}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, key);
  }

  SelectedPage SelectedPageCtrl = Get.put(SelectedPage());

  @override
  void initState() {
    roleid.getSavedResponse();
    Strings().getDrawerRoute(roleid.savedResponse);
    SelectedPageCtrl.stateSelectedPage.value = 0;
    super.initState();

    stateLeaveInfoCtrl = Get.put(LeaveInfoController());
    _getAttendance = myAttendanceModelCtrl
        .getMyAttendance(stateUserModelCtrl.stateUserModel.last.data[0].userid,
            branch: stateUserModelCtrl.stateUserModel.last.data[0].branchid)
        .then((value) {
      leavesApplied =
          stateLeaveInfoCtrl!.stateLeaveInfoModel.last.data.appliedleaves == 1
              ? "Leave"
              : "Leaves";
      leavesApprove =
          stateLeaveInfoCtrl!.stateLeaveInfoModel.last.data.approveleaves == 1
              ? "Leave"
              : "Leaves";
      leavesBl = int.parse(stateLeaveInfoCtrl!
                  .stateLeaveInfoModel.last.data.leavebalance) ==
              1
          ? "Leave"
          : "Leaves";
      return true;
    });

    addStringToSF(
        key: Strings.login,
        val: stateUserModelCtrl.stateUserModel.last.data[0].userid);
  }

  @override
  Widget build(BuildContext context) {
    double width = Strings.width(context);
    double height = Strings.height(context);
    return UpgradeAlert(
      child: SafeArea(
          child: Scaffold(
              drawer: CustomDrawer(),
              body: FutureBuilder(
                  future: _getAttendance,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(child: Text("No data available"));
                      } else if (snapshot.hasData) {
                        return LayoutBuilder(builder: (context, constraint) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraint.maxHeight),
                              child: IntrinsicHeight(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(height: 20.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                                bottom: 30,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Scaffold.of(context)
                                                      .openDrawer();
                                                },
                                                child: Icon(
                                                  size: 30,
                                                  color: Colors.black,
                                                  Icons.menu,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: 80,
                                              width: 20,
                                              child: Image.asset(
                                                'assets/image/tp_logo.png',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),
                                      UserInfoCard(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: 'Shift Timings: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.grey.shade900),
                                                ),
                                                TextSpan(
                                                  text:
                                                      ' ${stateUserModelCtrl.stateUserModel.last.data[0].loginTime} - ${stateUserModelCtrl.stateUserModel.last.data[0].logoutTime}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.grey.shade900),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          loginInfoCard(width, height, context),
                                          logoutInfoCard(
                                              width, height, context),
                                        ],
                                      ),
                                      SizedBox(height: 20.0),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Strings.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                topLeft: Radius.circular(30),
                                              ),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/icon/texture1.png'),
                                              )),
                                          width: width,
                                          height: height,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20, top: 20),
                                            child: GridView(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 8.0,
                                                  mainAxisSpacing: 8.0,
                                                ),
                                                children: [
                                                  GestureDetector(
                                                    onTap: () =>
                                                        Navigator.pushNamed(
                                                            context,
                                                            GetRoutes
                                                                .pageAppliedLeaves),
                                                    child: Obx(
                                                      () => infoCard(
                                                          width / 2,
                                                          height / 0,
                                                          Strings.appliedLeave,
                                                          "${stateLeaveInfoCtrl!.stateLeaveInfoModel.last.data.appliedleaves.toString()} $leavesApplied"),
                                                    ),
                                                  ),
                                                  Obx(
                                                    () => infoCard(
                                                        width / 2,
                                                        height / 0,
                                                        Strings.leaveBl,
                                                        "${stateLeaveInfoCtrl!.stateLeaveInfoModel.last.data.leavebalance.toString()} $leavesBl Left"),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        Navigator.pushNamed(
                                                            context,
                                                            GetRoutes
                                                                .pageApproveLeaves),
                                                    child: Obx(() => infoCard(
                                                        width / 2,
                                                        height / 0,
                                                        Strings.approveLeave,
                                                        "${stateLeaveInfoCtrl!.stateLeaveInfoModel.last.data.approveleaves.toString()} $leavesApprove ")),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        });
                      } else {
                        return CustomError.noData();
                      }
                    } else {
                      return Column(children: [Preloader.circular(context)]);
                    }
                  }))),
    );
  }

  Widget infoCard(double width, double height, String txt1, String txt2) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      shadowColor: Colors.black,
      color: Strings.bgColor,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        width: width,
        height: height / 3,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Text(
                '${txt1.split(' ')[0]}\n${txt1.split(' ')[1]}',
                style: Styles.poppinsRegular
                    .copyWith(fontSize: 15, color: Colors.black), //Textstyle
              ), //Text

              Text(
                txt2,
                style: Styles.poppinsBold
                    .copyWith(color: Colors.black, fontSize: 12), //Textstyle
              ), //Text
            ],
          ), //Column
        ), //Padding
      ), //SizedBox
    );
  }

  Widget attendanceCard(
    BuildContext context, {
    // required bool visible,
    String? title,
    String? data,
    required int index,
    required Icon icon,
  }) {
    double width = Strings.width(context);
    double height = Strings.width(context);
    return Card(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: index == 1 ? Strings.primaryColor : Colors.white,
      child: SizedBox(
        width: width / 2.35,
        // height: visible ? height / 4.7 + 50 : height / 4.7,
        height: height / 4.7,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, top: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icon/time.png',
                  width: 40,
                  height: 40,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      title!,
                      style: Styles.poppinsBold.copyWith(
                          fontSize: 18,
                          color: index == 1 ? Colors.white : Colors.black),
                    ),
                  ), //Text
                  CustomRichText.customRichText('', data!,
                      colorindex: index == 1 ? 1 : 0),
                  // Spacer(), //Text
                  // Visibility(
                  //   visible: visible,
                  //   child: SizedBox(
                  //     width: 100,
                  //     child: Buttons.iconButton(
                  //         color: Strings.primaryColor,
                  //         text: Strings.reason,
                  //         icon: icon,
                  //         func: () {
                  //           title.contains("Login")
                  //               ? loginReasonDialogs(context)
                  //               : logoutReasonDialogs(context);
                  //         }),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ), //SizedBox
    );
  }

  void loginReasonDialogs(BuildContext context) {
    loginReasonCtrl.text = myAttendanceModelCtrl
                .stateMyAttendanceModel.last.data[0].lateLoginReason
                .toString() ==
            "null"
        ? ''
        : myAttendanceModelCtrl
            .stateMyAttendanceModel.last.data[0].lateLoginReason
            .toString();
    CustomDialog.customDialog(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Reason for ${Strings.lateLogin}",
                style: Styles.poppinsRegular.copyWith(fontSize: 17),
              ),
            ),
            IgnorePointer(
                ignoring: myAttendanceModelCtrl
                        .stateMyAttendanceModel.last.data[0].lateLoginReason !=
                    "null",
                child: CustomTextField.dialogDescTextField(loginReasonCtrl)),
            Visibility(
              visible: myAttendanceModelCtrl
                      .stateMyAttendanceModel.last.data[0].lateLoginReason ==
                  "null",
              child: Buttons.blueButtonReason("Submit", () async {
                CustomDialog.showDialogTransperent(context);
                var res = await RecordReasonApi(
                        attendanceId: myAttendanceModelCtrl
                            .stateMyAttendanceModel.last.data[0].attendanceId,
                        type: "login",
                        reason: loginReasonCtrl.text)
                    .callApi();
                print(res.toString());
                Navigator.pop(context);

                if (res.statusCode == 201) {
                  var body = jsonDecode(res.body);
                  if (body["status"]) {
                    Navigator.pop(context);
                    setState(() {
                      _getAttendance = myAttendanceModelCtrl.getMyAttendance(
                          stateUserModelCtrl.stateUserModel.last.data[0].userid,
                          branch: stateUserModelCtrl
                              .stateUserModel.last.data[0].branchid);
                    });
                    CustomSnackBar.atBottom(
                        title: "Success", body: "Login reason is recorded");
                  } else {
                    print("Login Reason recorded failed");
                  }
                }
              }),
            )
          ],
        ),
        context,
        () {});
  }

  void logoutReasonDialogs(BuildContext context) {
    logoutReasonCtrl.text = myAttendanceModelCtrl
                .stateMyAttendanceModel.last.data[0].earlyLogoutReason
                .toString() ==
            "null"
        ? ''
        : myAttendanceModelCtrl
            .stateMyAttendanceModel.last.data[0].earlyLogoutReason
            .toString();
    CustomDialog.customDialog(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "${Strings.earlyLogout} Reason",
                style: Styles.poppinsRegular.copyWith(fontSize: 17),
              ),
            ),
            CustomTextField.dialogDescTextField(logoutReasonCtrl),
            Buttons.redButtonReason("Submit", () async {
              CustomDialog.showDialogTransperent(context);
              var res = await RecordReasonApi(
                      attendanceId: myAttendanceModelCtrl
                          .stateMyAttendanceModel.last.data[0].attendanceId,
                      type: "logout",
                      reason: logoutReasonCtrl.text)
                  .callApi();
              print(res.toString());
              Navigator.of(context)
                  .popUntil(ModalRoute.withName('todayAttendance'));

              if (res.statusCode == 201) {
                var body = jsonDecode(res.body);
                if (body["status"]) {
                  CustomSnackBar.atBottom(
                      title: "Success", body: "Logout reason is recorded");
                } else {
                  print("logout Reason recorded failed");
                }
              }
            })
          ],
        ),
        context,
        () {});
  }

  Widget loginInfoCard(double width, double height, BuildContext context) {
    return Obx(() => badges.Badge(
        badgeColor:
            BadgeStatusCtrl!.stateBadgeStatus.value ? Colors.green : Colors.red,
        showBadge: BadgeStatusCtrl!.stateIsVisible.value,
        badgeContent: (BadgeStatusCtrl!.stateBadgeStatus.value == false)
            ? SizedBox(
                // width: 20,
                // height: 20,
                child: Center(
                    child: Text("!",
                        style: Styles.poppinsBold.copyWith(fontSize: 16))))
            : SizedBox(
                child: Icon(
                Icons.check,
                color: Colors.white,
              )),
        position: badges.BadgePosition.topEnd(),
        child: Obx(() {
          return attendanceCard(context,
              // visible: myAttendanceModelCtrl
              //         .stateMyAttendanceModel.last.data[0].isLatelogin ==
              //     "1",
              title: myAttendanceModelCtrl
                          .stateMyAttendanceModel.last.data[0].isLatelogin ==
                      "1"
                  ? "Late ${Strings.login}"
                  : Strings.login,
              icon: myAttendanceModelCtrl
                          .stateMyAttendanceModel.last.data[0].lateLoginReason
                          .toString() ==
                      "null"
                  ? Icon(Icons.add)
                  : Icon(Icons.info),
              data: myAttendanceModelCtrl
                          .stateMyAttendanceModel.last.data[0].status ==
                      '1'
                  ? "Present"
                  : myAttendanceModelCtrl
                              .stateMyAttendanceModel.last.data[0].status ==
                          '0'
                      ? 'Absent'
                      : myAttendanceModelCtrl
                          .stateMyAttendanceModel.last.data[0].loginTime
                          .split(" ")[1],
              index: 1);
        })));
  }

  Widget logoutInfoCard(double width, double height, BuildContext context) {
    return Obx(() => badges.Badge(
        badgeColor: !BadgeStatusCtrl!.stateBadgeStatus.value
            ? Colors.green
            : Colors.red,
        showBadge: BadgeStatusCtrl!.stateIsVisible.value,
        badgeContent: (!BadgeStatusCtrl!.stateBadgeStatus.value == false)
            ? SizedBox(
                // width: 20,
                // height: 20,
                child: Center(
                    child: Text("!",
                        style: Styles.poppinsBold.copyWith(fontSize: 16))))
            : SizedBox(
                child: Icon(
                Icons.check,
                color: Colors.white,
              )),
        position: badges.BadgePosition.topEnd(),
        child: Obx(() => attendanceCard(
              context,
              //  visible: myAttendanceModelCtrl
              //         .stateMyAttendanceModel.last.data[0].isEarlyLogout ==
              //     "1",
              icon: myAttendanceModelCtrl
                          .stateMyAttendanceModel.last.data[0].earlyLogoutReason
                          .toString() ==
                      "null"
                  ? Icon(Icons.add)
                  : Icon(Icons.info),
              title: myAttendanceModelCtrl
                          .stateMyAttendanceModel.last.data[0].isEarlyLogout ==
                      "1"
                  ? "Early ${Strings.logout}"
                  : Strings.logout,
              data: myAttendanceModelCtrl
                          .stateMyAttendanceModel.last.data[0].logoutTime ==
                      "null"
                  ? "----"
                  : myAttendanceModelCtrl
                      .stateMyAttendanceModel.last.data[0].logoutTime
                      .split(" ")[1],
              index: 2,
            ))));
  }
}

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Card(
              elevation: 0.0,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2, // Adjust the flex value as needed
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 250, 252, 250),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                GetUserData().getUserName().toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Designation: ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    TextSpan(
                                      text: GetUserData()
                                          .getCurrentUser()
                                          .designation
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 4.0,
                top: 35.0,
              ),
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 235, 232, 232),
                radius: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/icon/employee_icon.png",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
