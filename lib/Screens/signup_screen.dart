import 'package:HackathonApp/Screens/login_screen.dart';
import 'package:HackathonApp/Wigdets/custom_button.dart';
import 'package:HackathonApp/Wigdets/custom_text.dart';
import 'package:HackathonApp/Wigdets/custom_textfield.dart';
import 'package:HackathonApp/conStants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? selectedOption;
  List<String> options = ['Manager', 'User'];
  signup() async {
    if (passcontroller.text.toString().trim() ==
        conpasscontroller.text.toString().trim()) {
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailcontroller.text.toString().trim(),
                password: passcontroller.text.toString().trim());

        print(credential.user!.uid);
        print(credential.user!.email);

        DocumentReference signupdetail = FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid);

        signupdetail.set({
          "uid": credential.user!.uid,
          "firstname": firstnamecontroller.text.toString().trim(),
          "lastname": lastnamecontroller.text.toString().trim(),
          "email": credential.user!.email,
          "profilepic": null,
          "role": selectedOption,
          "address": null,
          "bloodgroup": null,
          "contact": null,
        });
        showErrorMessage("Account Created");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showErrorMessage(String message) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("The password provided is too weak")));
          }
        } else if (e.code == 'email-already-in-use') {
          showErrorMessage("The account already exists for that email.");
        }
        
      } catch (e) {
        showErrorMessage("Try Again");
      }
    } else {
      showErrorMessage("Password is not Same");
    }
  }

  showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final crdential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
  }

  // addproducts() async {
  //   final credential = await FirebaseAuth.instance;
  //   CollectionReference addproduct =
  //       FirebaseFirestore.instance.collection("products");

  //   addproduct.doc("1111111111111111111111111111111").set({
  //     "productname": "Hoodie",
  //     "productprice": 100,
  //     "productreview": 3,
  //     "productdetail":
  //         "dshdahhhhhhhhhhcg jkgffffffffffffffffffffffffffffsgdfgCGSGS FFF/GS HKDD",
  //     "productpic": null
  //   });

  //   addproduct.doc("222222222222222222222222").set({
  //     "productname": "Jacket",
  //     "productprice": 50,
  //     "productreview": 4,
  //     "productdetail":
  //         "dshdahhhhhhhhhhcg jkgffffffffffffffffffffffffffffsgdfgCGSGS FFF/GS HKDD",
  //     "productpic": null
  //   });

  //   addproduct.doc("3333333333333333333333333333333333").set({
  //     "productname": "Sweater",
  //     "productprice": 150,
  //     "productreview": 5,
  //     "productdetail":
  //         "dshdahhhhhhhhhhcg jkgffffffffffffffffffffffffffffsgdfgCGSGS FFF/GS HKDD",
  //     "productpic": null
  //   });

  //   addproduct.doc("444444444444444444444444444444444").set({
  //     "productname": "SweatShirt",
  //     "productprice": 100,
  //     "productreview": 3,
  //     "productdetail":
  //         "dshdahhhhhhhhhhcg jkgffffffffffffffffffffffffffffsgdfgCGSGS FFF/GS HKDD",
  //     "productpic": null
  //   });

  //   addproduct.doc("55555555555555555555555555555555").set({
  //     "productname": "shalwar kameez",
  //     "productprice": 100,
  //     "productreview": 3,
  //     "productdetail":
  //         "dshdahhhhhhhhhhcg jkgffffffffffffffffffffffffffffsgdfgCGSGS FFF/GS HKDD",
  //     "productpic": null
  //   });

  //   addproduct.doc("6666666666666666666666666666666666").set({
  //     "productname": "shirt",
  //     "productprice": 100,
  //     "productreview": 3,
  //     "productdetail":
  //         "dshdahhhhhhhhhhcg jkgffffffffffffffffffffffffffffsgdfgCGSGS FFF/GS HKDD",
  //     "productpic": null
  //   });

  //   addproduct.doc("77777777777777777777777777777777").set({
  //     "productname": "Tshirt",
  //     "productprice": 100,
  //     "productreview": 3,
  //     "productdetail":
  //         "dshdahhhhhhhhhhcg jkgffffffffffffffffffffffffffffsgdfgCGSGS FFF/GS HKDD",
  //     "productpic": null
  //   });

  //   addproduct.doc("8888888888888888888888888888").set({
  //     "productname": "lehnga",
  //     "productprice": 100,
  //     "productreview": 3,
  //     "productdetail":
  //         "dshdahhhhhhhhhhcg jkgffffffffffffffffffffffffffffsgdfgCGSGS FFF/GS HKDD",
  //     "productpic": null
  //   });

  //   addproduct.doc("99999999999999999999999999999999").set({
  //     "productname": "sleeves",
  //     "productprice": 100,
  //     "productreview": 3,
  //     "productdetail":
  //         "dshdahhhhhhhhhhcg jkgffffffffffffffffffffffffffffsgdfgCGSGS FFF/GS HKDD",
  //     "productpic": null
  //   });
  //   print("product adddes");
  // }

  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController conpasscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(children: [
          Container(
              padding: EdgeInsets.only(top: 50, bottom: 30),
              child: CustomText(
                  text: "Sign Up",
                  textColor: AppColors.darkthemecolor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700)),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 5),
            child: CustomTextField(
                controller: firstnamecontroller,
                obscuretext: false,
                label: "First Name",
                hinttext: " Enter Your First Name"),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: CustomTextField(
                controller: lastnamecontroller,
                obscuretext: false,
                label: "Last Name",
                hinttext: " Enter Your Last Name"),
          ),
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
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: CustomTextField(
                controller: conpasscontroller,
                obscuretext: true,
                label: "Confirm Password",
                hinttext: "Confirm Password"),
          ),
          Container(
            margin: EdgeInsets.only(top:6),
            height: 50,
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.darkthemecolor, // Your themed color
                width: 1.0, // Border width
              ),
            ),
            child: DropdownButton<String>(
              hint: Container(
                  padding: EdgeInsets.only(left: 12),
                  child: Text("Select Role",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),)),
              value: selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue;
                });
              },
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    padding: EdgeInsets.only(left:12),
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black, // Text color
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
              underline: Container(), // Remove default underline
            ),
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
            buttontext: "SignUp",
            onpressed: () {
              signup();
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                    text: "Already have account?  ",
                    textColor: AppColors.blacktextcolor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: CustomText(
                        text: "Signin",
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
