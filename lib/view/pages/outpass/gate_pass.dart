import 'package:attendance/constant/dateformat.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/view/pages/outpass/apply_bulk_pass.dart';
import 'package:attendance/view/pages/outpass/apply_pass.dart';
import 'package:attendance/view/pages/outpass/gatepass_search.dart';
import 'package:attendance/view/pages/parent_concerns/parentconcern_search.dart';
import 'package:attendance/view/widgets/intime_widget.dart';
import 'package:attendance/view/widgets/preLoader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import '../../../constant/strings.dart';
import '../../../controller/model_state/gate_pass_ctrl.dart';
import '../../../model/gate_pass_model.dart';
import '../../../service/services_api/api.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_error.dart';
import '../../widgets/richText.dart';

class GatePass extends StatefulWidget {
  @override
  State<GatePass> createState() => _GatePassState();
}

class _GatePassState extends State<GatePass> {
  late GatePassController gatePassRequestCtrl;
  late UserModelController UserModelCtrl;
  late Future<bool> getLeaveRequest;

  @override
  void initState() {
    GatePassController().loadresources(true);
    // TODO: implement initState
    super.initState();
    UserModelCtrl = Get.find<UserModelController>();
    gatePassRequestCtrl = Get.put(GatePassController());
    getLeaveRequest = gatePassRequestCtrl.getGatePassModel(
        UserModelCtrl.getUserId(), UserModelCtrl.getBranchId());
  }

  @override
  Widget build(BuildContext context) {
    double interPad = 15.0;
    double width = Strings.width(context);
    double height = Strings.width(context);
    return SafeArea(
        child: Scaffold(
            drawer: CustomDrawer(),
            body: RefreshIndicator(
              onRefresh: () async {
                await GatePassController().loadresources(true);
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomAppBar("Gate Pass"),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 10, left: 10, bottom: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: Strings.primaryColor,
                                      minimumSize: Size(180, 50)),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ApplyBulkPass(),
                                    ));
                                  },
                                  child: Text(
                                    'Apply Bulk Pass',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(width: 9.0),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: Strings.primaryColor,
                                      minimumSize: Size(180, 50)),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ApplyOutPass(),
                                    ));
                                  },
                                  child: Text(
                                    'Apply OutPass',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0,top: 8.0),
                        child: GetBuilder<GatePassController>(
                            init: GatePassController(),
                            builder: (controller) {
                              return InkWell(
                                onTap: () {
                                  controller.searchData.clear();
                                  controller.searchCtrl.clear();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        OutPassSearchSearchScreen(
                                            userModelCtrl: UserModelCtrl,
                                            title: 'Gate Pass'),
                                  ));
                                },
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintText: 'Search',
                                    prefixIcon: Icon(Icons.search),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              );
                            }),
                      ),
                      FutureBuilder(
                          future: getLeaveRequest,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Preloader.circular(context);
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Center(child: Text("No data available"));
                              } else if (snapshot.hasData &&
                                  snapshot.data == true) {
                                if (gatePassRequestCtrl
                                    .stateGatePassRequestModel
                                    .last
                                    .data
                                    .isNotEmpty) {
                                  return Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        height: height,
                                        child: AnimationLimiter(
                                          child: Obx(
                                            () => ListView.builder(
                                                shrinkWrap: true,
                                                reverse: false,
                                                itemCount: gatePassRequestCtrl
                                                    .stateGatePassRequestModel
                                                    .last
                                                    .data
                                                    .length,
                                                itemBuilder: (context, i) {
                                                  // print(gatePassRequestCtrl
                                                  //     .stateGatePassRequestModel
                                                  //     .last
                                                  //     .data[i]
                                                  //     .data);

                                                  return AnimationConfiguration.staggeredList(
                                                      position: i,
                                                      duration: const Duration(
                                                          milliseconds: 375),
                                                      child: SlideAnimation(
                                                          verticalOffset: 50.0,
                                                          child: FadeInAnimation(
                                                              child: buildItems(
                                                                  i,
                                                                  context,
                                                                  width,
                                                                  gatePassRequestCtrl
                                                                      .stateGatePassRequestModel
                                                                      .last
                                                                      .data[i]))));
                                                }),
                                          ),
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
                    ]),
              ),
            )));
  }

  Widget buildItems(int i, BuildContext context, double width, Data data) {
    // String str = data.data.substring(1, data.data.length - 1);
    // List<String> words = str.split('",');
    // print(words[2]);
    // String toDateString = words[0].split('":')[1]+'"';
    // String purposeString = words[1].split(":")[1]+'"';
    // String fromDateString = words[2].split('":')[1];
    DateTime fromDate = DateTime(2023, 8, 29, 16, 42);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(fromDate);
    print('Formatted Date: $formattedDate');
    return Card(
        color: Color.fromRGBO(246, 244, 238, 1),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRichText.customRichText(
                  "Application Number :", data.applicationnumber.toString()),
              CustomRichText.customRichText(
                  "Student Name :", data.name.toString()),
              CustomRichText.customRichText(
                  "Accompanied By :", data.gaurdian.toString()),
              CustomRichText.customRichText("From :",
                  '${gateformatDateWithTime(data.fromDate.split(' ')[0])} ${data.fromDate.split(' ')[1].toString()}'),
              CustomRichText.customRichText("To :",
                  "${gateformatDateWithTime(data.toDate.split(' ')[0])} ${data.toDate.split(' ')[1].toString()}"),
              CustomRichText.customRichText(
                  "Purpose :", data.purpose.toString()),
              data.status == 'created' ? SizedBox(height: 10) : SizedBox(),
              data.status == 'created'
                  ? buttons(i, context, width)
                  : data.status == 'rejected'
                      ? CustomRichText.customRichText("Status :", 'rejected')
                      : CustomRichText.customRichText("Status :", 'approved'),
              data.indata == 'NULL' && data.status == "approved"
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Strings.primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: GetBuilder<GatePassController>(
                              init: GatePassController(),
                              builder: (controller) {
                                return IconButton(
                                    onPressed: () {
                                      controller.intimectrl.clear();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return IntimeWidget(
                                            formid: data.formrequestid,
                                            userModelCtrl: UserModelCtrl,
                                          );
                                        },
                                      );
                                    },
                                    icon:
                                        Icon(Icons.edit, color: Colors.white));
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  : data.status == "approved" && data.indata != 'NULL'
                      ? CustomRichText.customRichText("IN TIME :",
                          '${gateformatDateWithTime(data.indata.split(' ')[0].toString())} ${data.indata.split(' ')[1].toString()}')
                      : SizedBox(),
              SizedBox(height: 10.0)
            ],
          ),
        ));
  }

  Widget buttons(int i, BuildContext context, double width) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
        onPressed: () async {
          await ApproveGatePass(
                  approveform: "approved",
                  formreqid: gatePassRequestCtrl
                      .stateGatePassRequestModel.last.data[i].formrequestid
                      .toString(),
                  userid: UserModelCtrl.getUserId())
              .callApi(context);

          setState(() {
            getLeaveRequest = gatePassRequestCtrl.getGatePassModel(
                UserModelCtrl.getUserId(), UserModelCtrl.getBranchId());
          });
        },
        style: Styles.blueButton,
        child: Text(style: Styles.latoButtonText, "Accept"),
      ),
      SizedBox(width: width / 10),
      ElevatedButton(
        onPressed: () async {
          await ApproveGatePass(
                  approveform: "rejected",
                  formreqid: gatePassRequestCtrl
                      .stateGatePassRequestModel.last.data[i].formrequestid
                      .toString(),
                  userid: UserModelCtrl.getUserId())
              .callApi(context);
          setState(() {
            getLeaveRequest = gatePassRequestCtrl.getGatePassModel(
                UserModelCtrl.getUserId(), UserModelCtrl.getBranchId());
          });
        },
        style: Styles.redButton,
        child: Text(style: Styles.latoButtonText, "   Reject   "),
      )
    ]);
  }
}

// class GatePassButtons extends StatelessWidget {
//   final GatePassController gatePassRequestCtrl;
//   final UserModelController UserModelCtrl;
//   // final Future<bool> getLeaveRequest;
//   final int i;
//   const GatePassButtons({
//     super.key,
//     required this.gatePassRequestCtrl,
//     required this.i,
//     required this.UserModelCtrl,
//     // required this.getLeaveRequest,
//   });

//   @override
//   Widget build(BuildContext context) {
//     late Future<bool> getLeaveRequest;
//     return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//       ElevatedButton(
//         onPressed: () async {
//           await ApproveGatePass(
//                   approveform: "approved",
//                   formreqid: gatePassRequestCtrl
//                       .stateGatePassRequestModel.last.data[i].formrequestid
//                       .toString(),
//                   userid: UserModelCtrl.getUserId())
//               .callApi(context);

//           // setState(() {
//           getLeaveRequest = gatePassRequestCtrl.getGatePassModel(
//               UserModelCtrl.getUserId(), UserModelCtrl.getBranchId());
//           // });
//         },
//         style: Styles.blueButton,
//         child: Text(style: Styles.latoButtonText, "Accept"),
//       ),
//       SizedBox(width: Strings.width(context) / 10),
//       ElevatedButton(
//         onPressed: () async {
//           await ApproveGatePass(
//                   approveform: "rejected",
//                   formreqid: gatePassRequestCtrl
//                       .stateGatePassRequestModel.last.data[i].formrequestid
//                       .toString(),
//                   userid: UserModelCtrl.getUserId())
//               .callApi(context);
//           // setState(() {
//           getLeaveRequest = gatePassRequestCtrl.getGatePassModel(
//               UserModelCtrl.getUserId(), UserModelCtrl.getBranchId());
//           // });
//         },
//         style: Styles.redButton,
//         child: Text(style: Styles.latoButtonText, "   Reject   "),
//       )
//     ]);
//   }
// }
