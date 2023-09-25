import 'dart:convert';
import 'dart:developer';
import 'package:attendance/controller/model_state/email_login_ctrl.dart';
import 'package:attendance/controller/model_state/getotp_controller.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/controller/widget_state/login_tabbar_getx.dart';
import 'package:attendance/view/pages/guest/guestwait_screen.dart';
import 'package:attendance/view/pages/authenthication/register_screen.dart';
import 'package:attendance/view/pages/dashboard/dashboard.dart';
import 'package:attendance/view/widgets/buttons.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:attendance/view/widgets/custom_textformfield.dart';
import 'package:attendance/view/widgets/pin_otp.dart';
import 'package:pinput/pinput.dart';
import 'package:upgrader/upgrader.dart';
import 'package:attendance/service/services_api/api.dart';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

FocusNode _otpFocusNode = FocusNode(); // Create a FocusNode

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late TextEditingController loginCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController otpCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();

  final stateUserModelCtrl = Get.put(UserModelController());

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();

    if (kReleaseMode) {
      phoneCtrl = TextEditingController();
      otpCtrl = TextEditingController();
    } else {
      // 9121144017 id = 15
      // 9866832924 id =
      // 9154902064 default
      //9390115585 - principle
      phoneCtrl = TextEditingController(text: "9154902064");
      // otpCtrl = TextEditingController(text: "5872");
    }

    loginCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
  }

//-----------------------*Phone Auth
  FocusNode otpFocusNode = FocusNode();
  bool isVisible = false;
  bool isVisible2 = true;
  Future<bool> verifyOtpGuest() async {
    var res = await VerifyOtp(otp: otpCtrl!.text, phone: phoneCtrl!.text)
        .callguestApi();

    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _verifyOtp() async {
    var res =
        await VerifyOtp(otp: otpCtrl!.text, phone: phoneCtrl!.text).callApi();

    if (res.statusCode == 201) {
      var body = res.body;
      final decodedbody = jsonDecode(body);
      print(" ${decodedbody["status"]}");

      if (decodedbody["status"]) {
        //UserModel userData = UserModel(data: body["data"],status: body["status"],message: body["message"]).fromJson;
        UserModel userData = userModelFromJson(body.toString());
        // print("fcm2: $userData.data[0].firebase ");

        FirebaseMessaging messaging = FirebaseMessaging.instance;
        final fcmToken = await FirebaseMessaging.instance.getToken();

        // print("fcm2: $fcmToken");

        await UpdateFcmApi(fcm: fcmToken!, phone: userData.data[0].mobile)
            .callApi()
            .then((value) {
          if (value.statusCode == 201) {
            userData.data[0].firebase = fcmToken;
          }
        });

        //write fcm to database
        //update fcm to object

        await stateUserModelCtrl.updateUserModel(userData);
        return true;
      } else {
        // Navigator.pushNamed(context, GetRoutes.pageLogin);
        return false;
      }
    } else {
      return false;
    }
  }

  bool showPinPut = true;
  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: Strings.bgColor,
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    MediaQuery.of(context).viewInsets.bottom == 0
                        ? SizedBox(height: 100.0)
                        : SizedBox(height: 20.0),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Image.asset("assets/image/tp_logo.png")),
                    SizedBox(height: 30.0),
                    Text(
                      Strings.welcome,
                      style: Styles.latoWelcomeStyle,
                    ),
                    SizedBox(height: 50.0),
                    //----------------------------------------------*Tab
                    Container(
                      decoration: Strings.roundBoxDecoration,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(55)),
                        child: SizedBox(
                          width: Strings.width(context) / 2,
                          height: Strings.height(context) / 17,
                          child: GetBuilder<TabindexController>(
                            init: TabindexController(),
                            builder: (controller) {
                              return TabBar(
                                  labelColor: Colors.black,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: BoxDecoration(
                                      color: Strings.primaryColor),
                                  onTap: (index) async {
                                    controller.selectedindexTab = index;
                                  },
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        "Email",
                                        style: Styles.robotoTabStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        "OTP",
                                        style: Styles.robotoTabStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ]);
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 70.0),
                    //----------------------------------------------*TabBar View
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.2,
                        child: TabBarView(children: [
                          EmailAuth(
                              loginCtrl: loginCtrl,
                              emailCtrl: emailCtrl,
                              passwordCtrl: passwordCtrl),
                          // PhoneAuth(
                          //   loginCtrl: loginCtrl,
                          //   phoneCtrl: phoneCtrl,
                          //   passwordCtrl: passwordCtrl,
                          //   otpCtrl: otpCtrl,
                          //   stateUserModelCtrl: stateUserModelCtrl,
                          //   // unfocusOtpField: _unfocusOtpField,
                          // )
                          GetBuilder<OtpGetx>(
                              init: OtpGetx(),
                              builder: (data) {
                                return Column(
                                  children: [
                                    WidgetTextFormField(
                                        ctrl: phoneCtrl!,
                                        hinttext: 'Phone',
                                        keyboardtype: TextInputType.phone),
                                    SizedBox(height: 20.0),
                                    Visibility(
                                      visible: isVisible2,
                                      child: Column(
                                        children: [
                                          Buttons.blueButtonRounded(
                                            "Get OTP",
                                            () async {
                                              FocusScope.of(context).unfocus();
                                              otpCtrl?.clear();

                                              print("loginCtrl" +
                                                  phoneCtrl.toString());
                                              await data.getOTP(
                                                  phoneCtrl!.text, context);

                                              if (data.status == true) {
                                                setState(() {
                                                  otpFocusNode.requestFocus();
                                                  showPinPut = false;
                                                  isVisible2 = !isVisible2;
                                                  isVisible = !isVisible;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    isVisible
                                        ? SizedBox(height: 0.0)
                                        : SizedBox(height: 30.0),
                                    Visibility(
                                      visible: isVisible,
                                      child: Column(
                                        children: [
                                          // PinOtp().otp(otpCtrl, context),
                                          Pinput(
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            controller: otpCtrl,
                                            autofocus: true,
                                            defaultPinTheme:
                                                PinOtp().defaultPinTheme,
                                            focusedPinTheme:
                                                PinOtp().focusedPinTheme,
                                            submittedPinTheme:
                                                PinOtp().focusedPinTheme,
                                            focusNode: otpFocusNode,
                                            showCursor: true,
                                            onCompleted: (pin) => print(pin),
                                          ),
                                          SizedBox(height: 20),
                                          Buttons.blueButtonRounded("Verify",
                                              () async {
                                            isVisible = isVisible;
                                            CustomDialog.showDialogTransperent(
                                                context);
                                            bool verified = data
                                                        .successmessage ==
                                                    'Otp sent to register mobile number'
                                                ? await _verifyOtp()
                                                : await verifyOtpGuest();
                                            if (verified) {
                                              isVisible = false;
                                              Navigator.pop(context);
                                              data.successmessage ==
                                                      'Otp sent to register mobile number'
                                                  ? Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DashBoardScreen()),
                                                      (Route<dynamic> route) =>
                                                          false, // This condition removes all routes from the stack.
                                                    )
                                                  : Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          Guestscreen(),
                                                    ));
                                            } else {
                                              // isVisible = !isVisible;
                                              print("OTP verification failed");
                                              Navigator.pop(context);
                                              CustomSnackBar.atBottom(
                                                  title: "Alert",
                                                  body: "Verification failed",
                                                  status: false);
                                            }
                                            otpCtrl?.clear();
                                          })
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              })
                        ]))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------*Email Authentication
class EmailAuth extends StatefulWidget {
  const EmailAuth({
    super.key,
    required this.loginCtrl,
    required this.emailCtrl,
    required this.passwordCtrl,
  });

  final TextEditingController loginCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;

  @override
  State<EmailAuth> createState() => _EmailAuthState();
}

bool isTextObscured = true;

class _EmailAuthState extends State<EmailAuth> {
  // @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailGetx>(
        init: EmailGetx(),
        builder: (controller) {
          return Form(
            key: controller.emailformkey,
            child: Column(
              children: [
                WidgetTextFormField(
                  ctrl: widget.emailCtrl,
                  hinttext: 'Email',
                  validator: (value) => controller.textFormValidation(value),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 20.0, left: 40.0, right: 40.0),
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    validator: (value) {
                      controller.textFormValidation(value);
                    },
                    obscureText: isTextObscured == true ? true : false,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    controller: widget.passwordCtrl,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isTextObscured = !isTextObscured;
                            });
                          },
                          icon: isTextObscured == true
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      contentPadding: EdgeInsets.all(20.0),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                    ),
                  ),
                ),
                Buttons.blueButtonRounded(
                  "Login",
                  () {
                    controller.emailLogin(context);
                  },
                ),
                SizedBox(height: 30.0),
                TextButton(
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Guest? ",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        Text(
                          'Register here',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          );
        });
  }
}

//-----------------------------------------------------------------*Phone Authentication
// class PhoneAuth extends StatefulWidget {
//   const PhoneAuth({
//     super.key,
//     required this.loginCtrl,
//     required this.phoneCtrl,
//     required this.passwordCtrl,
//     required this.otpCtrl,
//     required this.stateUserModelCtrl,
//     // required this.unfocusOtpField,
//   });
//   final TextEditingController loginCtrl;
//   final TextEditingController? phoneCtrl;
//   final TextEditingController? passwordCtrl;
//   final TextEditingController? otpCtrl;
//   final UserModelController stateUserModelCtrl;
//   // final dynamic unfocusOtpField;

//   @override
//   State<PhoneAuth> createState() => _PhoneAuthState();
// }

// class _PhoneAuthState extends State<PhoneAuth> {
//   bool isVisible = false;
//   bool isVisible2 = true;
//   Future<bool> verifyOtpGuest() async {
//     var res = await VerifyOtp(
//             otp: widget.otpCtrl!.text, phone: widget.phoneCtrl!.text)
//         .callguestApi();

//     if (res.statusCode == 201) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<bool> _verifyOtp() async {
//     var res = await VerifyOtp(
//             otp: widget.otpCtrl!.text, phone: widget.phoneCtrl!.text)
//         .callApi();

//     if (res.statusCode == 201) {
//       var body = res.body;
//       final decodedbody = jsonDecode(body);
//       print(" ${decodedbody["status"]}");

//       if (decodedbody["status"]) {
//         //UserModel userData = UserModel(data: body["data"],status: body["status"],message: body["message"]).fromJson;
//         UserModel userData = userModelFromJson(body.toString());
//         // print("fcm2: $userData.data[0].firebase ");

//         FirebaseMessaging messaging = FirebaseMessaging.instance;
//         final fcmToken = await FirebaseMessaging.instance.getToken();

//         // print("fcm2: $fcmToken");

//         await UpdateFcmApi(fcm: fcmToken!, phone: userData.data[0].mobile)
//             .callApi()
//             .then((value) {
//           if (value.statusCode == 201) {
//             userData.data[0].firebase = fcmToken;
//           }
//         });

//         //write fcm to database
//         //update fcm to object

//         await widget.stateUserModelCtrl.updateUserModel(userData);
//         return true;
//       } else {
//         // Navigator.pushNamed(context, GetRoutes.pageLogin);
//         return false;
//       }
//     } else {
//       return false;
//     }
//   }

//   bool showPinPut = true;
//   @override
//   Widget build(BuildContext context) {
//     Get.put(OtpGetx());

//     return GetBuilder<OtpGetx>(
//         init: OtpGetx(),
//         builder: (data) {
//           return Column(
//             children: [
//               WidgetTextFormField(
//                   ctrl: widget.phoneCtrl!,
//                   hinttext: 'Phone',
//                   keyboardtype: TextInputType.phone),
//               SizedBox(height: 20.0),
//               Visibility(
//                 visible: isVisible2,
//                 child: Column(
//                   children: [
//                     Buttons.blueButtonRounded(
//                       "Get OTP",
//                       () async {
//                         FocusScope.of(context).unfocus();
//                         widget.otpCtrl?.clear();
//                         print("loginCtrl" + widget.phoneCtrl.toString());
//                         await data.getOTP(widget.phoneCtrl!.text, context);
//                         // LoginApi(phone: widget.phoneCtrl!.text).callApi(context);
//                         // bool verifiedphone =
//                         if (data.status == true) {
//                           // data.toggleVisibility();
//                           setState(() {
//                             showPinPut = false;
//                             isVisible2 = !isVisible2;
//                             isVisible = !isVisible;
//                           });
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               showPinPut == false
//                   ? Pinput(
//                       focusNode: _otpFocusNode,
//                       scrollPadding: EdgeInsets.only(
//                           bottom: MediaQuery.of(context).viewInsets.bottom),
//                       controller: widget.otpCtrl,
//                       autofocus: true,
//                       defaultPinTheme: PinOtp().defaultPinTheme,
//                       focusedPinTheme: PinOtp().focusedPinTheme,
//                       submittedPinTheme: PinOtp().focusedPinTheme,
//                       showCursor: true,
//                     )
//                   : SizedBox(),
//               isVisible ? SizedBox(height: 0.0) : SizedBox(height: 30.0),
//               Visibility(
//                 visible: isVisible,
//                 child: Column(
//                   children: [
//                     // PinOtp().otp(widget.otpCtrl, context),
//                     SizedBox(height: 20),
//                     Buttons.blueButtonRounded("Verify", () async {
//                       isVisible = isVisible;
//                       CustomDialog.showDialogTransperent(context);
//                       bool verified = data.successmessage ==
//                               'Otp sent to register mobile number'
//                           ? await _verifyOtp()
//                           : await verifyOtpGuest();
//                       if (verified) {
//                         isVisible = false;
//                         Navigator.pop(context);
//                         data.successmessage ==
//                                 'Otp sent to register mobile number'
//                             ? Navigator.of(context).pushAndRemoveUntil(
//                                 MaterialPageRoute(
//                                   builder: (context) => TodayAttendance(),
//                                 ),
//                                 (route) => false)
//                             : Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => Guestscreen(),
//                               ));
//                       } else {
//                         // isVisible = !isVisible;
//                         print("OTP verification failed");
//                         Navigator.pop(context);
//                         CustomSnackBar.atBottom(
//                             title: "Alert",
//                             body: "Verification failed",
//                             status: false);
//                       }
//                       widget.otpCtrl?.clear();
//                     })
//                   ],
//                 ),
//               )
//             ],
//           );
//         });
//   }
// }
