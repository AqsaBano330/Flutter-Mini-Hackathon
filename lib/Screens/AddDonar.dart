import 'dart:math';
import 'package:intl/intl.dart';
import 'package:HackathonApp/Wigdets/custom_button.dart';
import 'package:HackathonApp/Wigdets/custom_text.dart';
import 'package:HackathonApp/Wigdets/custom_textfield.dart';
import 'package:HackathonApp/conStants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDonar extends StatefulWidget {
  const AddDonar({super.key});

  @override
  State<AddDonar> createState() => _AddDonarState();
}

class _AddDonarState extends State<AddDonar> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  TextEditingController bloodgroupcontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  int uniqueid = 0;

  randomuid(int uid) {}

  adddonar() async {
    int uid = Random().nextInt(199999) + 1;
    print('Random Integer: uid');
    DocumentReference firestore = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid.toString());

    firestore.set({
      "firstname": namecontroller.text.toString().trim(),
      "address": locationcontroller.text.toString().trim(),
      "contact": contactcontroller.text.toString().trim(),
      "bloodgroup": Bloodgroup,
      "date": datecontroller.text.toString().trim(),
      "role": "donar",
      "email": "someone@gmail.com",
      "uid": uid
    });
    showErrorMessage("Donar Added");

    namecontroller.clear();
    locationcontroller.clear();
    contactcontroller..clear();
    bloodgroupcontroller..clear();
    datecontroller..clear();
  }

  showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  String Bloodgroup = "";

  bool isApositive = false;
  bool isAnegative = false;
  bool isBnegative = false;
  bool isBpositive = false;
  bool isOnegative = false;
  bool isOpositive = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);
      setState(() {
        datecontroller.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whitetextcolor,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(children: [
          Container(
              color: AppColors.whitetextcolor,
              padding: const EdgeInsets.only(bottom: 50),
              child: CustomText(
                  text: "Add Donar",
                  textColor: AppColors.darkthemecolor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700)),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: CustomTextField(
                controller: namecontroller,
                obscuretext: false,
                label: "Name",
                hinttext: " Enter Donar's Name"),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: CustomTextField(
                controller: locationcontroller,
                obscuretext: false,
                label: "Enter Donar's Address",
                hinttext: " "),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: CustomTextField(
                controller: contactcontroller,
                obscuretext: false,
                label: "Contact Number",
                hinttext: "Contact Number "),
          ),
          Container(
            height: 60,
            width: 320,
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: TextField(
              cursorColor: AppColors.darkthemecolor,
              cursorHeight: 20,
              obscureText: false,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: AppColors.darkthemecolor, // Your themed color
                    width: 1.0, // Border width
                  ),
                ),
                icon: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Icon(Icons.calendar_today)),
                labelText: "Enter Date",
              ),
              readOnly: true,
              controller: datecontroller,
            ),
          ),
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
          Row(
            children: [
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
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: CustomButton(
              buttontext: "Add",
              onpressed: () {
                adddonar();
                showErrorMessage(String message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Donar is added Successfully")));
                }
              },
            ),
          ),
        ]),
      )),
    );
  }
}
