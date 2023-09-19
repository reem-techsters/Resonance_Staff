import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';



class LogController extends GetxController{


var logState = true.obs;

var isLatelogin = false.obs;
var isEarlyLogout = false.obs;

void updateLogState(bool val){

logState.value = val;
print(logState.value );

}






}