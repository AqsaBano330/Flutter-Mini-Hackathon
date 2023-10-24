import 'package:HackathonApp/Wigdets/custom_button.dart';
import 'package:HackathonApp/Wigdets/custom_text.dart';
import 'package:HackathonApp/Wigdets/custom_textfield.dart';
import 'package:HackathonApp/conStants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonationForm extends StatefulWidget {
  const DonationForm({super.key});

  @override
  State<DonationForm> createState() => _DonationFormState();
}



String Bloodgroup = "";

class _DonationFormState extends State<DonationForm> {
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController bloodgroupcontroller = TextEditingController();
  TextEditingController contactnumbercontroller = TextEditingController();

  donardetail() async {
    final credential = await FirebaseAuth.instance;
    DocumentReference donaradd = FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid);

    donaradd.update({
      "address": addresscontroller.text.toString().trim(),
      "bloodgroup": Bloodgroup,
      "contact": contactnumbercontroller.text.toString().trim(),
      "date": DateTime.now().toString(),
      "email": credential.currentUser!.email,
      "profilepic": null,
      "role": "donar"
    });
  }

  showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  bool isApositive = false;
  bool isAnegative = false;
  bool isBnegative = false;
  bool isBpositive = false;
  bool isOnegative = false;
  bool isOpositive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              
                padding: EdgeInsets.only(top: 50, bottom: 30),
                child: CustomText(
                    text: "Donation Form",
                    textColor: AppColors.darkthemecolor,
                    fontSize: 30,
                    fontWeight: FontWeight.w700)),
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 5),
              child: CustomTextField(
                  controller: addresscontroller,
                  obscuretext: false,
                  label: "Location",
                  hinttext: " Enter Your Location"),
            ),
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: CustomTextField(
                  controller: contactnumbercontroller,
                  obscuretext: false,
                  label: "Contact",
                  hinttext: " Enter Your Contact Number"),
            ),
            Container(
                padding: EdgeInsets.only(top: 30, right: 150,bottom:20),
                child: CustomText(
                    text: "Select Your Blood Group",
                    textColor: AppColors.darkthemecolor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isApositive == true) {
                        isApositive = false;
                        Bloodgroup = "";
                        print(isApositive);
                      } else {
                        isApositive = true;
                        isAnegative = false;
                        isBnegative = false;
                        isBpositive = false;
                        isOnegative = false;
                        isOpositive = false;
                        Bloodgroup = "A+";
                      }
                    });
                    print(Bloodgroup);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 9, top: 4),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    height: 30,
                    width: 40,
                    decoration: BoxDecoration(
                      color: isApositive == false
                          ? Colors.white
                          : AppColors.darkthemecolor,
                      border: Border.all(
                        color: AppColors.darkthemecolor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "A+",
                      style: TextStyle(
                          color: isApositive == true
                              ? Colors.white
                              : AppColors.darkthemecolor),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isAnegative == true) {
                        isAnegative = false;
                        Bloodgroup = "";
                        print(isAnegative);
                      } else {
                        isApositive = false;
                        isBnegative = false;
                        isBpositive = false;
                        isOnegative = false;
                        isOpositive = false;
                        isAnegative = true;
                        Bloodgroup = "A-";
                      }
                    });
                    print(Bloodgroup);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 9, top: 4),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    height: 30,
                    width: 40,
                    decoration: BoxDecoration(
                      color: isAnegative == false
                          ? Colors.white
                          : AppColors.darkthemecolor,
                      border: Border.all(
                        color: AppColors.darkthemecolor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "A-",
                      style: TextStyle(
                          color: isAnegative == true
                              ? Colors.white
                              : AppColors.darkthemecolor),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isBpositive == true) {
                        isBpositive = false;
                        Bloodgroup = "";
                        print(isBpositive);
                      } else {
                        isBpositive = true;
      
                        isAnegative = false;
                        isBnegative = false;
                        isApositive = false;
                        isOnegative = false;
                        isOpositive = false;
                        Bloodgroup = "B+";
                      }
                    });
                    print(Bloodgroup);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 9, top: 4),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    height: 30,
                    width: 40,
                    decoration: BoxDecoration(
                      color: isBpositive == false
                          ? Colors.white
                          : AppColors.darkthemecolor,
                      border: Border.all(
                        color: AppColors.darkthemecolor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "B+",
                      style: TextStyle(
                          color: isBpositive == true
                              ? Colors.white
                              : AppColors.darkthemecolor),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isBnegative == true) {
                        isBnegative = false;
                        Bloodgroup = "";
                        print(isBnegative);
                      } else {
                        isBnegative = true;
      
                        isAnegative = false;
                        isBpositive = false;
                        isApositive = false;
                        isOnegative = false;
                        isOpositive = false;
                        Bloodgroup = "B-";
                      }
                    });
                    print(Bloodgroup);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 9, top: 4),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    height: 30,
                    width: 40,
                    decoration: BoxDecoration(
                      color: isBnegative == false
                          ? Colors.white
                          : AppColors.darkthemecolor,
                      border: Border.all(
                        color: AppColors.darkthemecolor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "B-",
                      style: TextStyle(
                          color: isBnegative == true
                              ? Colors.white
                              : AppColors.darkthemecolor),
                    ),
                  ),
                ),
                
              ],
            ),
            Row(children: [
              
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isOpositive == true) {
                        isOpositive = false;
                        Bloodgroup = "";
                        print(isOpositive);
                      } else {
                        isOpositive = true;
      
                        isAnegative = false;
                        isBnegative = false;
                        isApositive = false;
                        isOnegative = false;
                        isBpositive = false;
                        Bloodgroup = "O+";
                      }
                    });
                    print(Bloodgroup);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 9, top: 4),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    height: 30,
                    width: 40,
                    decoration: BoxDecoration(
                      color: isOpositive == false
                          ? Colors.white
                          : AppColors.darkthemecolor,
                      border: Border.all(
                        color: AppColors.darkthemecolor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "O+",
                      style: TextStyle(
                          color: isOpositive == true
                              ? Colors.white
                              : AppColors.darkthemecolor),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isOnegative == true) {
                        isOnegative = false;
                        Bloodgroup = "";
                        print(isOnegative);
                      } else {
                        isOnegative = true;
                        isBpositive = false;
      
                        isAnegative = false;
                        isBnegative = false;
                        isApositive = false;
                       
                        isOpositive = false;
                        Bloodgroup = "O-";
                      }
                    });
                    print(Bloodgroup);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 9, top: 4),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    height: 30,
                    width: 40,
                    decoration: BoxDecoration(
                      color: isOnegative == false
                          ? Colors.white
                          : AppColors.darkthemecolor,
                      border: Border.all(
                        color: AppColors.darkthemecolor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "O-",
                      style: TextStyle(
                          color: isOnegative == true
                              ? Colors.white
                              : AppColors.darkthemecolor),
                    ),
                  ),
                ),
            ],)
            // Container(
            //     color: isApositive == true
            //         ? AppColors.darkthemecolor
            //         : Colors.white,
            //     child: Text("A+")),
            ,
            Container(
              padding: EdgeInsets.only(top: 50),
              child: CustomButton(
                buttontext: "I am Ready to Donate",
                onpressed: () {
                  donardetail();
                  showErrorMessage("Your Profile is added to Donar's list");
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
