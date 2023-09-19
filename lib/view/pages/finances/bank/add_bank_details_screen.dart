import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/bank_details_ctrl.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyBankDetails extends StatelessWidget {
  const ApplyBankDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<BankDetailsGetx>(
            init: BankDetailsGetx(),
            builder: (controller) {
              return Form(
                key: controller.bankformkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      "Add Bank Details",
                      widget: IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                            controller.clearTextfield();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.0),
                            Text("Bank Name",
                                style: Styles.robotoTextFieldStyle),
                            SizedBox(height: 10.0),
                            WidgetTextFormField(
                                validator: (value) =>
                                    controller.textFormValidation(value),
                                leftandrightpadding: 0.0,
                                ctrl: controller.bankNameController,
                                hinttext: "Bank Name",
                                borderSide: BorderSide(
                                    color: Strings.primaryColor, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0))),
                            Text("Branch Name",
                                style: Styles.robotoTextFieldStyle),
                            SizedBox(height: 10.0),
                            WidgetTextFormField(
                                validator: (value) =>
                                    controller.textFormValidation(value),
                                leftandrightpadding: 0.0,
                                ctrl: controller.branchNameController,
                                hinttext: "Branch Name",
                                borderSide: BorderSide(
                                    color: Strings.primaryColor, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0))),
                            Text("Account Number",
                                style: Styles.robotoTextFieldStyle),
                            SizedBox(height: 10.0),
                            WidgetTextFormField(
                                validator: (value) =>
                                    controller.textFormValidation(value),
                                leftandrightpadding: 0.0,
                                ctrl: controller.accountNumberController,
                                hinttext: "Account Number",
                                borderSide: BorderSide(
                                    color: Strings.primaryColor, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0))),
                            Text("IFSC Code",
                                style: Styles.robotoTextFieldStyle),
                            SizedBox(height: 10.0),
                            WidgetTextFormField(
                                validator: (value) =>
                                    controller.textFormValidation(value),
                                leftandrightpadding: 0.0,
                                ctrl: controller.ifscController,
                                hinttext: "IFSC Code",
                                borderSide: BorderSide(
                                    color: Strings.primaryColor, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0))),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Strings.primaryColor,
                                      minimumSize: Size(150, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  onPressed: () {
                                    controller.addBankList(context);
                                  },
                                  child: Text(
                                    "Submit",
                                    style: Styles.poppinsBold
                                        .copyWith(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    ));
  }
}
