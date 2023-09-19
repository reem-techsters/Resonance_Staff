import 'package:get/get.dart';

import '../controller/widget_state/selected_page.dart';

class WidgetState{

SelectedPage selectedPageCtrl = Get.put(SelectedPage());


  int getSelectedPage(){
    return selectedPageCtrl.stateSelectedPage.value;
  }

   int updateSelectedPage(int val) {
    return selectedPageCtrl.stateSelectedPage.value = val;
  }
}