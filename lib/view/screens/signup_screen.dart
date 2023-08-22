import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_app/view/screens/login_screen.dart';
import 'package:video_player/video_player.dart';
import '../../presenter/controller/signup_controller.dart';
import '../widgets/color.dart';
import '../widgets/my_custom_button.dart';
import '../widgets/my_custom_text.dart';
import '../widgets/my_custom_textfield.dart';
class SignupScreen extends StatelessWidget {
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: signupController.formKeys,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/logo.png', height: 40, width: 40),
                      const SizedBox(width: 10),
                      MyCustomTextWidget(index: 3, text: 'SignaLingua'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(child: MyCustomTextWidget(text: 'Create an account !', index: 1)),
                  const SizedBox(height: 100),

                  MyCustomTextWidget(text: 'Signup :', index: 1),
                  const SizedBox(height: 20),

                  DefaultTextField(
                    hintText: 'Full Name',
                    prefixIcon: const Icon(
                      Icons.perm_identity,
                      color: broiColor,
                    ),
                    type: TextInputType.text,
                    controller: signupController.nameController,
                  ),
                  const SizedBox(height: 8),

                  DefaultTextField(
                    hintText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: broiColor,
                    ),
                    type: TextInputType.emailAddress,
                    controller: signupController.mailController,
                    validatorFn: validateEmail,
                  ),
                  const SizedBox(height: 8),

                  GetBuilder<SignupController>(
                    init: SignupController(),
                    builder: (signupController) => DefaultTextField(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock, color: broiColor),
                      controller: signupController.passwordController,
                      type: TextInputType.visiblePassword,
                      validatorFn: validatePassword,
                      obscuretext: signupController.obscurePassword,
                      suffix: signupController.obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      suffixFunction: () {
                        signupController.togglePasswordVisibility();
                      },
                    ),
                  ),

                  const SizedBox(height: 80),
                  CustomButton(
                    buttomHight: 40.0,
                    onPressed: () async {
                      await signupController.signup();
                    },
                    text: 'Signup',
                    primary: beigeColor,
                    onPrimary: Colors.white,
                    sideColor: beigeColor,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Handle navigation to the signup screen or other actions
                      Get.to(() => LoginScreen()); // Example navigation using GetX
                    },
                    child: Text(
                      'Already have an account? Sign up here',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
