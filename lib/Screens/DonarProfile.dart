import 'package:HackathonApp/Screens/HomeScreen.dart';
import 'package:HackathonApp/Wigdets/custom_button.dart';
import 'package:HackathonApp/Wigdets/custom_text.dart';
import 'package:HackathonApp/conStants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonarProfile extends StatefulWidget {
  const DonarProfile(
      {super.key,
      required this.donarname,
      required this.location,
      required this.bloodgroup,
      required this.donaruid});
  final String donarname;
  final String location;
  final String bloodgroup;
  final String donaruid;

  @override
  State<DonarProfile> createState() => _DonarProfileState();
}

TextEditingController taskeditcontroller = TextEditingController();

class _DonarProfileState extends State<DonarProfile> {
  final credential = FirebaseAuth.instance;

  editprofilefieldtofirebase(String fieldname, String editedtask) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.donaruid)
        .update({fieldname: editedtask});
  }

  editprofilefieldtoui(fieldname, String Updatewhat) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(Updatewhat),
            content: TextField(
              controller: taskeditcontroller,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    editprofilefieldtofirebase(
                        fieldname, taskeditcontroller.text.toString().trim());
                    Navigator.pop(context);
                    taskeditcontroller.clear();
                  },
                  child: Text("Save"))
            ],
          );
        });
  }

  showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whitetextcolor,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(widget.donaruid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center();
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;

                return Center(
                    child: SingleChildScrollView(
                  child: Column(
                  
                    children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 30),
                      child: CustomText(
                          text: "Donar's Profile",
                          textColor: AppColors.darkthemecolor,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: ListTile(
                          title: Text("Name:  ${userData["firstname"]}"),
                          trailing: Visibility(
                            visible: Currentrole =="Manager",
                            child: IconButton(
                                onPressed: () {
                                  editprofilefieldtoui(
                                      "firstname", "Update Name");
                                },
                                icon: Icon(Icons.edit)),
                          ),
                        )),
                    Container(
                      height: 1,
                      width: 300,
                      color: AppColors.darkthemecolor,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: ListTile(
                            title: Text("Location:  ${userData["address"]}"),
                            trailing: Visibility(
                              visible: Currentrole =="Manager",
                              child: IconButton(
                                  onPressed: () {
                                    editprofilefieldtoui(
                                        "address", "Update Address");
                                  },
                                  icon: Icon(Icons.edit)),
                            ))),
                    Container(
                      height: 1,
                      width: 300,
                      color: AppColors.darkthemecolor,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: ListTile(
                            title: Text("Contact:  ${userData["contact"]}"),
                            trailing: Visibility(
                              visible: Currentrole =="Manager",
                              child: IconButton(
                                  onPressed: () {
                                    editprofilefieldtoui(
                                        "contact", "Update Contact");
                                  },
                                  icon: Icon(Icons.edit)),
                            ))),
                    Container(
                      height: 1,
                      width: 300,
                      color: AppColors.darkthemecolor,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: ListTile(
                            title: Text("Date:  ${userData["date"]}"),
                            trailing: Visibility(
                            visible: Currentrole =="Manager",
                              child: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.calendar_month)),
                            ))),
                    Container(
                      height: 1,
                      width: 300,
                      color: AppColors.darkthemecolor,
                    ),
                    Visibility(
                      visible: Currentrole== "Manager",
                      child: Container(
                        padding: EdgeInsets.only(top: 40),
                        child: CustomButton(
                          buttontext: "Save",
                          onpressed: () {
                            showErrorMessage("Donar profile has been saved");
                          },
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 40),
                        child: CustomButton(
                          buttontext: "Contact",
                          onpressed: () {
                            
                          },
                        ),
                      ),

                  ]),
                ));
              }
              return CircularProgressIndicator();
            }));
  }
}
