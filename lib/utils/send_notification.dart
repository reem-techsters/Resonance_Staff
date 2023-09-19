import '../constant/strings.dart';
import 'package:http/http.dart' as http;

class SendNotification {
  String fcm;
  String title;
  String body;

  SendNotification(
      {required this.fcm, required this.title, required this.body});

  callApi() async {
    String url =
        "${Strings.baseUrl}pushnotification?body=$body&title=$title&token=$fcm";
    print(url);
    try {
      http.Response res = await http.get(Uri.parse(url));

      print("SendNotification api called ${res.statusCode}");

      return res;
    } catch (e) {
      print("RequestLeaveApi res$e");

      throw "";
    }
  }
}
