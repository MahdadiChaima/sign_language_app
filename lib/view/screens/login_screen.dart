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
  final LoginController loginController = Get.put(LoginController());
  List<String> selectedLetters = [];
  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: bcielColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Padding(
          padding: EdgeInsets.all(4),
          child: MyCustomTextWidget(index: 8, text: 'Login'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomTextWidget(index: 1, text: 'Welcome Back !'),
            SizedBox(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onPressed: () => loginController.toggleContainer1(),
                  buttonwidth: 150.0,
                  text: 'Signs',
                  primary: beigeColor,
                  onPrimary: Colors.white,
                  sideColor: beigeColor,
                  icon: Icons.sign_language,
                ),
                const SizedBox(width: 20),
                CustomButton(
                  onPressed: () => loginController.toggleContainer2(),
                  buttonwidth: 150.0,
                  text: 'Letters',
                  primary: broiColor,
                  onPrimary: Colors.white,
                  sideColor: broiColor,
                  icon: Icons.sort_by_alpha,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.08),
            Expanded(
              child: Obx(
                () => Stack(
                  children: [
                    // Container 2
                    if (loginController.showContainer2.isTrue)
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            MyCustomTextWidget(index: 1, text: 'Letters'),
                            const SizedBox(height: 10),
                            DefaultTextField(
                              hintText: 'Email',
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: broiColor,
                              ),
                              type: TextInputType.emailAddress,
                              controller: loginController.mailController,
                            ),
                            const SizedBox(height: 8),
                            GetBuilder<LoginController>(
                              init: LoginController(),
                              builder: (loginController) => DefaultTextField(
                                hintText: 'Password',
                                prefixIcon:
                                    const Icon(Icons.lock, color: broiColor),
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
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Get.find<LoginController>().resetPassword();
                              },
                              child: Center(
                                child: MyCustomTextWidget(
                                  text: 'Forget Password?',
                                  index: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 150),
                            CustomButton(
                              onPressed: () async {
                                await loginController.login();
                              },
                              text: 'Login',
                              primary: beigeColor,
                              onPrimary: Colors.white,
                              sideColor: beigeColor,
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                // Handle navigation to the signup screen or other actions
                                Get.to(() =>
                                    SignupScreen()); // Example navigation using GetX
                              },
                              child: MyCustomTextWidget(
                                  index: 14,
                                  text:
                                      'Already have an account? Sign up here'),
                            ),
                          ],
                        ),
                      ),
                    // Container 1
                    if (loginController.showContainer1.isTrue)

                       Column(
                          children: [
                            MyCustomTextWidget(index: 1, text: 'Signs'),
                            const SizedBox(height: 10),
                            DefaultTextField(
                              hintText: 'Email',
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: broiColor,
                              ),
                              type: TextInputType.none,
                              controller: loginController.mailController,
                            ),
                            const SizedBox(height: 8),
                            GetBuilder<LoginController>(
                              init: LoginController(),
                              builder: (loginController) => DefaultTextField(
                                hintText: 'Password',
                                prefixIcon:
                                    const Icon(Icons.lock, color: broiColor),
                                controller: loginController.passwordController,
                                type: TextInputType.none,
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
                            GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                              ),
                              itemCount: 26,
                              itemBuilder: (BuildContext context, int index) {
                                String letter = String.fromCharCode(
                                    97 + index); // a-z or A-Z
                                String imagePath =
                                    'assets/images/alphabet/$letter.png';

                                return GestureDetector(
                                    onTap: () {
                                      selectedLetters.add(letter);
                                    },
                                    child: Image.asset(
                                      imagePath,
                                      width: 50,
                                      height: 50,
                                    ));
                              },
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Get.find<LoginController>().resetPassword();
                              },
                              child: Center(
                                child: MyCustomTextWidget(
                                  text: 'Forget Password?',
                                  index: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 150),
                            CustomButton(
                              onPressed: () async {
                                await loginController.login();
                              },
                              text: 'Login',
                              primary: beigeColor,
                              onPrimary: Colors.white,
                              sideColor: beigeColor,
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                // Handle navigation to the signup screen or other actions
                                Get.to(() =>
                                    SignupScreen()); // Example navigation using GetX
                              },
                              child: MyCustomTextWidget(
                                  index: 14,
                                  text:
                                      'Already have an account? Sign up here'),
                            ),
                          ],
                        ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
