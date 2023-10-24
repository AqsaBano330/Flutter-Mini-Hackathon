import 'package:flutter/material.dart';

class CustomBackButtom extends StatefulWidget {
  const CustomBackButtom({super.key, required this.arrowColor});

  final String arrowColor;

  @override
  State<CustomBackButtom> createState() => _CustomBackButtomState();
}

class _CustomBackButtomState extends State<CustomBackButtom> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset("assets/images/black_arrow.png",
                height: 40, width: 20)
            );
  }
}
