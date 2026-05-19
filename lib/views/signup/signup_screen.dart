import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final controller = Get.put(AuthController());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isPasswordHidden = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [

          /// 🌌 BACKGROUND
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

          /// 🔥 UI
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
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// TITLE
                    const Center(
                      child: Text(
                        "Create Account",
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
                        "Join weather experience",
                        style: TextStyle(color: Colors.grey.shade300),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// NAME
                    _inputField(
                      controller: nameController,
                      hint: "Full Name",
                      icon: Icons.person,
                    ),

                    const SizedBox(height: 20),

                    /// EMAIL
                    _inputField(
                      controller: emailController,
                      hint: "Email",
                      icon: Icons.email,
                    ),

                    const SizedBox(height: 20),

                    /// PASSWORD LABEL
                    const Text(
                      "Password",
                      style: TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 10),

                    /// PASSWORD FIELD
                    Obx(() => _passwordField()),

                    const SizedBox(height: 35),

                    /// SIGNUP BUTTON
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
                          controller.signup(
                            nameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },

                        child: const Text(
                          "REGISTER",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// LOGIN
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have account?",
                          style: TextStyle(color: Colors.white),
                        ),

                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text(
                            "Sign In",
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

  /// PASSWORD FIELD (FIXED + SAFE)
  Widget _passwordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: TextField(
        controller: passwordController,
        obscureText: isPasswordHidden.value,
        style: const TextStyle(color: Colors.white),

        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Create password",
          hintStyle: const TextStyle(color: Colors.grey),

          prefixIcon: const Icon(Icons.lock, color: Colors.white),

          suffixIcon: IconButton(
            onPressed: () {
              isPasswordHidden.value = !isPasswordHidden.value;
            },
            icon: Icon(
              isPasswordHidden.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  /// INPUT FIELD
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: TextField(
        controller: controller,
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

  /// CLOUD
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
}