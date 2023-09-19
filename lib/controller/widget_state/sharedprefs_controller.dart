import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProvGetnSet extends GetxController {
  String? savedResponse;

  Future<void> getSavedResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedResponse = prefs.getString('apiRoleid');
    update();
  }
}
