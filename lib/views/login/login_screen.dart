import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../signup/signup_screen.dart';
import '../login/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(AuthController());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [

          /// 🌌 GRADIENT BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// ☁️ CLOUDS
          Positioned(top: 80, left: -40, child: _cloud(140)),
          Positioned(top: 200, right: -30, child: _cloud(180)),
          Positioned(bottom: 160, left: 20, child: _cloud(160)),

          /// 🔥 MAIN UI
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 20),

                    /// BACK BUTTON
                    CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// ICON
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Colors.limeAccent, Colors.green],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.limeAccent.withOpacity(0.3),
                              blurRadius: 40,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// TITLE
                    const Center(
                      child: Text(
                        "Welcome Back!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Center(
                      child: Text(
                        "Login to continue your weather journey",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 15,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// EMAIL
                    const Text("Email", style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 10),

                    _inputField(
                      controller: emailController,
                      hint: "example@gmail.com",
                      icon: Icons.email,
                    ),

                    const SizedBox(height: 20),

                    /// PASSWORD
                    const Text("Password", style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 10),

                    _inputField(
                      controller: passwordController,
                      hint: "Enter password",
                      icon: Icons.lock,
                      obscure: true,
                    ),

                    const SizedBox(height: 10),

                    /// FORGOT PASSWORD
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => ForgotPasswordScreen());
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.limeAccent),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.limeAccent,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),

                        onPressed: () {
                          controller.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },

                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// SIGNUP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.white),
                        ),

                        TextButton(
                          onPressed: () {
                            Get.to(() => SignupScreen());
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.limeAccent),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ☁️ CLOUD WIDGET
  Widget _cloud(double size) {
    return Container(
      height: size,
      width: size * 1.6,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }

  /// INPUT FIELD
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}