import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  bool passwordVisible = true,isLoggedIn=false;
  SharedPreferences prefs;
  void visiblePassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  void isLoggedInCheck(bool val) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", val);
    update();
  }
}
