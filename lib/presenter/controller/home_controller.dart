import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/widgets/my_custom_text.dart';
import 'login_controller.dart';
class HomeController extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: MyCustomTextWidget(index: 4, text: 'Logout',),
          content: MyCustomTextWidget(
            index: 6, text: 'Are you sure you want to logout ?',),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: MyCustomTextWidget(index: 44, text: 'Cancel',),

            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.lazyPut(() =>
                    LoginController()); // Initialize the controller
                Get.find<LoginController>().logout();
              },
              child: MyCustomTextWidget(index: 4, text: 'Logout',),
            ),
          ],
        );
      },
    );
  }
}