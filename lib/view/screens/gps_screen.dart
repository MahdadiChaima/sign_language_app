import 'package:flutter/material.dart';

import '../widgets/color.dart';
import '../widgets/my_custom_text.dart';
class GpsScreen extends StatelessWidget {
  const GpsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: broiColor,
        title: MyCustomTextWidget(text: 'Gps', index: 3),
      ),
      body: Center(child: MyCustomTextWidget(text: 'You do not have the authority to do that.', index: 3),),
    );
  }
}
