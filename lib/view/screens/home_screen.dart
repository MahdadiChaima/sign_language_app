import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_app/view/screens/alphabet_screen.dart';
import 'package:sign_app/view/screens/camera_screen.dart';
import 'package:sign_app/view/screens/gps_screen.dart';
import '../../presenter/controller/home_controller.dart';
import '../widgets/color.dart';
import '../widgets/my_custom_button.dart';
import '../widgets/my_custom_text.dart';
class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

   HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: broiColor,
        title: MyCustomTextWidget(text: 'Sign Language App', index: 3),
        actions: [
          IconButton(
            onPressed: () {
              homeController.showLogoutConfirmationDialog(context);
            },
            icon: const Icon(
              Icons.login_outlined,
              color: pinkColor,
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                buttomHight: 80.0,
                onPressed: () async {
                  Get.to(() => CameraPage());
                },
                text: 'Camera',
                primary: beigeColor,
                onPrimary: Colors.white,
                sideColor: bordoColor,
              ),
              CustomButton(
                buttomHight: 80.0,
                onPressed: () async {
                  Get.to(() => AlphaScreen());
                },
                text: 'Keyboard',
                primary: beigeColor,
                onPrimary: Colors.white,
                sideColor: bordoColor,
              ),
              CustomButton(
                buttomHight: 80.0,
                onPressed: () async {
                  Get.to(() => GpsScreen());
                },
                text: 'Gps',
                primary: beigeColor,
                onPrimary: Colors.white,
                sideColor: bordoColor,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: broiColor,
        elevation: 0, // Remove the bottom bar shadow
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 60.0, // Width of the outer white circle
            height: 60.0, // Height of the outer white circle
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // Color of the outer white circle
            ),
          ),
          FloatingActionButton(
            backgroundColor: broiColor, // Background color of the inner circle
            onPressed: () {
              // Add functionality for the home button here
            },
            child: Icon(
              Icons.home,
              color: Colors.white, // Color of the home icon
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
