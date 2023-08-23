import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../../view/widgets/my_custom_text.dart';
import 'login_controller.dart';

class HomeController extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  final selectedLetters = <String>[].obs;
  final isAlphabetMode = true.obs; // Use the .obs property for RxBool
  final FlutterTts flutterTts = FlutterTts();

  void toggle() {
    isAlphabetMode.value =
        !isAlphabetMode.value; // Use .value property to update the RxBool
    selectedLetters.clear();
    update();
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: MyCustomTextWidget(
            index: 4,
            text: 'Logout',
          ),
          content: MyCustomTextWidget(
            index: 6,
            text: 'Are you sure you want to logout ?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: MyCustomTextWidget(
                index: 44,
                text: 'Cancel',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.lazyPut(
                    () => LoginController()); // Initialize the controller
                Get.find<LoginController>().logout();
              },
              child: MyCustomTextWidget(
                index: 4,
                text: 'Logout',
              ),
            ),
          ],
        );
      },
    );
  }
}
