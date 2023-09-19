import 'package:attendance/controller/model_state/gate_pass_ctrl.dart';
import 'package:attendance/controller/model_state/leave_request_ctrl.dart';
import 'package:get/instance_manager.dart';

class RemoveGatePass {
  GatePassController gatePassCntrl = Get.find<GatePassController>();

  void removeRequest(String formrequestid) async {
    print("RemoveGatePass ${gatePassCntrl.stateGatePassRequestModel.last.data.length.toString()}");
   // print(gatePassCntrl.stateGatePassRequestModel.last.data.toString());

    gatePassCntrl.stateGatePassRequestModel.last.data
        .removeWhere((element) => element.formrequestid == formrequestid);
       gatePassCntrl.stateGatePassRequestModel.refresh(); 
    print("RemoveGatePass after ${gatePassCntrl.stateGatePassRequestModel.last.data.length.toString()}");
   // print(gatePassCntrl.stateGatePassRequestModel.last.data.toString());
  }
}
