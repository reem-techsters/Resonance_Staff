import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/bank_details_ctrl.dart';
import 'package:attendance/view/pages/finances/bank/add_bank_details_screen.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/list_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<BankDetailsGetx>(
          init: BankDetailsGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.loadresources();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("Bank Details"),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Strings.primaryColor,
                                  minimumSize: Size(180, 50)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ApplyBankDetails(),
                                ));
                                controller.clearTextfield();
                              },
                              child: Text(
                                'Add Bank Details',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ))
                        ]),
                  ),
                  controller.showLoader == true
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : controller.bankList.isEmpty
                          ? Expanded(child: Center(child: CustomError.noData()))
                          : AnimationLimiter(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.bankList.length,
                                    itemBuilder: (context, index) {
                                      final data = controller.bankList[index];
                                      return BankDetailsCardWidget(
                                        index: index,
                                        controller: controller,
                                        data: data,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
