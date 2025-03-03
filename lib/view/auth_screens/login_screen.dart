import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskify/controller/LoginController.dart';
import 'package:taskify/utils/appAssets.dart';
import 'package:taskify/utils/appColors.dart';
import 'package:taskify/view/auth_screens/create_accont.dart';
import 'package:taskify/view/home/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = true;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final GlobalKey<FormState> anFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisible = true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anFormKey = GlobalKey<FormState>();
    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 80,
          ),
          child: Form(
            key: anFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    AppAssets.loginIcon,
                    height: 100,
                    width: 100,
                  ),
                ),
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 70),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    obscureText: false,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 10.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.black,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.black,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.green,
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.red,
                          width: 2.0,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      hintText: "Email ID",
                      errorStyle: TextStyle(height: 0.1),
                      hintStyle: TextStyle(
                        fontSize: 13,
                        // color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    obscureText: passwordVisible,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 10.0,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.black,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.black,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.green,
                          width: 2.0,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.red,
                          width: 2.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      hintText: "Password",
                      errorStyle: const TextStyle(height: 0.1),
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        // color: AppColors.primaryColor,
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        foregroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: loginController.isLoading.isTrue
                          ? null
                          : () async {
                              if (anFormKey.currentState!.validate()) {
                                loginController.loginUser(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                      child: loginController.isLoading.isTrue
                          ? const CircularProgressIndicator()
                          : const Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Don't Have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const CreateAccont());
                      },
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
