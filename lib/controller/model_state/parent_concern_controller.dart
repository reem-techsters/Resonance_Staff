import 'dart:developer';
import 'package:attendance/model/parent_concern_model.dart';
import 'package:attendance/service/parent_concern_services.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParentConcernGetx extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await callParentConcernList(
        int.parse(GetUserData().getCurrentUser().userid));
    log('userid --> ${GetUserData().getCurrentUser().userid}');
    getSearchResult(searchCtrl.text);
  }

  TextEditingController commentCtrl = TextEditingController();
  List<Datum> parentConcernlist = [];

  bool showLoader = true;
  TextEditingController searchCtrl = TextEditingController();
  List<dynamic> searchData = [];
  getSearchResult(String value) {
    searchData.clear();
    for (var i in parentConcernlist) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.fathername.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.applicationnumber
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase())) {
        Datum data = Datum(
          image: i.image,
          categoryname: i.categoryname,
          studentId: i.studentId,
          concernId: i.concernId,
          category: i.category,
          subCategory: i.subCategory,
          details: i.details,
          fromTime: i.fromTime,
          toTime: i.toTime,
          status: i.status,
          feedback: i.feedback,
          feedbackreason: i.feedbackreason,
          createdDate: i.createdDate,
          subcategoryname: i.subCategory,
          name: i.name,
          applicationnumber: i.applicationnumber,
          branchname: i.branchname,
          fathername: i.fathername,
        );
        update();
        searchData.add(data);
        update();
      }
    }
  }

  Future<void> callParentConcernList(int userid) async {
    Parent? response =
        await ParentConcernService().getParentConcernList(userid);
    if (response != null) {
      if (response.data != null) {
        update();
        parentConcernlist = response.data ?? [];
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    showLoader = false;
    update();
  }

//--------------------------------------------------*Sending status (Pending --> In Progress)
  Future<void> callInProgress(int studentid, int id) async {
    int? response =
        await ParentConcernService().getInProgressList(studentid, id);
    if (response != null) {
      if (response >= 200 && response <= 299) {
        CustomSnackBar.atBottom(title: "STATUS", body: "Success");
      } else {
        CustomSnackBar.atBottom(status: false, title: "STATUS", body: "failed");
      }
    } else {
      log('null');
    }
  }

//--------------------------------------------------*Sending status (In Progress --> Resolved)
  Future<void> callResolved(int studentid, int id, String comments) async {
    int? response =
        (await ParentConcernService().getResolvedList(studentid, id, comments));
    if (response != null) {
      if (response >= 200 && response <= 299) {
        CustomSnackBar.atBottom(title: "STATUS", body: "Success");
      } else {
        CustomSnackBar.atBottom(status: false, title: "STATUS", body: "failed");
      }
    } else {
      log('null');
    }
  }

  //-------------------------------------------------------*Refresh Loader
  Future<void> loadresources() async {
    Get.put(ParentConcernGetx());

    await Get.find<ParentConcernGetx>().callParentConcernList(
        int.parse(GetUserData().getCurrentUser().userid));
  }
}
