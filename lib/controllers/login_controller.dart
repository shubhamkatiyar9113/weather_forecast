import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/home/home_screen.dart';

class LoginController extends GetxController {
  var isLoggedIn = false.obs;

  Future<void> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // simple fake validation (you can replace with API later)
    if (email.isNotEmpty && password.isNotEmpty) {
      await prefs.setBool("isLoggedIn", true);
      await prefs.setString("email", email);

      isLoggedIn.value = true;

      Get.offAll(() => HomeScreen());
    } else {
      Get.snackbar("Error", "Please enter email & password");
    }
  }

  Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? status = prefs.getBool("isLoggedIn") ?? false;

    isLoggedIn.value = status;

    if (status == true) {
      Get.offAll(() => HomeScreen());
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    isLoggedIn.value = false;

    Get.offAllNamed("/login");
  }
}