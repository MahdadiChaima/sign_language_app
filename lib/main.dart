import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_app/presenter/cache_helper.dart';
import 'package:sign_app/view/screens/splash_screen.dart';
import 'package:sign_app/view/widgets/constant.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  token='';
  token=await CacheHelper.importData(key: 'token');
  runApp(   GetMaterialApp(
    title: 'ELearning',
    debugShowCheckedModeBanner: false,
    home:  SplashScreen(),

  ));
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sign Language App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: TfliteModel(),
//     );
//   }
// }
//
// class TfliteModel extends StatefulWidget {
//   const TfliteModel({Key? key}) : super(key: key);
//   @override
//   _TfliteModelState createState() => _TfliteModelState();
// }
//
// class _TfliteModelState extends State<TfliteModel> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Language App'),
//       ),
//       body: Column(
//         children: [],
//       ),
//     );
//   }
// }
