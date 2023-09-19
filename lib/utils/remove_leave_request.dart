import 'package:attendance/controller/model_state/leave_request_ctrl.dart';
import 'package:get/instance_manager.dart';

class RemoveLeaveRequest{

LeaveRequestController leaveRequestCntrl = Get.find<LeaveRequestController>();

 void removeRequest(String leaverequestid)async{

  print("removeRequest");
  print(leaveRequestCntrl.stateLeaveRequestModel.last.data.toString());

leaveRequestCntrl.stateLeaveRequestModel.last.data.removeWhere((element) => element.leaverequestid==leaverequestid);
    print("removeRequest after");
print(leaveRequestCntrl.stateLeaveRequestModel.last.data.toString());
}

}