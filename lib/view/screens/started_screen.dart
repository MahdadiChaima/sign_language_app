import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/color.dart';
import '../widgets/my_custom_button.dart';
import '../widgets/my_custom_text.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class StartedScreen extends StatelessWidget {
  const StartedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MyCustomTextWidget(
                    index: 3,
                    text: 'Signlingo',
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/images/started.png',
                width: 250,
                height: 250,
              ),
              const SizedBox(
                height: 80,
              ),
              MyCustomTextWidget(
                index: 2,
                text: 'Welcome to SignLinguo,',
              ),
              const SizedBox(
                height: 15,
              ),
              MyCustomTextWidget(
                index: 2,
                text: 'Where Learn Sign Language Easy',
              ),
              const SizedBox(
                height: 90,
              ),
              CustomButton(
                  text: 'Login',
                  onPressed: () => Get.to(() => LoginScreen()),
                  sideColor: beigeColor,
                  onPrimary: Colors.white,
                  primary: beigeColor),
              CustomButton(
                  text: 'Signup',
                  onPressed: () => Get.to(() => SignupScreen()),
                  sideColor: bcielColor,
                  primary: Colors.white,
                  onPrimary: bcielColor),
            ],
          ),
        ),
      ),
    );
  }
}
