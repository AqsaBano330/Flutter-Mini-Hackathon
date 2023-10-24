import 'package:flutter/widgets.dart';

class CustomText extends StatelessWidget {
   const CustomText({
    super.key,
    required this.text,
    required this.textColor,
    required this.fontSize,
    required this.fontWeight, 
    
  });

  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: "Manrope"
          ),
    );
  }
}
