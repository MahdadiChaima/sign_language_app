import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_app/view/screens/started_screen.dart';

import '../../view/widgets/color.dart';
import '../../view/widgets/my_custom_text.dart';
class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Welcome to SignLinguo',
      description: 'Bridge the gap between text and visual language.',
      image: 'assets/images/onbording1.png',
    ),
    OnboardingItem(
      title: 'Sign Language',
      description: 'Tap an image to reveal the corresponding text and delve into the world of sign language expression.',
      image: 'assets/images/onbording2.png',
    ),
    OnboardingItem(
      title: 'Listen & Sign',
      description: 'Tap the play button to hear the text spoken aloud. Experience the depth of sign language communication with us.',
      image: 'assets/images/onbording3.png',
    ),
  ];
  final RxInt currentPageIndex = 0.obs;
  void onPageChanged(int index) {
    currentPageIndex.value = index;
  }
  void goToNextPage() {
    if (currentPageIndex.value < onboardingItems.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Get.to(StartedScreen());
    }
  }
  List<Widget> buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < onboardingItems.length; i++) {
      indicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == currentPageIndex.value ? pinkColor : broiColor,
          ),
        ),
      );
    }
    return indicators;
  }
}
class OnboardingItemWidget extends StatelessWidget {
  final OnboardingItem onboardingItem;
  const OnboardingItemWidget({required this.onboardingItem});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          onboardingItem.image,
          height: 300.0,
          width: double.infinity,
        ),
        SizedBox(height: 20.0),
        MyCustomTextWidget(text: onboardingItem.title ,index: 1),
        SizedBox(height: 10.0),
        Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            onboardingItem.description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0,color: broiColor),
          ),),
      ],
    );
  }
}
class OnboardingItem {
  final String title;
  final String description;
  final String image;
  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}