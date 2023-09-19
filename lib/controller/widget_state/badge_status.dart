import 'package:attendance/model/user_model.dart';
import 'package:get/get.dart';
import 'package:attendance/model/user_model.dart';

class BadgeStatusController extends GetxController{
 var stateBadgeStatus = false.obs;
 var stateIsVisible = false.obs;


 updateBadgeStatus(bool obj){
  
stateBadgeStatus.value = obj;
print("stateBadgeStatus.value ${stateBadgeStatus.value }");

 }

  updateIsVisible(bool obj) {
    stateIsVisible.value = obj;
    print("stateIsVisible.value ${stateIsVisible.value}");
  }
}