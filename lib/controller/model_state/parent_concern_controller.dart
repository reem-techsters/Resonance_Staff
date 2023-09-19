import 'dart:developer';
import 'package:attendance/model/parent_concern_model.dart';
import 'package:attendance/service/parent_concern_services.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class ParentConcernGetx extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await callParentConcernList(
        int.parse(GetUserData().getCurrentUser().userid));
    log('userid --> ${GetUserData().getCurrentUser().userid}');
  }

  List<Datum> parentConcernlist = [];

  bool showLoader = true;
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
  Future<void> callResolved(int studentid, int id) async {
    int? response =
        (await ParentConcernService().getResolvedList(studentid, id));
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
  Future<void> loadresources(bool reload) async {
    Get.put(ParentConcernGetx());

    await Get.find<ParentConcernGetx>().callParentConcernList(
        int.parse(GetUserData().getCurrentUser().userid));
  }
}
