import 'dart:developer';
import 'package:attendance/controller/model_state/my_attendance_ctrl.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/pages/regularisation/outsidework_search.dart';
import 'package:attendance/view/pages/regularisation/regularise_search.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/list_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class OutsideWorkScreen extends StatelessWidget {
  const OutsideWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.put(MyAttendanceModelController())
          .getoutsideWorkList(GetUserData().getUserId());
      log(GetUserData().getUserId());
    });
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<MyAttendanceModelController>(
          init: MyAttendanceModelController(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.outsideworkloadresources(true);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("Absent/Outside Work"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        controller.searchData.clear();
                        controller.searchCtrl.clear();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OutsideWorkSearchScreen(
                              title: 'Absent/Outside Work'),
                        ));
                      },
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ),
                  controller.isloader
                      ? Expanded(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : controller.outsideWorkList.isEmpty
                          ? Expanded(
                              child: Center(child: CustomError.noData()),
                            )
                          : AnimationLimiter(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.outsideWorkList.length,
                                    itemBuilder: (context, index) {
                                      final data =
                                          controller.outsideWorkList[index];
                                      return OutsideCardWidget(
                                        index: index,
                                        data: data,
                                        controller: controller,
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
