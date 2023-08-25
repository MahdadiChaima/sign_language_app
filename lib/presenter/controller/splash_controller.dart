import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view/screens/alphabet_screen.dart';
import '../../view/screens/home_screen.dart';
import '../../view/screens/onbording_screen.dart';
import '../../view/widgets/constant.dart';
class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    // Wait for some time and then navigate to the home screen
    Future.delayed(const Duration(seconds: 3), () {
      Widget StartScreen;
      if(token==null){
        StartScreen=  OnboardingScreen() ;
        print('naaaaaaaaaaaaaaaaaaaaaaaa token $token');
      }
      else{
        StartScreen= HomeScreen();
      }
      Get.off(() =>  StartScreen);
    });
  }
}