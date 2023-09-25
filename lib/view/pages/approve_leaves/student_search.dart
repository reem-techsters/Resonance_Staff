import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/leave_request_ctrl.dart';
import 'package:attendance/view/widgets/list_cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentSearchScreen extends StatefulWidget {
  final String title;
  const StudentSearchScreen({
    super.key,
    required this.title,
  });

  @override
  State<StudentSearchScreen> createState() => _StudentSearchScreenState();
}

class _StudentSearchScreenState extends State<StudentSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LeaveRequestController>(
        init: LeaveRequestController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.searchData.clear();
                  controller.searchCtrl.clear();
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: Text(widget.title),
              backgroundColor: Strings.primaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    controller: controller.searchCtrl,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Strings.primaryColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Strings.primaryColor),
                      ),
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Strings.primaryColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    onChanged: (value) {
                      setState(() {
                        controller.getSearchResultStudent(value);
                      });
                    },
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final data = controller.searchDataStudent[index];
                          return data.name.toLowerCase().contains(controller
                                      .searchCtrl.text
                                      .toLowerCase()) ||
                                  data.applicationnumber.toLowerCase().contains(
                                      controller.searchCtrl.text.toLowerCase())
                              ? StudentCardWidget(
                                  index: index,
                                  data: data,
                                  controller: controller,
                                )
                              : SizedBox();
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox();
                        },
                        itemCount: controller.searchDataStudent.length),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
