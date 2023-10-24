import 'package:HackathonApp/Screens/HomeScreen.dart';
import 'package:HackathonApp/Screens/HomeScreen.dart';
import 'package:HackathonApp/Screens/forget_password.dart';
import 'package:HackathonApp/Screens/signup_screen.dart';
import 'package:HackathonApp/Wigdets/bottombar.dart';
import 'package:HackathonApp/Wigdets/custom_button.dart';
import 'package:HackathonApp/Wigdets/custom_text.dart';
import 'package:HackathonApp/Wigdets/custom_textfield.dart';
import 'package:HackathonApp/conStants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.toString().trim(),
          password: passcontroller.text.toString().trim());

      


          Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

         


    

      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showErrorMessage("'No user found for that email.");
      }
    }
  }

  showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
  }

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(children: [
          Container(
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              child: CustomText(
                  text: "Sign In",
                  textColor: AppColors.darkthemecolor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700)),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: CustomTextField(
                controller: emailcontroller,
                obscuretext: false,
                label: "Email",
                hinttext: " Enter Your Email"),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: CustomTextField(
                controller: passcontroller,
                obscuretext: true,
                label: "Password",
                hinttext: " Enter Your Password"),
          ),
          Container(
            padding: EdgeInsets.only(top: 40, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: const CustomText(
                        text: "SignIn with",
                        textColor: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
                IconButton(
                    onPressed: () {
                      signInWithGoogle();
                    },
                    icon: const FaIcon(FontAwesomeIcons.google))
              ],
            ),
          ),
          CustomButton(
            buttontext: "SignIn",
            onpressed: () {
              login();
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgetPass()),
                );
              },
              child: CustomText(
                  text: "Forget Password?        ",
                  textColor: AppColors.darkthemecolor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
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
