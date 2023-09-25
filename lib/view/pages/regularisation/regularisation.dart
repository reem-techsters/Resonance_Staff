import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/reporting_employee_ctrl.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/model/all_reporting_emp_attendance_model.dart';
import 'package:attendance/model/regularisation_model.dart';
import 'package:attendance/view/pages/parent_concerns/parentconcern_search.dart';
import 'package:attendance/view/pages/regularisation/regularise_search.dart';
import 'package:attendance/view/widgets/regularisation_card.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/datePickerDialog.dart';
import 'package:attendance/controller/model_state/my_attendance_ctrl.dart';
import 'package:attendance/controller/widget_state/log_ctrl.dart';
import 'package:attendance/model/my_attendance_model.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/preLoader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Regulaization extends StatefulWidget {
  const Regulaization({super.key});

  @override
  State<Regulaization> createState() => _RegulaizationState();
}

class _RegulaizationState extends State<Regulaization> {
  final myAttendanceCtrl = Get.put(MyAttendanceModelController());
  late DateTime intialDate;
  final userModelCtrl = Get.find<UserModelController>();
  bool loading = true;
  AsyncSnapshot<dynamic> globalSnapshot = AsyncSnapshot.waiting();
  final logStateCtrl = Get.put(LogController());
  String selectedMonth = "Last 30 days";

  List<ToRegularise> regulList = [];

  TextEditingController nullCtrl = TextEditingController();
  TextEditingController fromCtrl = TextEditingController();
  TextEditingController toCtrl = TextEditingController();
  bool dateChanged = false;

  late Future<dynamic> getToRegulariseAttend = Future<bool>.value(true);
  late Future<List<MyAttendanceModel>> allReportingEmpAttendanceModel;
  //late Future<bool> _getReportingEmployee;
  ReportingEmployeeController reportingEmployeeCtrl =
      Get.put(ReportingEmployeeController());

  @override
  void initState() {
    super.initState();
    MyAttendanceModelController().loadresources(true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      intialDate = DateTime.now();
      await reportingEmployeeCtrl
          .getReportingEmployee(userModelCtrl.getUserId())
          .then((value) async {
        allReportingEmpAttendanceModel = AllReportingEmpAttendanceModel()
            .getAllEmpAttendance(
                reportingEmployeeCtrl.stateReportingEmployeeModel.last.data,
                fromDate: "null",
                toDate: "null");
        getToRegulariseAttend = ToRegularise()
            .toRegulariseList(await allReportingEmpAttendanceModel);
        regulList = await ToRegularise()
            .toRegulariseList(await allReportingEmpAttendanceModel);
        setState(() {
          loading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = Strings.width(context);
    double height = Strings.height(context);
    return SafeArea(
        child: Scaffold(
            drawer: CustomDrawer(),
            body: loading
                ? Column(children: [Preloader.circular(context)])
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        CustomAppBar("Regularise"),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 0.0, right: 0.0),
                          child: GestureDetector(
                            onTap: () {
                              filterDate(globalSnapshot);
                            },
                            child: Container(
                              color: Colors.white,
                              height: height / 20,
                              child: Row(children: [
                                SizedBox(width: 25.0),
                                !dateChanged
                                    ? Text(
                                        "Last 30 days",
                                        textAlign: TextAlign.end,
                                      )
                                    : Text(
                                        "${fromCtrl.text} to ${toCtrl.text}",
                                        textAlign: TextAlign.end,
                                      ),
                                SizedBox(width: 20.0),
                                Spacer(),
                                Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: VerticalDivider(
                                      thickness: 2,
                                      color: Colors.grey,
                                    )),
                                SizedBox(width: 20),
                                Icon(Icons.filter_list),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Filter"),
                                SizedBox(width: 20.0),
                              ]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 15.0, right: 15.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegulariseSearchScreen(
                                  title: 'Regularise',
                                  regulList: regulList,
                                ),
                              ));
                            },
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                        ),
                        FutureBuilder(
                            future: getToRegulariseAttend,
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              globalSnapshot = snapshot;
                              if (globalSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // print("waiting");
                                return Preloader.circular(context);
                              } else if (globalSnapshot.connectionState ==
                                  ConnectionState.done) {
                                if (globalSnapshot.hasData) {
                                  if (globalSnapshot.data.isNotEmpty) {
                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SizedBox(
                                          height: height,
                                          child: RefreshIndicator(
                                            onRefresh: () async {
                                              await reportingEmployeeCtrl
                                                  .getReportingEmployee(
                                                      userModelCtrl.getUserId())
                                                  .then((value) async {
                                                allReportingEmpAttendanceModel =
                                                    AllReportingEmpAttendanceModel()
                                                        .getAllEmpAttendance(
                                                            reportingEmployeeCtrl
                                                                .stateReportingEmployeeModel
                                                                .last
                                                                .data,
                                                            toDate: "null",
                                                            fromDate: "null");
                                                getToRegulariseAttend =
                                                    ToRegularise().toRegulariseList(
                                                        await allReportingEmpAttendanceModel);
                                                setState(() {
                                                  loading = false;
                                                });
                                              });
                                            },
                                            child: ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, i) {
                                                  return RegularisationCardWidget(
                                                      dataList: snapshot.data,
                                                      index: i);
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

                              // return buildItems(height, width);
                            })
                      ])));
  }

  filterDate(AsyncSnapshot<dynamic> snapshotParam) {
    globalSnapshot = snapshotParam;
    CustomDatePickerDialog(intialDate: intialDate)
        .datePicker(context, fromCtrl, toCtrl, () {})
        .then((value) async {
//filter function
      allReportingEmpAttendanceModel = AllReportingEmpAttendanceModel()
          .getAllEmpAttendance(
              reportingEmployeeCtrl.stateReportingEmployeeModel.last.data,
              fromDate: fromCtrl.text,
              toDate: toCtrl.text);
      var fun = await allReportingEmpAttendanceModel;
      intialDate = value!;

      setState(() {
        getToRegulariseAttend = ToRegularise().toRegulariseList(fun);
        if (!dateChanged) {
          dateChanged = true;
        }
      });
    });
  }
}

//---#Unused#----
// Card attendanceLoginCard(BuildContext context,
  //     {String? title, String? data, required Color color}) {
  //   double width = Strings.width(context);
  //   double height = Strings.height(context);
  //   return Card(
  //     shape: RoundedRectangleBorder(
  //       side: BorderSide(
  //         // color: logStateCtrl.logState.value? Strings.primaryColor:Strings.bgColor,
  //         color: color,
  //         width: 2,
  //       ),
  //       borderRadius: BorderRadius.circular(15.0),
  //     ),

  //     shadowColor: Colors.black,

  //     child: SizedBox(
  //       height: height / 8,
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Column(
  //           children: [
  //             const SizedBox(
  //               height: 5,
  //             ), //SizedBox
  //             FittedBox(
  //               child: Text(
  //                 title!,
  //                 style: Styles.poppinsBold
  //                     .copyWith(color: Colors.black), //Textstyle
  //               ),
  //             ), //Text
  //             const SizedBox(
  //               height: 5,
  //             ), //SizedBox

  //             CustomRichText.customRichText("", data!),
  //           ],
  //         ), //Column
  //       ), //Padding
  //     ), //SizedBox
  //   );
  // }
  //////------------------
// Expanded buildItems(double height, double width, List<ToRegularise>? data) {
//   return Expanded(
//     child: Padding(
//       padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
//       child: SizedBox(
//         child: ListView.separated(
//             shrinkWrap: true,
//             separatorBuilder: (context, index) {
//               return Divider(
//                 color: Colors.white,
//                 height: height / 40,
//                 thickness: 0,
//               );
//             },
//             itemCount: data!.length,
//             itemBuilder: (context, i) {
//               //    bool regPending =data[i].
//               //         .toString() ==
//               //     "1" ||
//               // myAttendanceCtrl.stateMyAttendanceModel.last.data[i]
//               //             .isEarlyLogout
//               //             .toString() ==
//               //         "1" &&
//               //     myAttendanceCtrl.stateMyAttendanceModel.last.data[i]
//               //             .loginregularised
//               //             .toString() ==
//               //         "null" ||
//               // myAttendanceCtrl.stateMyAttendanceModel.last.data[i]
//               //         .loginregularised
//               //         .toString() ==
//               //     "null";

//               return GestureDetector(
//                 onTap: () {
//                   print("index $i");
//                   CustomDialog.customDialog(
//                       Text(""),
//                       // dialogChild(context, nullCtrl),
//                       context,
//                       dialogClose);
//                 },
//                 child: ListTile(
//                   tileColor: Color.fromRGBO(246, 244, 238, 1),
//                   leading: CustomRichText.customRichText(
//                       "Date", data[i].date.toString()),

//                   title: Text(
//                     "Regulaization Pending",
//                     style: Styles.poppinsRegular
//                         .copyWith(color: Strings.colorRed, fontSize: 12),
//                     textAlign: TextAlign.center,
//                   ),

//                   // Text("Regulaization Pending",style: Styles.poppinsRegular.copyWith(color: Strings.colorRed,fontSize: 12),),

//                   // title: Obx(
//                   //   () => Text(
//                   //     // myAttendanceCtrl.stateMyAttendanceModel.last.data[i]
//                   //     //     .loginregularised
//                   //     //     .toString(),
//                   //     myAttendanceCtrl.stateMyAttendanceModel.last.data[i]
//                   //         .loginregularised
//                   //         .toString(),
//                   //     style: Styles.poppinsRegular
//                   //         .copyWith(color: Strings.primaryColor, fontSize: 12),
//                   //     textAlign: TextAlign.center,
//                   //   ),
//                   // ),

//                   // Icon(Icons.check_circle,color: Strings.primaryColor,size:width/10),
//                   trailing: Text(data[i].inOut),
//                 ),
//               );
//             }),
//       ),
//     ),
//   );
// }
///////------------
// dialogClose() {
//   logStateCtrl.updateLogState(true);
//   nullCtrl = TextEditingController();
// }

// void openFilterDelegate() async {
//   await FilterListDelegate.show(
//     context: context,
//     list: ['Last 30 days','January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
//     enableOnlySingleSelection: true,
//     onItemSearch: (data, query) {
//       print("data ${data.toString()} query $query");
//       return data.toString().toLowerCase().contains(query.toLowerCase());
//     },
//     tileLabel: (user) => user.toString(),
//     emptySearchChild: Center(child: Text('No user found')),
//     searchFieldHint: 'Search Here..',
//     onApplyButtonClick: (list) {

//       print("onApplyButtonClick ${list.toString()}");
//       selectedMonth = list![0].toString();
//       // Do something with selected list
//     },
//   );
// }
