import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/getotp_controller.dart';
import 'package:attendance/controller/widget_state/sharedprefs_controller.dart';
import 'package:attendance/controller/widget_state/selected_page.dart';
import 'package:attendance/routes/getRoutes.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/utils/get_widget_state.dart';
import 'package:attendance/view/pages/add_application.dart';
import 'package:attendance/view/pages/bank/bank_details_screen.dart';
import 'package:attendance/view/pages/login.dart';
import 'package:attendance/view/pages/outside_work.dart';
import 'package:attendance/view/pages/payslip.dart';
import 'package:attendance/view/pages/regularisation/screen/regularisation.dart';
import 'package:attendance/view/pages/view_applications.dart';
import 'package:attendance/view/widgets/buttons.dart';
import 'package:attendance/view/widgets/clippp.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:attendance/view/widgets/delete_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isVisibleRegularise = false;
  bool isVisibleFinances = false;
  bool isVisibleApplications = false;
  SelectedPage selectedPageCtrl = Get.put(SelectedPage());
  ProvGetnSet roleid = Get.put(ProvGetnSet());

  @override
  void initState() {
    roleid.getSavedResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic drawerItems = Strings().getDrawerRoute(roleid.savedResponse);
    dynamic iconList = Strings().drawerIconList;
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Strings.ColorBlue,
      child: SingleChildScrollView(
        child: Container(
          width: width / 1.5,
          color: Strings.ColorBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 38.0, bottom: 50, top: 50),
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, GetRoutes.pageProfile),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          // foregroundImage:
                          //       NetworkImage(
                          //         "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepik.com%2Ffree-icon%2Fuser-profile-icon_750909.htm&psig=AOvVaw03wWDp7jf9LU7o-UxCMTtk&ust=1671600971251000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCKDd-oK9h_wCFQAAAAAdAAAAABAE"
                          //         ),
                          radius: 60,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          GetUserData().getUserName(),
                          style: Styles.poppinsBold
                              .copyWith(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Text(
                        GetUserData().getCurrentUser().designation,
                        style:
                            Styles.poppinsRegular.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 40),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemExtent: 60,
                      itemCount: drawerItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        List newList = drawerItems[index].keys.toList();
                        var title = newList[0];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, drawerItems[index][title]);
                            WidgetState().updateSelectedPage(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 0),
                            child: Obx(
                              () => Container(
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50)),
                                  color: selectedPageCtrl
                                              .stateSelectedPage.value ==
                                          -1
                                      ? Strings.ColorBlue
                                      : selectedPageCtrl
                                                  .stateSelectedPage.value ==
                                              index
                                          ? Colors.white
                                          : null,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: ListTile(
                                    leading: Image.asset(
                                      iconList[index],
                                      width: MediaQuery.of(context).size.width /
                                          13,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30,
                                    ),
                                    title: Text(
                                      title,
                                      style: Styles.latoButtonText.copyWith(
                                          color: selectedPageCtrl
                                                      .stateSelectedPage
                                                      .value ==
                                                  index
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisibleRegularise = !isVisibleRegularise;
                      });
                      setState(() {
                        selectedPageCtrl.stateSelectedPage.value = -1;
                        print(selectedPageCtrl.stateSelectedPage.value
                            .toString());
                      });
                    },
                    child: DefaultdropdownDrawerOption(
                      visibility: isVisibleRegularise,
                      iconList: Strings().drawerIconList2[0],
                      label: 'Regularisation',
                      padenum: -1,
                      stateSelectedPage:
                          selectedPageCtrl.stateSelectedPage.value,
                    ),
                  ),
                  SubWidgets(
                    visibility: isVisibleRegularise,
                    screen: Regulaization(),
                    label: 'Late/Early Regularisation',
                  ),
                  SubWidgets(
                    visibility: isVisibleRegularise,
                    screen: OutsideWorkScreen(),
                    label: 'Absent/Outside Work Regularisation',
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisibleFinances = !isVisibleFinances;
                      });
                      setState(() {
                        selectedPageCtrl.stateSelectedPage.value = -2;
                        print(selectedPageCtrl.stateSelectedPage.value
                            .toString());
                      });
                    },
                    child: DefaultdropdownDrawerOption(
                      visibility: isVisibleFinances,
                      iconList: Strings().drawerIconList2[1],
                      label: 'Finances',
                      padenum: -2,
                      stateSelectedPage:
                          selectedPageCtrl.stateSelectedPage.value,
                    ),
                  ),
                  SubWidgets(
                    visibility: isVisibleFinances,
                    screen: PaySlip(),
                    label: 'Pay Slip',
                  ),
                  SubWidgets(
                    visibility: isVisibleFinances,
                    screen: BankDetailsScreen(),
                    label: 'Bank Details',
                  ),
                  roleid.savedResponse == '1' ||
                          roleid.savedResponse == '2' ||
                          roleid.savedResponse == '3' ||
                          roleid.savedResponse == '6' ||
                          roleid.savedResponse == '15'
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              isVisibleApplications = !isVisibleApplications;
                            });
                            setState(() {
                              selectedPageCtrl.stateSelectedPage.value = -3;
                              print(selectedPageCtrl.stateSelectedPage.value
                                  .toString());
                            });
                          },
                          child: DefaultdropdownDrawerOption(
                            visibility: isVisibleApplications,
                            iconList: Strings().drawerIconList2[2],
                            label: 'Applications',
                            padenum: -3,
                            stateSelectedPage:
                                selectedPageCtrl.stateSelectedPage.value,
                          ),
                        )
                      : SizedBox(),
                  SubWidgets(
                    visibility: isVisibleApplications,
                    screen: AddApplication(),
                    label: 'Add Application',
                  ),
                  SubWidgets(
                    visibility: isVisibleApplications,
                    screen: ViewApplication(),
                    label: 'View Applications',
                  ),
                  //-------Delete Account
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                      top: 18.0,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          Strings().drawerIconList2[3],
                          width: MediaQuery.of(context).size.width / 13,
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        SizedBox(width: 20.0),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isVisibleApplications = false;
                            });

                            showDialog(
                              context: context,
                              builder: (context) {
                                return UserDeleteAlert(
                                    roleid: roleid.toString());
                              },
                            );
                          },
                          child: Text(
                            "Delete My Account",
                            style: Styles.latoButtonText,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40.0,
                      right: 40,
                      top: 35,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          Strings().drawerIconList2[4],
                          width: MediaQuery.of(context).size.width / 13,
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        SizedBox(width: 20.0),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isVisibleApplications = false;
                            });
                            CustomDialog.customDialog(
                                dialogChild(context), context, () {});
                          },
                          child: Text(
                            "Logout",
                            style: Styles.latoButtonText,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dialogChild(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Do you want to logout?"),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Row(
            children: [
              Buttons.redButtonReason("Logout", () {
                logoutFun(context);
              }),
              Spacer(),
              Buttons.blueButtonReason("Cancel", () {
                Navigator.pop(context);
              })
            ],
          ),
        )
      ],
    );
  }

  logoutFun(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences preffs = await SharedPreferences.getInstance();

    //Remove String
    prefs.remove("userModel");
    preffs.remove("apiRoleid");
    Strings().drawerRoutestonormal();

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}

//---------------------------------------------------------------------------*****GUEST DRAWER
class CustomDrawer2 extends StatefulWidget {
  final String? roleid;
  const CustomDrawer2({super.key, this.roleid});

  @override
  State<CustomDrawer2> createState() => _CustomDrawer2State();
}

class _CustomDrawer2State extends State<CustomDrawer2> {
  SelectedPage SelectedPageCtrl = Get.put(SelectedPage());
  ProvGetnSet roleid = Get.put(ProvGetnSet());

  @override
  void initState() {
    roleid.getSavedResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('id in drawer -----> ${roleid.savedResponse.toString()}');
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 214, 211, 211),
                ),
              )),
          GetBuilder<OtpGetx>(
              init: OtpGetx(),
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color.fromARGB(255, 63, 63, 63),
                        side: const BorderSide(color: Colors.red, width: 2),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return GuestDeleteAlert(
                              roleid: roleid.savedResponse.toString(),
                            );
                          },
                        );
                      },
                      child: const Text(
                        'DELETE ACCOUNT',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 63, 63, 63),
                  side: const BorderSide(color: Colors.red, width: 2),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return LogoutAlertWidget();
                    },
                  );
                },
                child: const Text(
                  'LOG OUT',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogoutAlertWidget extends StatelessWidget {
  const LogoutAlertWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        'Do you want to logout?',
        style: TextStyle(
          color: Color.fromARGB(255, 78, 77, 77),
          letterSpacing: 0.1,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Row(
            children: [
              Buttons.redButtonReason('Logout', () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                    (route) => false);
              }),
              Spacer(),
              Buttons.blueButtonReason("Cancel", () {
                Navigator.pop(context);
              })
            ],
          ),
        )
      ],
    );
  }
}
