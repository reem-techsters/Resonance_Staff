import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SelectedPage extends GetxController {
  var stateSelectedPage = 0.obs;

  var isLatelogin = false.obs;
  var isEarlyLogout = false.obs;

  void updateSelectedPage(int val) {
    log("select index = $val");
    stateSelectedPage.value = val;
    print(stateSelectedPage.value);
  }
}
