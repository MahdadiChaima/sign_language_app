import 'package:flutter/material.dart';
import 'color.dart';
class MyCustomTextWidget extends StatelessWidget {
  // final SettingsController settingscontroller = Get.put(SettingsController());
  final int index;
  final String text;
  final Color? color;
  final TextAlign alignment;
  MyCustomTextWidget({
    required this.index,
    required this.text,
    this.color = broiColor,
    this.alignment = TextAlign.center,
  });
  double getResponsiveFontSize(BuildContext context, double referenceSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final referenceWidth = 375; // Reference width for font size calculations (you can adjust it based on your design)
    // Calculate the ratio of the screen's width to the reference width
    final widthRatio = screenWidth / referenceWidth;
    // Calculate the responsive font size
    final fontSize = referenceSize * widthRatio;

    return fontSize;
  }
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;
    switch (index) {
      case 1: // Head
        textStyle = TextStyle(
          fontFamily: 'GreatVibes',
          fontSize: getResponsiveFontSize(context, 24),
          fontWeight: FontWeight.w700,
          color:
          // settingscontroller.isDarkMode.value
          //     ? Colors.white// Use dark mode color:
          broiColor, // Use light mode color
          letterSpacing: 2,
        );
        break;
      case 2://Subtitle
        textStyle = TextStyle(
          fontFamily: 'GreatVibes',
          fontSize:getResponsiveFontSize(context, 20),
          fontWeight: FontWeight.w400,
          color:
          // settingscontroller.isDarkMode.value
          //     ? Colors.white// Use dark mode color
          broiColor, // Use light mode color
        );
        break;
      case 3: // Head
        textStyle = TextStyle(
          fontFamily: 'GreatVibes',
          fontSize: getResponsiveFontSize(context, 24),
          fontWeight: FontWeight.w700,
          color:
          beigeColor, // Use light mode color
          letterSpacing: 2,
        );
        break;
      default:
        textStyle = TextStyle(
          fontFamily: 'GreatVibes',
          fontSize: getResponsiveFontSize(context, 12),
          fontWeight: FontWeight.w400,
        );
    }
    return  Text(
      text,
      style: textStyle,
    );
  }
}