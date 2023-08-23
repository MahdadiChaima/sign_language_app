import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:sign_app/view/screens/signup_screen.dart';

import '../../presenter/controller/login_controller.dart';
import '../widgets/color.dart';
import '../widgets/my_custom_button.dart';
import '../widgets/my_custom_text.dart';
import '../widgets/my_custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  // ... (other variables and methods above) ...

  final LoginController loginController = Get.put(LoginController());
  List<String> selectedLetters = [];
  final FlutterTts flutterTts = FlutterTts();
  final List<String> alphabetLetters = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    ' ',
    '@',
    '.',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/logo.png',
                        height: 40, width: 40),
                    const SizedBox(width: 10),
                    MyCustomTextWidget(index: 3, text: 'Signlingo'),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                    child:
                        MyCustomTextWidget(text: 'Welcome back !', index: 1)),
                const SizedBox(height: 100),
                MyCustomTextWidget(text: 'Login :', index: 1),
                const SizedBox(height: 20),
                DefaultTextField(
                  hintText: 'Email',
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: broiColor,
                  ),
                  type: TextInputType.emailAddress,
                  controller: loginController.mailController,
                  validatorFn: validateEmail,
                ),
                const SizedBox(height: 8),
                GetBuilder<LoginController>(
                  init: LoginController(),
                  builder: (loginController) => DefaultTextField(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock, color: broiColor),
                    controller: loginController.passwordController,
                    type: TextInputType.visiblePassword,
                    validatorFn: validatePassword,
                    obscuretext: loginController.obscurePassword,
                    suffix: loginController.obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    suffixFunction: () {
                      loginController.togglePasswordVisibility();
                    },
                  ),
                ),
                const SizedBox(height: 80),
                CustomButton(
                  buttomHight: 40.0,
                  onPressed: () async {
                    await loginController.login();
                  },
                  text: 'LogIn',
                  primary: beigeColor,
                  onPrimary: Colors.white,
                  sideColor: beigeColor,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Handle navigation to the signup screen or other actions
                    Get.to(
                        () => SignupScreen()); // Example navigation using GetX
                  },
                  child: Text(
                    'Dont have account? Sign up ',
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
    );
  }
}

// ... (other classes and code below) ...
