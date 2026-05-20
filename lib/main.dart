import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'views/home/home_screen.dart';
import 'views/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

        getPages: [

          GetPage(
            name: "/login",
            page: () => LoginScreen(),
          ),

          GetPage(
            name: "/home",
            page: () => HomeScreen(),
          ),
        ],

      home: FutureBuilder(

        future: controller.checkLogin(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Scaffold(
              backgroundColor: Colors.black,

              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.limeAccent,
                ),
              ),
            );
          }

          return controller.isLoggedIn.value
              ? HomeScreen()
              : LoginScreen();
        },
      ),
    );
  }
}