import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/leave_request_ctrl.dart';
import 'package:attendance/view/pages/approve_leaves/student_search.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/list_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<LeaveRequestController>(
          init: LeaveRequestController(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.loadresources();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("Student "),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 15, right: 15.0),
                    child: InkWell(
                      onTap: () {
                        controller.searchData.clear();
                        controller.searchCtrl.clear();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              StudentSearchScreen(title: 'Student'),
                        ));
                      },
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Strings.primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Strings.primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Strings.primaryColor),
                          ),
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ),
                  controller.showLoader == true
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : controller.studentlist.isEmpty
                          ? Expanded(child: Center(child: CustomError.noData()))
                          : AnimationLimiter(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.studentlist.length,
                                    itemBuilder: (context, index) {
                                      final data =
                                          controller.studentlist[index];
                                      return StudentCardWidget(
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
