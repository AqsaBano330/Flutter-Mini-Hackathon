import 'package:HackathonApp/Screens/signup_screen.dart';
import 'package:HackathonApp/Wigdets/custom_button.dart';
import 'package:HackathonApp/Wigdets/custom_text.dart';
import 'package:HackathonApp/Wigdets/custom_textfield.dart';
import 'package:HackathonApp/conStants/colors.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  resetpass() async {
    final credential = await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailcontroller.text.toString().trim())
        .then((value) {
      showErrorMessage("We have sent you link");
    }).onError((error, stackTrace) {
      showErrorMessage(error.toString());
    });
  }

  showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(children: [
          Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: CustomText(
                  text: "Reset Password",
                  textColor: AppColors.darkthemecolor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700)),
          Container(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 30, left: 20, right: 20),
              child: CustomText(
                  text: "Please Enter Your Email Address so we can you Link",
                  textColor: AppColors.blacktextcolor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400)),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: CustomTextField(
                controller: emailcontroller,
                obscuretext: false,
                label: "Email",
                hinttext: " Enter Your Email"),
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            child: CustomButton(
              buttontext: "Send Link",
              onpressed: () {
                resetpass();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                    text: "Didnt have an account?  ",
                    textColor: AppColors.blacktextcolor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()),
                      );
                    },
                    child: CustomText(
                        text: "SignUp",
                        textColor: AppColors.darkthemecolor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ]),
      )),
    ));
  }
}
