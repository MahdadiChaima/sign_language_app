import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:sign_app/view/screens/home_screen.dart';
import '../../view/screens/started_screen.dart';
import '../../view/widgets/custom_snackbar.dart';
import '../../view/widgets/my_custom_text.dart';
import '../cache_helper.dart';
class LoginController extends GetxController {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RxBool showContainer1 = false.obs;
  final RxBool showContainer2 = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final RxBool rememberMe = false.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  late bool obscurePassword = true;
  var isGridVisible = false.obs; // Use RxBool to make it observable
  List<String> selectedLetters = [];
  final List<String> alphabetLetters = [
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
    'k', 'l', 'm', 'n', 'o',
    'p', 'q', 'r', 's', 't',
    'u', 'v', 'w', 'x', 'y', 'z', ' ', '@', '.', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
  ];
  FlutterTts flutterTts = FlutterTts();
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update(); // Update the state of the widget
  }
  Future<void> login() async {
    final email = mailController.text;
    final password = passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        // Sign in the user
        final UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
        // Check if the email is verified
          // Save login info
          await CacheHelper.saveData(key: 'token', value: userCredential.user!.uid);
          print('userCredential.user!.uiduserCredential.user!.uiduserCredential.user!.uid${userCredential.user!.uid}');
          // Update the HomeController instance to load the user name
          //final HomeController homeController = Get.put(HomeController());
          //await homeController.loadUserName();
          //homeController.startTimer();
          // Clear the input fields and show a success message
          mailController.clear();
          passwordController.clear();
          CustomSnackbar('Success', 'Login successful', isSuccess: true);
          Get.to(() => HomeScreen());

      } catch (e) {
        CustomSnackbar('Error', e.toString());
      }
    } else {
      Get.snackbar('Error', 'Please enter email and password!');
    }
  }
  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const StartedScreen());
    CacheHelper.removeData(key: 'token');
  }
  void resetPassword() async {
    String email = mailController.text.trim();
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        CustomSnackbar('Reset Password', 'Reset link has been sent to $email', isSuccess: true);
      } catch (e) {
        CustomSnackbar('Error', e.toString());
      }
    } else {
      Get.snackbar('Error', 'Please enter your email!');
    }
  }
  void toggleContainer1() {
    // Toggle the visibility of Container 1
    showContainer1.toggle();
    // Ensure Container 2 is hidden when Container 1 is shown
    if (showContainer1.isTrue) {
      showContainer2.value = false;
    }
  }
  void toggleContainer2() {
    // Toggle the visibility of Container 2
    showContainer2.toggle();
    // Ensure Container 1 is hidden when Container 2 is shown
    if (showContainer2.isTrue) {
      showContainer1.value = false;
    }
  }
  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: MyCustomTextWidget(index:4 ,text:'Logout',),
          content: MyCustomTextWidget(index:6 ,text:'Are you sure you want to logout ?',),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child:MyCustomTextWidget(index:4 ,text:'Cancel',),

            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.lazyPut(() => LoginController()); // Initialize the controller
                Get.find<LoginController>().logout();
              },
              child:MyCustomTextWidget(index:4 ,text:'Logout',),
            ),
          ],
        );
      },
    );
  }
  void toggleGridVisibility() {
    isGridVisible.value = !isGridVisible.value;
  }
  void speakSelectedWord() async {
    String selectedWord = selectedLetters.join('');
    if (selectedWord.isNotEmpty) {
      await flutterTts.setLanguage('en-US'); // Set the desired language
      await flutterTts.setPitch(1.0); // Set pitch (1.0 is default)
      await flutterTts.speak(selectedWord);
    }
  }
  void deleteLastCharacter() {
    if (selectedLetters.isNotEmpty) {
        selectedLetters.removeLast();
    }
  }
}
