import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presenter/controller/login_controller.dart';
import '../widgets/color.dart';
import '../widgets/my_custom_button.dart';
import '../widgets/my_custom_text.dart';
import '../widgets/my_custom_textfield.dart';
class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Image.asset('assets/images/logo.png', height: 40,width: 40,),
                const SizedBox(width: 10,),
                MyCustomTextWidget(index: 3,text: 'SignaLingua' ,)
              ],
            ),
            const SizedBox(height: 20),
            MyCustomTextWidget(text:'Welcome back !' ,index: 1 ),
            const SizedBox(height: 100),
            MyCustomTextWidget(text:'Login :' ,index: 1 ),
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
                prefixIcon: const Icon(Icons.lock, color: broiColor),
                controller: loginController.passwordController,
                type: TextInputType.visiblePassword,
                validatorFn: validatePassword,
                obscuretext: loginController.obscurePassword,
                suffix: loginController.obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined ,
                suffixFunction: () {
                  loginController.togglePasswordVisibility();
                },
              ),
            ),
            const SizedBox(height: 150),
            CustomButton(
              onPressed: ()async{
                await loginController.login();
              },
              text: 'Login',
              primary: beigeColor,
              onPrimary: Colors.white,
              sideColor: beigeColor,
            ),
          ],
        ),),
      ),
    );
  }
}
