import 'dart:developer';
import 'package:attendance/controller/model_state/gate_pass_ctrl.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/view/widgets/buttons.dart';
import 'package:attendance/view/widgets/datePickerDialog.dart';
import 'package:attendance/view/widgets/datepicker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class IntimeWidget extends StatefulWidget {
  final UserModelController userModelCtrl;
  final dynamic formid;
  const IntimeWidget({
    super.key,
    required this.formid,
    required this.userModelCtrl,
  });

  @override
  State<IntimeWidget> createState() => _IntimeWidgetState();
}

class _IntimeWidgetState extends State<IntimeWidget> {
  late DateTime intialDate;
  late TextEditingController nullCtrl;
  @override
  void initState() {
    GatePassController().loadresources(true);
    intialDate = DateTime.now();
    nullCtrl = TextEditingController();
    super.initState();
  }

  final formgatepassGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        'IN TIME',
        style: TextStyle(
          color: Color.fromARGB(255, 78, 77, 77),
          letterSpacing: 0.1,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 40),
          child: GetBuilder<GatePassController>(
              init: GatePassController(),
              builder: (controller) {
                return Column(
                  children: [
                    Form(
                      key: formgatepassGlobalKey,
                      child: DatePickerWidget(
                        validator: (value) =>
                            controller.inTimeValidation(value),
                        textController: controller.intimectrl,
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          // final selectedDateTime = 
                          await CustomDatePickerDialog(
                                  intialDate: intialDate)
                              .datePickerSingle(context, nullCtrl, () {})
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

                                  controller.intimectrl.text =
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
                        hintText: 'From',
                        iconName: Icons.calendar_today,
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Buttons.blueButtonReason("SUBMIT", () {
                      if (formgatepassGlobalKey.currentState!.validate()) {
                        formgatepassGlobalKey.currentState!.save();
                        if (controller.intimectrl.text.toString().isNotEmpty) {
                          Get.find<GatePassController>().inTimeCall(
                              controller.intimectrl.text.toString(),
                              int.parse(widget.formid));
                          Navigator.pop(context);
                        }
                      }
                    }),
                  ],
                );
              }),
        )
      ],
    );
  }
}
