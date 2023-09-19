import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/model/students_model.dart';
import 'package:attendance/routes/getRoutes.dart';
import 'package:attendance/service/services_api/api.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:attendance/view/widgets/custom_text_filed.dart';
import 'package:attendance/view/widgets/datePickerDialog.dart';
import 'package:attendance/view/widgets/preLoader.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

class ApplyOutPass extends StatefulWidget {
  const ApplyOutPass({super.key});

  @override
  State<ApplyOutPass> createState() => _ApplyOutPassState();
}

class _ApplyOutPassState extends State<ApplyOutPass> {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController _pinPutController = TextEditingController();
  late TextEditingController leavesReasonCtrl;
  late TextEditingController fromDateCtrl;
  late TextEditingController toDateCtrl;
  late TextEditingController gurdianCtrl;
  late UserModelController UserModelCtrl;
  late TextEditingController nullCtrl;
  TextEditingController? otpCtrl;
  TextEditingController? phoneCtrl;

  late String userId;
  late DateTime intialDate;
  String fromTime = "";
  String toTime = "";
  String loading = "0";

  List<StudentList>? studentList = [];

  apiCall() {
    String branchid = GetUserData().getUserBranch();
    String userId = GetUserData().getUserId();
    String roleId = GetUserData().getRoleId();
    GetStudents(branchId: branchid, userid: userId, roleId: roleId)
        .callApi()
        .then((res) {
      if (res.statusCode == 201) {
        print("res.body");
        Student studentObj = studentFromJson(res.body);
        if (studentObj.data!.isNotEmpty) {
          setState(() {
            loading = "1";
            studentList = studentObj.data;
          });
        }
      } else {
        setState(() {
          loading = "-1";
        });
      }
    });
  }

  @override
  void initState() {
    apiCall();
    intialDate = DateTime.now();
    UserModelCtrl = Get.find<UserModelController>();
    gurdianCtrl = TextEditingController();
    leavesReasonCtrl = TextEditingController();
    nullCtrl = TextEditingController();
    fromDateCtrl = TextEditingController();
    toDateCtrl = TextEditingController();

    super.initState();
  }

  bool selected = false;
  bool otpSelected = false;
  bool generateOtp = false;
  String selectedVal = "Students";
  String selectedGaurdian = "Gaurdian";
  String selectedId = "";
  List<String> gaurdian = ["Self", "Parent", "Brother", "Cousin"];
  String fathername = "";
  String mobilenumber = "";
  String applicationNumber = "";
  String? selectedValue;

  Future<void> otpGenerate() async {
    try {
      var url = '${Strings.baseUrl}sendotptoparent';
      var data = {'phone': mobilenumber.toString()};
      var response = await post(Uri.parse(url), body: (data));
      if (response.statusCode == 201) {
        // var message = jsonDecode(response.body);
        setState(() {
          otpSelected = true;
          generateOtp = true;
        });
      } else if (response.statusCode == 403) {}
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double interPad = 15.0;
    double width = Strings.width(context);
    double height = Strings.width(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: CustomDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomAppBar("Apply OutPass",
                widget: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
            loading == "0"
                ? Preloader.circular(context)
                : loading == "-1"
                    ? CustomError.noData(msg: "No Students assigned")
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Strings.ColorBlue, width: 2),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      iconStyleData: IconStyleData(
                                        iconSize: 30,
                                        icon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.people,
                                              color: Strings.ColorBlue),
                                        ),
                                      ),
                                      isExpanded: true,
                                      // iconSize: 30,

                                      hint: Text(
                                        'Search Student',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).hintColor),
                                      ),
                                      items: studentList!
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                onTap: () {
                                                  setState(() {
                                                    selected = true;
                                                    selectedVal =
                                                        item.name.toString();
                                                    selectedId =
                                                        item.userid.toString();
                                                    mobilenumber = item
                                                        .mobileNumber
                                                        .toString();
                                                    fathername = item.fatherName
                                                        .toString();
                                                  });
                                                },
                                                value: item.applicationnumber,
                                                child: Text(
                                                  item.name,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ))
                                          .toList(),
                                      value: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value.toString();
                                        });
                                      },
                                      buttonStyleData:
                                          ButtonStyleData(height: 40),
                                      menuItemStyleData:
                                          MenuItemStyleData(height: 40),
                                      dropdownStyleData:
                                          DropdownStyleData(maxHeight: height),
                                      dropdownSearchData: DropdownSearchData(
                                        searchInnerWidgetHeight: 40,
                                        searchController: textEditingController,
                                        searchInnerWidget: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            controller: textEditingController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintText: 'Search for student',
                                              hintStyle:
                                                  const TextStyle(fontSize: 12),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // searchInnerWidgetHeight: 40,
                                        searchMatchFn: (item, searchValue) {
                                          final lowerCaseSearchValue =
                                              searchValue.toLowerCase();
                                          final lowerCaseApplicationNumber =
                                              item.value
                                                  .toString()
                                                  .toLowerCase();
                                          final lowerCaseName = item.child
                                              .toString()
                                              .toLowerCase();
                                          print(
                                              'reem --> \n${lowerCaseName.toString()}');
                                          // log('lowerCaseSearchValue --> $lowerCaseSearchValue');
                                          //  return (item.value
                                          //     .toString()
                                          //     .toLowerCase()
                                          //     .contains(
                                          //         searchValue.toLowerCase()));
                                          return lowerCaseApplicationNumber
                                                  .contains(searchValue
                                                      .toLowerCase()) ||
                                              lowerCaseName.contains(
                                                  searchValue.toLowerCase());
                                        },
                                      ),
                                      // buttonHeight: 40,
                                      // itemHeight: 40,
                                      // dropdownMaxHeight: height,
                                      // searchController: textEditingController,

                                      onMenuStateChange: (isOpen) {
                                        if (!isOpen) {
                                          textEditingController.clear();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                selected == true
                                    ? SizedBox(height: height / 50)
                                    : SizedBox(),
                                selected == true
                                    ? Text(
                                        "FatherName:${fathername.toString()}")
                                    : Text(""),
                                selected == true
                                    ? SizedBox(height: height / 80)
                                    : SizedBox(),
                                selected == true
                                    ? Text(
                                        "MobileNumber:${mobilenumber.toString()}")
                                    : Text(""),
                                selected == true
                                    ? SizedBox(height: height / 100)
                                    : SizedBox(),
                                generateOtp == false
                                    ? selected == true
                                        ? Center(
                                            child: MaterialButton(
                                              minWidth: width / 3,
                                              color: Colors.blue,
                                              child: Text("Generate Otp"),
                                              onPressed: () {
                                                setState(() {
                                                  otpGenerate();
                                                });
                                              },
                                            ),
                                          )
                                        : SizedBox()
                                    : SizedBox(),
                                otpSelected == true
                                    ? Pinput(
                                        length: 4,
                                        controller: _pinPutController,
                                      )
                                    : SizedBox(),
                                selected == true
                                    ? SizedBox(height: height / 20)
                                    : SizedBox(),
                                TextField(
                                    controller: gurdianCtrl,
                                    decoration: Styles.textInputBlue.copyWith(
                                      prefixIcon: Icon(
                                        Icons.people,
                                        color: Strings.ColorBlue,
                                        size: 30,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Strings.ColorBlue,
                                              width: 2)),
                                      hintText: "Gaurdian",
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 20, 0, 0),
                                    )),
                                //*** From
                                SizedBox(height: 15.0),
                                Stack(children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: interPad),
                                    child: SizedBox(
                                      child: TextField(
                                        readOnly: true,
                                        controller: fromDateCtrl,
                                        decoration:
                                            Styles.textInputBlue.copyWith(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Strings.ColorBlue,
                                              width: 2,
                                            ),
                                          ),
                                          hintText: "  From",
                                          prefixIcon: Icon(
                                            Icons.calendar_today,
                                            color: Strings.ColorBlue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                      await CustomDatePickerDialog(
                                              intialDate: intialDate)
                                          .datePickerSingle(
                                              context, nullCtrl, () {})
                                          .then((selectedDate) {
                                        if (selectedDate != null) {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((selectedTime) {
                                            if (selectedTime != null) {
                                              final selectedDateTime = DateTime(
                                                selectedDate.year,
                                                selectedDate.month,
                                                selectedDate.day,
                                                selectedTime.hour,
                                                selectedTime.minute,
                                              );

                                              fromDateCtrl.text =
                                                  DateFormat('yyyy-MM-dd HH:mm')
                                                      .format(selectedDateTime);
                                              // fun.call();
                                            } else {
                                              print("Time is not selected");
                                            }
                                          });
                                        } else {
                                          print("Date is not selected");
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 500,
                                      color: Color.fromARGB(0, 255, 255, 255),
                                    ),
                                  )
                                ]),
                                Stack(children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: interPad),
                                    child: TextField(
                                      readOnly: true,
                                      controller: toDateCtrl,
                                      decoration: Styles.textInputBlue.copyWith(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Strings.ColorBlue,
                                                  width: 2)),
                                          prefixIcon: Icon(
                                            Icons.timer_sharp,
                                            color: Strings.ColorBlue,
                                          ),
                                          hintText: "  To"),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                      await CustomDatePickerDialog(
                                              intialDate: intialDate)
                                          .datePickerSingle(
                                              context, nullCtrl, () {})
                                          .then((selectedDate) {
                                        if (selectedDate != null) {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((selectedTime) {
                                            if (selectedTime != null) {
                                              final selectedDateTime = DateTime(
                                                selectedDate.year,
                                                selectedDate.month,
                                                selectedDate.day,
                                                selectedTime.hour,
                                                selectedTime.minute,
                                              );

                                              toDateCtrl.text =
                                                  DateFormat('yyyy-MM-dd HH:mm')
                                                      .format(selectedDateTime);
                                              // fun.call();
                                            } else {
                                              print("Time is not selected");
                                            }
                                          });
                                        } else {
                                          print("Date is not selected");
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 500,
                                      color: Color.fromARGB(0, 255, 255, 255),
                                    ),
                                  )
                                ]),
                                SizedBox(height: 20.0),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: interPad + 40),
                                  child: CustomTextField.textField(
                                      leavesReasonCtrl,
                                      "Enter your purpose for leave ${Strings.filler}"),
                                ),
                                otpSelected == true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            bottom: interPad,
                                            left: 90,
                                            right: 90),
                                        child: TextButton(
                                            style: Styles.RoundButton,
                                            onPressed: () async {
                                              if ((fromDateCtrl
                                                      .text.isNotEmpty) &&
                                                  (toDateCtrl
                                                      .text.isNotEmpty) &&
                                                  (_pinPutController
                                                      .text.isNotEmpty) &&
                                                  (mobilenumber.isNotEmpty) &&
                                                  (gurdianCtrl
                                                      .text.isNotEmpty) &&
                                                  (selectedId.isNotEmpty) &&
                                                  (leavesReasonCtrl
                                                      .text.isNotEmpty)) {
                                                CustomDialog
                                                    .showDialogTransperent(
                                                        context);
                                                var res = await RequestGatePass(
                                                  fromDate:
                                                      "${fromDateCtrl.text}",
                                                  toDate: "${toDateCtrl.text}",
                                                  otp: _pinPutController.text,
                                                  phone:
                                                      mobilenumber.toString(),
                                                  toTime: toTime,
                                                  fromTime: fromTime,
                                                  reason: leavesReasonCtrl.text,
                                                  userid:
                                                      UserModelCtrl.getUserId(),
                                                  studentid: selectedId,
                                                  gaurdian: gurdianCtrl.text,
                                                  applicationnumber:
                                                      applicationNumber
                                                          .toString(),
                                                ).callApi(context);

                                                setState(() async {
                                                  if (res.statusCode == 201) {
                                                    var body =
                                                        jsonDecode(res.body);
                                                    if (body["status"]) {
                                                      fromDateCtrl.text = "";

                                                      leavesReasonCtrl.text =
                                                          "";
                                                      toDateCtrl.text = "";
                                                      gurdianCtrl.text = "";
                                                      selected = false;
                                                      selectedVal = "Students";
                                                      _pinPutController.text =
                                                          "";

                                                      Navigator.pop(context);
                                                      Navigator.pushNamed(
                                                          context,
                                                          GetRoutes
                                                              .pageGatePass);

                                                      CustomSnackBar.atBottom(
                                                          title: "Outpass",
                                                          body:
                                                              "Outpass applied Successfully");
                                                    } else {
                                                      Navigator.pop(context);

                                                      CustomSnackBar.atBottom(
                                                          title: "Please",
                                                          body:
                                                              "Enter Correct Otp",
                                                          status: false);
                                                    }
                                                  }
                                                });
                                              } else {
                                                CustomSnackBar.atBottom(
                                                    title: "Please",
                                                    body: "Enter All Fields",
                                                    status: false);
                                              }
                                            },
                                            child: Text("Submit",
                                                style: Styles.poppinsBold
                                                    .copyWith(fontSize: 18))),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
// Stack(children: [
//   Padding(
//     padding: EdgeInsets.only(bottom: interPad),
//     child: SizedBox(
//       child: TextField(
//         readOnly: true,
//         controller: fromDateCtrl,
//         decoration:
//             Styles.textInputBlue.copyWith(
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                   color: Strings.ColorBlue,
//                   width: 2)),
//           hintText: "  From",
//           prefixIcon: Icon(
//             Icons.calendar_today,
//             color: Strings.ColorBlue,
//           ),
//         ),
//       ),
//     ),
//   ),
//   GestureDetector(
//     onTap: () async {
//       FocusScope.of(context).unfocus();
//       CustomDatePickerDialog(
//               intialDate: intialDate)
//           .datePickerSinglee(
//               context, nullCtrl, () {})
//           .then((value) async {
//         TimeOfDay? pickedTime =
//             await showTimePicker(
//                 initialTime: TimeOfDay.now(),
//                 context: context);
//         if (pickedTime != null) {
//           DateTime parsedTime = DateFormat.jm()
//               .parse(pickedTime
//                   .format(context)
//                   .toString());

//           String formattedTime =
//               DateFormat('HH:mm')
//                   .format(parsedTime);

//           setState(() {
//             var y = value!.year;
//             var m = value.month
//                 .toString()
//                 .padLeft(2, '0');
//             var d = value.day
//                 .toString()
//                 .padLeft(2, '0');

//             fromDateCtrl.text =
//                 "$y-$m-$d $formattedTime";
//           });
//         } else {
//           print("Time is not selected");
//         }
//       });
//     },
//     child: Container(
//       height: 50,
//       width: 500,
//       color: Color.fromARGB(0, 255, 255, 255),
//     ),
//   )
// ]),
class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final TextEditingController? searchController;

  CustomDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    this.searchController,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.people,
                  color: Colors.blue,
                  size: 30,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: widget.searchController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for student',
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: widget.items.map((item) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        selectedValue = item;
                      });
                      widget.onChanged(
                          item); // Call onChanged with the selected value
                    },
                    title: Text(
                      item,
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
