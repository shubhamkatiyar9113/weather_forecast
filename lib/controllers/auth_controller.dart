import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/home/home_screen.dart';
import '../views/login/login_screen.dart';

class AuthController extends GetxController {

  RxBool isLoggedIn = false.obs;


  /// SIGNUP
  Future<void> signup(
      String name,
      String email,
      String password,
      ) async {

    final prefs = await SharedPreferences.getInstance();
    String? savedEmail =
    prefs.getString("email");
    if (savedEmail == email) {

      Get.snackbar(
        "Error",
        "Email already exists",
      );

      return;
    }

    await prefs.setString("name", name);
    await prefs.setString("email", email);
    await prefs.setString("password", password);
    await prefs.setBool("login", true);

    isLoggedIn.value = true;

    Get.snackbar(
      "Success",
      "Account Created",
    );

    Get.offAll(() => HomeScreen());
  }

  /// LOGIN
  Future<void> login(
      String email,
      String password,
      ) async {

    final prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString("email");
    String? savedPassword = prefs.getString("password");

    if (email == savedEmail && password == savedPassword) {

      await prefs.setBool("login", true);

      isLoggedIn.value = true;

      Get.snackbar(
        "Success",
        "Login Successful",
      );

      Get.offAll(() => HomeScreen());

    } else {

      Get.snackbar(
        "Error",
        "Invalid Credentials",
      );
    }
  }

  /// AUTO LOGIN CHECK
  Future<void> checkLogin() async {

    final prefs = await SharedPreferences.getInstance();

    bool status = prefs.getBool("login") ?? false;

    isLoggedIn.value = status;

    if (status) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  /// LOGOUT
  Future<void> logout() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("login", false);

    isLoggedIn.value = false;

    Get.snackbar(
      "Logged Out",
      "You have been logged out",
    );

    Get.offAll(() => LoginScreen());
  }

  /// 🔥 FORGOT PASSWORD (NEW FEATURE)
  Future<void> resetPassword(String email, String newPassword) async {

    final prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString("email");

    if (email == savedEmail) {

      await prefs.setString("password", newPassword);

      Get.snackbar(
        "Success",
        "Password updated successfully",
      );

      Get.offAll(() => LoginScreen());

    } else {

      Get.snackbar(
        "Error",
        "Email not found",
      );
    }
  }
}