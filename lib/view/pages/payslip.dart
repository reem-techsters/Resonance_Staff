import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/payslip_ctrl.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PaySlip extends StatelessWidget {
  const PaySlip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomAppBar(Strings.paySlip),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 50.0, 12.0, 12.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.width,
                child: GetBuilder<PaySlipGetx>(
                  init: PaySlipGetx(),
                  builder: (controller) {
                    return controller.showLoader
                        ? Center(child: CircularProgressIndicator())
                        : controller.payslipList.isEmpty
                            ? Center(child: CustomError.noData())
                            : ListView.separated(
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: Colors.white,
                                    height:
                                        MediaQuery.of(context).size.width / 40,
                                    thickness: 0.0,
                                  );
                                },
                                itemCount: controller.payslipList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    tileColor: Color.fromRGBO(246, 244, 238, 1),
                                    leading: CustomRichText.customRichText(
                                        "Salary Date: ",
                                        controller.payslipformatDate(controller
                                            .payslipList[index].salarydate!)),
                                    trailing: TextButton(
                                      onPressed: () async {
                                        await launchUrl(Uri.parse(controller
                                            .payslipList[index].payslip!));
                                      },
                                      style: Styles.RoundButton,
                                      child: Text(
                                        "Download",
                                        style: Styles.latoButtonText
                                            .copyWith(fontSize: 13.0),
                                      ),
                                    ),
                                  );
                                },
                              );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
