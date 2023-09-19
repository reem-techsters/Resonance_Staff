// // ignore_for_file: prefer_const_constructors
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:attendance/model/students_model.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';

// import 'package:http/http.dart';
// import 'package:intl/intl.dart';
// import 'package:attendance/constant/strings.dart';
// import 'package:attendance/routes/getRoutes.dart';
// import 'package:attendance/service/services_api/api.dart';
// import 'package:attendance/view/widgets/buttons.dart';
// import 'package:attendance/view/widgets/custom_text_filed.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/request/request.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:attendance/view/widgets/datePickerDialog.dart';
// import 'package:pinput/pinput.dart';

// import '../../controller/model_state/leave_info_ctrl.dart';
// import '../../controller/model_state/user_model_ctrl.dart';
// import '../../utils/get_reporting_person.dart';
// import '../../utils/get_user_id.dart';
// import '../widgets/custom_appbar.dart';
// import '../widgets/custom_dialog.dart';
// import '../widgets/custom_drawer.dart';
// import '../widgets/custom_error.dart';
// import '../widgets/custom_snackbar.dart';
// import '../widgets/pin_otp.dart';
// import '../widgets/preLoader.dart';
// import '../widgets/richText.dart';

// class ApplyPass extends StatefulWidget {
//   @override
//   State<ApplyPass> createState() => _ApplyPassState();
// }

// class _ApplyPassState extends State<ApplyPass> {
// // DateTime selectedDate = DateTime.now();
//   late TextEditingController leavesReasonCtrl;
//   late TextEditingController fromDateCtrl;
//   late TextEditingController toDateCtrl;
//   late TextEditingController gurdianCtrl;
//   late String userId;
//   String fromTime = "";
//   String toTime = "";

//   late UserModelController UserModelCtrl;
//   TextEditingController? otpCtrl;
//   TextEditingController? phoneCtrl;

//   late DateTime intialDate;

//   late TextEditingController nullCtrl;

//   String loading = "0";
//   List<StudentList>? studentList = [];

//   apiCall() {
//     String branchid = GetUserData().getUserBranch();
//     String userId = GetUserData().getUserId();
//     String roleId = GetUserData().getRoleId();
//     GetStudents(branchId: branchid, userid: userId, roleId: roleId)
//         .callApi()
//         .then((res) {
//       if (res.statusCode == 201) {
//         print("res.body");
//         Student studentObj = studentFromJson(res.body);
//         if (studentObj.data!.isNotEmpty) {
//           setState(() {
//             loading = "1";
//             studentList = studentObj.data;
//           });
//         }
//       } else {
//         setState(() {
//           loading = "-1";
//         });
//       }
//     });
//   }

//   @override
//   void initState() {
//     apiCall();
//     intialDate = DateTime.now();

//     UserModelCtrl = Get.find<UserModelController>();
//     gurdianCtrl = TextEditingController();
//     leavesReasonCtrl = TextEditingController();
//     nullCtrl = TextEditingController();
//     fromDateCtrl = TextEditingController();
//     toDateCtrl = TextEditingController();

//     super.initState();
//   }

//   bool selected = false;
//   bool otpSelected = false;

//   bool generateOtp = false;
//   String selectedVal = "Students";
//   String selectedGaurdian = "Gaurdian";
//   String selectedId = "";
//   List<String> gaurdian = ["Self", "Parent", "Brother", "Cousin"];
//   String fathername = "";
//   String mobilenumber = "";
//   String applicationNumber = "";
//   String? selectedValue;

//   final TextEditingController textEditingController = TextEditingController();

//   // @override
//   // void dispose() {
//   //   textEditingController.dispose();
//   //   super.dispose();
//   // }

//   //   @override
//   // void dispose() {
//   //   // TODO: implement dispose
//   //   LeaveInfoCtrl;
//   //   leavesReasonCtrl;
//   //   fromDateCtrl;
//   //   fromDateCtrl;
//   //   UserModelCtrl;
//   //   super.dispose();
//   // }

//   final TextEditingController _pinPutController = TextEditingController();

//   final TextEditingController _numberController = TextEditingController();
//   final FocusNode _pinPutFocusNode = FocusNode();

//   BoxDecoration get _pinPutDecoration {
//     return BoxDecoration(
//       border: Border.all(color: Color(0xFF0000000).withOpacity(0.28)),
//       borderRadius: BorderRadius.circular(5.0),
//     );
//   }

//   Future<void> otpGenerate() async {
//     try {
//       var url = '${Strings.baseUrl}sendotptoparent';

//       var data = {'phone': mobilenumber.toString()};

//       var response = await post(Uri.parse(url), body: (data));

//       if (response.statusCode == 201) {
//         var message = jsonDecode(response.body);

//         setState(() {
//           otpSelected = true;
//           generateOtp = true;
//         });
//       } else if (response.statusCode == 403) {
//         print(response.body);

//         // Flushbar(
//         //   flushbarPosition: FlushbarPosition.TOP,
//         //   titleColor: Strings.kBlackcolor,
//         //   messageColor: Strings.kBlackcolor,
//         //   backgroundColor: Colors.white,
//         //   leftBarIndicatorColor: Strings.kPrimarycolor,
//         //   title: "Hey",
//         //   message: "Us",
//         //   duration: Duration(seconds: 3),
//         // )..show(context);
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double interPad = 15.0;

// //roleid is 16
//     double width = Strings.width(context);
//     double height = Strings.width(context);
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         drawer: CustomDrawer(),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             CustomAppBar("Apply OutPass",
//                 widget: IconButton(
//                   icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 )),
//             loading == "0"
//                 ? Preloader.circular(context)
//                 : loading == "-1"
//                     ? CustomError.noData(msg: "No Students assigned")
//                     : Expanded(
//                         child: SingleChildScrollView(
//                           child: Padding(
//                             padding: EdgeInsets.all(20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Container(
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                           color: Strings.ColorBlue, width: 2),
//                                       borderRadius: BorderRadius.circular(3)),
//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButton2(
//                                       isExpanded: true,
//                                       iconSize: 30,
//                                       icon: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Icon(Icons.people,
//                                             color: Strings.ColorBlue),
//                                       ),
//                                       hint: Text(
//                                         'Search Student',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: studentList!
//                                           .map((item) =>
//                                               DropdownMenuItem<String>(
//                                                 onTap: () {
//                                                   setState(() {
//                                                     selected = true;
//                                                     selectedVal =
//                                                         item.name.toString();
//                                                     selectedId =
//                                                         item.userid.toString();
//                                                     mobilenumber = item
//                                                         .mobileNumber
//                                                         .toString();
//                                                     fathername = item.fatherName
//                                                         .toString();
//                                                   });
//                                                 },
//                                                 value: item.applicationnumber,
//                                                 child: Text(
//                                                   item.name,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ),
//                                               ))
//                                           .toList(),
//                                       value: selectedValue,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           selectedValue = value as String;
//                                         });
//                                       },
//                                       buttonHeight: 40,
//                                       // buttonWidth: 1000,
//                                       itemHeight: 40,
//                                       dropdownMaxHeight: height,
//                                       searchController: textEditingController,
//                                       searchInnerWidget: Padding(
//                                         padding: const EdgeInsets.only(
//                                           top: 8,
//                                           bottom: 4,
//                                           right: 8,
//                                           left: 8,
//                                         ),
//                                         child: TextFormField(
//                                           // textCapitalization:
//                                           //     TextCapitalization.characters,
//                                           controller: textEditingController,
//                                           decoration: InputDecoration(
//                                             isDense: true,
//                                             contentPadding:
//                                                 const EdgeInsets.symmetric(
//                                               horizontal: 10,
//                                               vertical: 8,
//                                             ),
//                                             hintText: 'Search for student',
//                                             hintStyle:
//                                                 const TextStyle(fontSize: 12),
//                                             border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       searchMatchFn: (item, searchValue) {
//                                         final lowerCaseSearchValue =
//                                             searchValue.toLowerCase();
//                                         final lowerCaseApplicationNumber =
//                                             item.value.toString().toLowerCase();
//                                         final lowerCaseName =
//                                             item.child.toString().toLowerCase();

//                                         return lowerCaseApplicationNumber
//                                                 .contains(
//                                                     lowerCaseSearchValue) ||
//                                             lowerCaseName
//                                                 .contains(lowerCaseSearchValue);
//                                       },
//                                       //This to clear the search value when you close the menu
//                                       onMenuStateChange: (isOpen) {
//                                         if (!isOpen) {
//                                           textEditingController.clear();
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),

//                                 // SearchableDropdown.single(
//                                 //   items: studentList!.map(
//                                 //     (val) {
//                                 //       return DropdownMenuItem<StudentList>(
//                                 //         value: val,
//                                 //         child: Text(val.name),
//                                 //       );
//                                 //     },
//                                 //   ).toList(),
//                                 //   value: val,
//                                 //   hint: "Select one",
//                                 //   searchHint: "Select one",
//                                 //   onChanged: (val) {
//                                 //     setState(() {
//                                 //       selected = true;
//                                 //       selectedVal = val!.name.toString();
//                                 //       selectedId = val.userid.toString();
//                                 //       mobilenumber = val.mobileNumber.toString();
//                                 //       fathername = val.fatherName.toString();
//                                 //     });
//                                 //   },
//                                 //   isExpanded: true,
//                                 // ),

//                                 // Searchfi
//                                 // DropdownSearch<>(
//                                 //   //mode of dropdown
//                                 //   mode: Mode.DIALOG,
//                                 //   //to show search box
//                                 //   showSearchBox: true,
//                                 //   showSelectedItem: true,
//                                 //   //list of dropdown items
//                                 //   items: [
//                                 //     "India",
//                                 //     "USA",
//                                 //     "Brazil",
//                                 //     "Canada",
//                                 //     "Australia",
//                                 //     "Singapore"
//                                 //   ],
//                                 //   label: "Country",
//                                 //   onChanged: print,
//                                 //   //show selected item
//                                 //   selectedItem: "India",
//                                 // ),

//                                 //      Material(
//                                 //   elevation: 1,
//                                 //   borderRadius: BorderRadius.circular(10),
//                                 //   child: MultiSelectDialogField(
//                                 //     decoration: BoxDecoration(
//                                 //         border:
//                                 //             Border.all(width: 1, color: Colors.white),
//                                 //         borderRadius: BorderRadius.circular(10)),
//                                 //     items: department
//                                 //         .map((e) => MultiSelectItem(e, e["name"]))
//                                 //         .toList(),
//                                 //     listType: MultiSelectListType.LIST,
//                                 //     selectedColor: Strings.kPrimarycolor,

//                                 //     // cancelText: Text(
//                                 //     //   "Cancel",
//                                 //     //   style: TextStyle(color: Strings.kPrimarycolor),
//                                 //     // ),
//                                 //     searchable: true,
//                                 //     searchHint: "Search here",
//                                 //     onConfirm: (values) {
//                                 //       setState(() {
//                                 //         selectedList = values;
//                                 //       });
//                                 //     },
//                                 //   ),
//                                 // ),
//                                 selected == true
//                                     ? SizedBox(
//                                         height: height / 50,
//                                       )
//                                     : SizedBox(),

//                                 selected == true
//                                     ? Text(
//                                         "FatherName:${fathername.toString()}")
//                                     : Text(""),

//                                 selected == true
//                                     ? SizedBox(
//                                         height: height / 80,
//                                       )
//                                     : SizedBox(),
//                                 selected == true
//                                     ? Text(
//                                         "MobileNumber:${mobilenumber.toString()}")
//                                     : Text(""),

//                                 selected == true
//                                     ? SizedBox(
//                                         height: height / 100,
//                                       )
//                                     : SizedBox(),

//                                 generateOtp == false
//                                     ? selected == true
//                                         ? Center(
//                                             child: MaterialButton(
//                                               minWidth: width / 3,
//                                               color: Colors.blue,
//                                               child: Text("Generate Otp"),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   otpGenerate();
//                                                 });
//                                               },
//                                             ),
//                                           )
//                                         : SizedBox()
//                                     : SizedBox(),

//                                 otpSelected == true
//                                     ? Pinput(
//                                         length: 4,
//                                         controller: _pinPutController,
//                                       )
//                                     : SizedBox(),

//                                 selected == true
//                                     ? SizedBox(height: height / 20)
//                                     : SizedBox(),

//                                 TextField(
//                                     controller: gurdianCtrl,
//                                     // maxLines: 10,
//                                     decoration: Styles.textInputBlue.copyWith(
//                                       prefixIcon: Icon(
//                                         Icons.people,
//                                         color: Strings.ColorBlue,
//                                         size: 30,
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: Strings.ColorBlue,
//                                               width: 2)),
//                                       hintText: "Gaurdian",
//                                       // hintStyle: TextStyle(color: Colors.black),
//                                       contentPadding:
//                                           EdgeInsets.fromLTRB(20, 20, 0, 0),
//                                     )
//                                     // contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
//                                     ),

//                                 SizedBox(height: 20.0),

//                                 InkWell(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Strings.ColorBlue,
//                                             width: 2)),
//                                     child: TextField(
//                                       style: TextStyle(color: Colors.black),
//                                       enabled: false,
//                                       readOnly: true,
//                                       controller: fromDateCtrl,
//                                       decoration: Styles.textInputBlue.copyWith(
//                                         focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Strings.ColorBlue,
//                                                 width: 2)),
//                                         hintText: "  From",
//                                         hintStyle:
//                                             TextStyle(color: Colors.black54),
//                                         prefixIcon: Icon(
//                                           Icons.calendar_today,
//                                           color: Strings.ColorBlue,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   onTap: () {
//                                     FocusScope.of(context).unfocus();
//                                     print("object");
//                                     CustomDatePickerDialog(
//                                             intialDate: intialDate)
//                                         .datePickerSingle(context, nullCtrl,
//                                             () {
//                                       // setState(() {
//                                       //   // dummyData = dateCtrl.text;
//                                       //   timeinput.text = dateCtrl.text;
//                                       // });
//                                     }).then((value) async {
//                                       TimeOfDay? pickedTime =
//                                           await showTimePicker(
//                                         initialTime: TimeOfDay.now(),
//                                         context:
//                                             context, //context of current state
//                                       );

//                                       if (pickedTime != null) {
//                                         // print(pickedTime!.format(context));
//                                         print("ggfghfghf");
//                                         print("${value.toString()}=========");
//                                         //output 10:51 PM
//                                         DateTime parsedTime = DateFormat.jm()
//                                             .parse(pickedTime!
//                                                 .format(context)
//                                                 .toString());
//                                         print(
//                                             parsedTime); //output 1970-01-01 22:53:00.000
//                                         String formattedTime =
//                                             DateFormat('HH:mm')
//                                                 .format(parsedTime);

//                                         setState(() {
//                                           var y = value!.year;
//                                           var m = value.month.toString().padLeft(
//                                               2, '0'); // Ensure two-digit month
//                                           var d = value.day.toString().padLeft(
//                                               2, '0'); // Ensure two-digit day

//                                           fromDateCtrl.text =
//                                               "$y-$m-$d $formattedTime";
//                                         });
//                                       } else {
//                                         print("Time is not selected");
//                                       }
//                                     });
//                                   },
//                                 ),
//                                 SizedBox(height: 20.0),
//                                 InkWell(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Strings.ColorBlue,
//                                             width: 2)),
//                                     child: TextField(
//                                       style: TextStyle(color: Colors.black),
//                                       enabled: false,
//                                       controller: toDateCtrl,
//                                       decoration: Styles.textInputBlue.copyWith(
//                                         focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Strings.ColorBlue,
//                                                 width: 2)),
//                                         prefixIcon: Icon(
//                                           Icons.timer_sharp,
//                                           color: Strings.ColorBlue,
//                                         ),
//                                         hintText: "  To",
//                                         hintStyle:
//                                             TextStyle(color: Colors.black54),
//                                       ),
//                                     ),
//                                   ),
//                                   onTap: () {
       
                                    // FocusScope.of(context).unfocus();
//                                     print("$intialDate--//");
//                                     print("object");

//                                     CustomDatePickerDialog(
//                                             intialDate: intialDate)
//                                         .datePickerSingle(context, nullCtrl,
//                                             () {
//                                       // setState(() {
//                                       //   // dummyData = dateCtrl.text;
//                                       //   timeinput.text = dateCtrl.text;
//                                       // });
//                                     }).then((value) async {
//                                       print("${value}=========");
//                                       TimeOfDay? pickedTime =
//                                           await showTimePicker(
//                                         initialTime: TimeOfDay.now(),
//                                         context:
//                                             context, //context of current state
//                                       );

//                                       if (pickedTime != null) {
//                                         // print(pickedTime!.format(context));
//                                         print("ggfghfghf");
//                                         print("${value.toString()}=========");
//                                         //output 10:51 PM
//                                         DateTime parsedTime = DateFormat.jm()
//                                             .parse(pickedTime!
//                                                 .format(context)
//                                                 .toString());
//                                         //converting to DateTime so that we can further format on different pattern.
//                                         print(
//                                             parsedTime); //output 1970-01-01 22:53:00.000
//                                         String formattedTime =
//                                             DateFormat('HH:mm')
//                                                 .format(parsedTime);
//                                         print(formattedTime);
//                                         print("ggfghfghf");
//                                         print("${value.toString()}=========");

//                                         // timeinput.text = dateCtrl.text;

//                                         setState(() {
//                                           var y = value!.year;
//                                           var m = value.month.toString().padLeft(
//                                               2, '0'); // Ensure two-digit month
//                                           var d = value.day.toString().padLeft(
//                                               2, '0'); // Ensure two-digit day

//                                           toDateCtrl.text =
//                                               "$y-$m-$d $formattedTime";

//                                           // var y = value!.year;
//                                           // var m = value.month;
//                                           // var d = value.day;

//                                           // toDateCtrl.text =
//                                           //     "$y-$m-$d $formattedTime";

//                                           //set the value of text field.
//                                         });

//                                         //output 14:59:00
//                                         //DateFormat() is from intl package, you can format the time on any pattern you need.
//                                       } else {
//                                         print("Time is not selected");
//                                       }
//                                     });
//                                   },
//                                 ),
//                                 SizedBox(height: 20.0),

//                                 Padding(
//                                   padding:
//                                       EdgeInsets.only(bottom: interPad + 40),
//                                   child: CustomTextField.textField(
//                                       leavesReasonCtrl,
//                                       "Enter your purpose for leave ${Strings.filler}"),
//                                 ),
//                                 otpSelected == true
//                                     ? Padding(
//                                         padding: EdgeInsets.only(
//                                             bottom: interPad,
//                                             left: 90,
//                                             right: 90),
//                                         child: TextButton(
//                                             style: Styles.RoundButton,
//                                             onPressed: () async {
//                                               if ((fromDateCtrl
//                                                       .text.isNotEmpty) &&
//                                                   (toDateCtrl
//                                                       .text.isNotEmpty) &&
//                                                   (_pinPutController
//                                                       .text.isNotEmpty) &&
//                                                   (mobilenumber.isNotEmpty) &&
//                                                   (gurdianCtrl
//                                                       .text.isNotEmpty) &&
//                                                   (selectedId.isNotEmpty) &&
//                                                   (leavesReasonCtrl
//                                                       .text.isNotEmpty)) {
//                                                 CustomDialog
//                                                     .showDialogTransperent(
//                                                         context);
//                                                 var res = await RequestGatePass(
//                                                   fromDate:
//                                                       "${fromDateCtrl.text}",
//                                                   toDate: "${toDateCtrl.text}",
//                                                   otp: _pinPutController.text,
//                                                   phone:
//                                                       mobilenumber.toString(),

//                                                   toTime: toTime,
//                                                   fromTime: fromTime,
//                                                   reason: leavesReasonCtrl.text,
//                                                   userid:
//                                                       UserModelCtrl.getUserId(),
//                                                   studentid: selectedId,
//                                                   gaurdian: gurdianCtrl.text,
//                                                   // fcm: GetUserData()
//                                                   //     .getReportingPersonToken(),
//                                                   // name: GetUserData().getUserName()
//                                                 ).callApi(context);

//                                                 setState(() async {
//                                                   if (res.statusCode == 201) {
//                                                     var body =
//                                                         jsonDecode(res.body);
//                                                     if (body["status"]) {
//                                                       fromDateCtrl.text = "";

//                                                       leavesReasonCtrl.text =
//                                                           "";
//                                                       toDateCtrl.text = "";
//                                                       gurdianCtrl.text = "";
//                                                       selected = false;
//                                                       selectedVal = "Students";
//                                                       _pinPutController.text =
//                                                           "";

//                                                       Navigator.pop(context);
//                                                       Navigator.pushNamed(
//                                                           context,
//                                                           GetRoutes
//                                                               .pageGatePass);

//                                                       CustomSnackBar.atBottom(
//                                                           title: "Outpass",
//                                                           body:
//                                                               "Outpass applied Successfully");
//                                                     } else {
//                                                       Navigator.pop(context);

//                                                       CustomSnackBar.atBottom(
//                                                           title: "Please",
//                                                           body:
//                                                               "Enter Correct Otp",
//                                                           status: false);
//                                                     }

//                                                     //Strings.baseUrl+requestLeave?from=2022-11-04 00.00.00.000&to=2022-11-05 00.00.00.000&userid=6611&reason=hello world reason
//                                                   }
//                                                 });
//                                               } else {
//                                                 CustomSnackBar.atBottom(
//                                                     title: "Please",
//                                                     body: "Enter All Fields",
//                                                     status: false);
//                                               }
//                                             },
//                                             child: Text("Submit",
//                                                 style: Styles.poppinsBold
//                                                     .copyWith(fontSize: 18))),
//                                       )
//                                     : SizedBox()
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//           ],
//         ),
//       ),
//     );
//   }

//   ElevatedButton loginButton(BuildContext context) {
//     return ElevatedButton(
//         onPressed: () {},
//         style: ButtonStyle(
//             backgroundColor:
//                 MaterialStateProperty.all<Color>(Strings.ColorBlue)),
//         child: Text("Login",
//             style: TextStyle(
//                 fontFamily: 'Lato', fontSize: 16, color: Colors.white)));
//   }

//   ElevatedButton ReasonButton(BuildContext context) {
//     return ElevatedButton(
//         onPressed: () {},
//         style: ButtonStyle(
//             backgroundColor:
//                 MaterialStateProperty.all<Color>(Strings.ColorRed)),
//         child: Text("Reason",
//             style: TextStyle(
//                 fontFamily: 'Lato', fontSize: 16, color: Colors.white)));
//   }
// }
