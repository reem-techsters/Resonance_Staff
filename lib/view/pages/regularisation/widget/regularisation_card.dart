import 'dart:convert';
import 'package:attendance/controller/model_state/my_attendance_ctrl.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/regularisation_model.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';

class RegularisationCardWidget extends StatelessWidget {
  final List<ToRegularise>? dataList;
  final int index;
  const RegularisationCardWidget(
      {super.key, required this.dataList, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color.fromRGBO(246, 244, 238, 1),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRichText.customRichText(
                  "Type :",
                  dataList![index].inOut == "0"
                      ? "Late Login"
                      : "Early Logout"),
              CustomRichText.customRichText(
                  "Employee Name :", dataList![index].name),
              CustomRichText.customRichText(
                "Date :",
                dataList![index].date,
              ),
              dataList![index].loginregularised != "1" &&
                      dataList![index].loginregularised != "0"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          CustomRichText.customRichText(
                              "Late Login ${Strings.reason} :",
                              dataList![index].lateLoginReason),
                          SizedBox(height: 10.0),
                          RegularisationButton(
                            index: index,
                            dataList: dataList,
                          ),
                          SizedBox(height: 10.0),
                        ])
                  : SizedBox(),
              dataList![index].logoutregularised != "1" &&
                      dataList![index].logoutregularised != "0"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRichText.customRichText(
                            "Early Logout ${Strings.reason} :",
                            dataList![index].earlyLoginReason),
                        SizedBox(height: 10.0),
                        RegularisationButton(
                          index: index,
                          dataList: dataList,
                        )
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ));
  }
}

class RegularisationButton extends StatelessWidget {
  final int index;
  final List<ToRegularise>? dataList;
  const RegularisationButton(
      {super.key, required this.index, required this.dataList});

  @override
  Widget build(BuildContext context) {
    String log =
        dataList![index].inOut == "0" ? "regularizelogin" : "regularizelogout";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //------------------------------APPROVE BTN
        ElevatedButton(
          onPressed: () async {
            try {
              CustomDialog.showDialogTransperent(context);
              http.Response res = await http.get(Uri.parse(
                  "${Strings.baseUrl}$log?attendanceId=${dataList![index].attendanceId}&regularised=1"));
              print("login REGULARISED api called ${res.statusCode}");

              if (res.statusCode == 201) {
                Navigator.pop(context);

                var body = jsonDecode(res.body);
                if (body["status"]) {
                  MyAttendanceModelController().loadresources(true);
                  CustomSnackBar.atBottom(
                    title: "Status",
                    body: log,
                  );
                } else {
                  CustomSnackBar.atBottom(
                      title: "Status", body: "Failed", status: false);
                }
              } else {
                Navigator.pop(context);
                CustomSnackBar.atBottom(
                    title: "Status", body: "Failed", status: false);
              }
            } catch (e) {
              Navigator.pop(context);
              Navigator.pop(context);
              print("OTP error$e");
            }
          },
          style: Styles.blueButton,
          child: Text(style: Styles.latoButtonText, "Approve"),
        ),
        SizedBox(
          width: Strings.width(context) / 15,
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              CustomDialog.showDialogTransperent(context);
              http.Response res = await http.get(Uri.parse(
                  "${Strings.baseUrl}$log?attendanceId=${dataList![index].attendanceId}&regularised=0"));
              print("login REGULARISED api called ${res.statusCode}");

              if (res.statusCode == 201) {
                Navigator.pop(context);

                var body = jsonDecode(res.body);
                if (body["status"]) {
                  CustomSnackBar.atBottom(
                      title: "Status", body: "Request Rejected");
                } else {
                  CustomSnackBar.atBottom(
                      title: "Status", body: "Failed", status: false);
                }
              } else {
                Navigator.pop(context);
                CustomSnackBar.atBottom(
                    title: "Status", body: "Failed", status: false);
              }
            } catch (e) {
              Navigator.pop(context);
              Navigator.pop(context);
              print("OTP error$e");
            }
          },
          style: Styles.redButton,
          child: Text(style: Styles.latoButtonText, "   Reject   "),
        )
      ],
    );
  }
}
