import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TabindexController extends GetxController {
  int selectedindexTab = 0;
  get indexTab => selectedindexTab;
  set indexTab(index) {
    selectedindexTab = index;
    update();
  }
}
