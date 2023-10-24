import 'package:HackathonApp/Screens/login_screen.dart';
import 'package:HackathonApp/Wigdets/custom_button.dart';
import 'package:HackathonApp/Wigdets/custom_text.dart';
import 'package:HackathonApp/conStants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageView extends StatelessWidget {
  CustomPageView({Key? key}) : super(key: key);

  final controller = PageController();

  final List<String> mainHeading = [
    "Save lives, donate blood.",
"Be a hero, donate blood.",
"Give the gift of life.",
  ];
  final List<String> subHeading = [
  "Donating blood not only helps those in need but also reduces the risk of certain health conditions for the donor, such as heart diseases and cancer.", 
"Regular blood donation can lead to improved cardiovascular health and a reduced risk of developing harmful iron overload in the body.",
"By donating blood, you not only make a positive impact on the lives of patients but also gain a sense of fulfillment and the knowledge that you're contributing to a healthier community."
  ];




  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/images/pageviewbg.jpg",
              fit: BoxFit.fill,
            )),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.repeated,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black,
                Colors.black,
                Colors.black87,
                Colors.black26,
                Colors.black26,
                Colors.transparent,
                Colors.transparent,
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(
                          top: 350.0, bottom: 0.0, right: 30, left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: CustomText(
                                  text: mainHeading[index],
                                  textColor: AppColors.whitetextcolor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400)),
                          const SizedBox(height: 16.0),
                          CustomText(
                              text: subHeading[index],
                              textColor: AppColors.whitetextcolor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400)
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 0, bottom: 40),
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                    spacing: 8.0,
                    radius: 2,
                    dotWidth: 8.0,
                    dotHeight: 6.0,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 1.5,
                    dotColor: Colors.white,
                    activeDotColor: AppColors.darkthemecolor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: CustomButton(
                    onpressed: () {
                    
                    

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );
                      
                    },
                    buttontext: "Get Started"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ]),
    );
  }
}
