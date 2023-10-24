import 'package:HackathonApp/conStants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onpressed,
    required this.buttontext, 
  });

  final void Function()? onpressed;
  final String buttontext;
 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                colors: [AppColors.darkthemecolor, AppColors.lightthemecolor])),
        child: ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          child: Text(
            buttontext,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
