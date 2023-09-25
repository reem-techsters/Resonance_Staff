import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/service/services_api/api.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/model/gate_pass_model.dart';
import 'package:get/get.dart';

class GatePassController extends GetxController {
  var stateGatePassRequestModel = <GatePassModel>[].obs;
  final TextEditingController intimectrl = TextEditingController();

  updateGatePassModel(GatePassModel obj) {
    stateGatePassRequestModel.add(obj);
  }

  bool showLoader = true;
  TextEditingController searchCtrl = TextEditingController();
  List<dynamic> searchData = [];
  List<Data> gatepassList = [];
  getSearchResult(String value) {
    log('getSearchResult GATEPASS');
    searchData.clear();
    for (var i in gatepassList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.applicationnumber
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase())) {
        Data data = Data(
          formrequestid: i.formrequestid,
          approveddate: i.approveddate,
          approvedby: i.approvedby,
          status: i.status,
          createdtimestamp: i.createdtimestamp,
          updatedtimestamp: i.updatedtimestamp,
          name: i.name,
          purpose: i.purpose,
          toDate: i.toDate,
          fromDate: i.fromDate,
          gaurdian: i.gaurdian,
          indata: i.indata,
          updatedby: i.updatedby,
          applicationnumber: i.applicationnumber,
        );
        update();
        searchData.add(data);
        update();
      }
    }
  }

//---------------------------------------------*IN-TIME VALIDATION
  inTimeValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return CustomSnackBar.atBottom(
          title: 'Enter In-Time To Submit',
          body: 'This is required',
          status: false);
    }
    return null;
  }

//---------------------------------------------*OUT PASS LIST
  Future<bool> getGatePassModel(String userid, String branchId) async {
    print("init $userid");
    try {
      var res = await GateOutApi(userid: userid, branchId: branchId).callApi();
      if (res.statusCode == 201) {
        var body = res.body;
        final decodedbody = jsonDecode(body);
        print(" stat --> ${decodedbody["status"]}");
        print(" GATEPASS CTRL ---$body");

        if (decodedbody["status"]) {
          //UserModel userData = UserModel(data: body["data"],status: body["status"],message: body["message"]).fromJson;
          GatePassModel userData = gatePassModelFromJson(body.toString());
          await updateGatePassModel(userData);
          gatepassList = userData.data;
          update();
          return true;
        } else {
          CustomSnackBar.atBottom(
              title: "GatePass Request", body: "error", status: false);
          return false;
        }
      } else {
        CustomSnackBar.atBottom(
            title: "GatePass", body: res.statusCode.toString(), status: false);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//---------------------------------------------*IN-TIME
  Future<void> inTimeCall(dynamic intime, dynamic formid) async {
    // https://maidendropgroup.com/public/api/studentoutpassedit?form_request_id=1939&intime=2023-06-26%2017:12
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}studentoutpassedit?form_request_id=$formid&intime=$intime'));
      log('intime --> $intime');
      log('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(
            title: 'Succesful', body: 'In-Time Added Succesfully');
      } else {
        CustomSnackBar.atBottom(
            title: 'Failed', body: 'Failed To Add In-Time', status: false);
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  //-------------------------------------------------------*REFRESH LOADER / INDICATOR
  Future<void> loadresources(bool reload) async {
    Get.put(GatePassController());

    await Get.find<GatePassController>().getGatePassModel(
        GetUserData().getCurrentUser().userid,
        GetUserData().getCurrentUser().branchid);
  }
}
