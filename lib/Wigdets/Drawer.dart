import 'dart:io';


import 'package:HackathonApp/Screens/DonarsList.dart';
import 'package:HackathonApp/Screens/ManagersList.dart';
import 'package:HackathonApp/Screens/ThemeChange.dart';
import 'package:HackathonApp/Screens/login_screen.dart';
import 'package:HackathonApp/Wigdets/MyProfile.dart';
import 'package:HackathonApp/conStants/colors.dart';
import 'package:HackathonApp/instance/firebase_instance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyDarwer extends StatefulWidget {
  const MyDarwer({super.key});

  @override
  State<MyDarwer> createState() => _MyDarwerState();
}

class _MyDarwerState extends State<MyDarwer> {
  File? profilepic;
  String? fileName;

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        File convertedimage = File(pickedFile.path);
        fileName = pickedFile.name;
        profilepic = convertedimage;
      });
      await uploadImageToFirebase(profilepic!);
    }
  }

  getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        File convertedimage = File(pickedFile.path);
        fileName = pickedFile.name;
        profilepic = convertedimage;
      });
      await uploadImageToFirebase(profilepic!);
    }
  }

  uploadImageToFirebase(File? profilepic) async {
    try {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(credential.currentUser!.uid)
          .child("profileimage")
          .putFile(profilepic!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      firestore
          .doc(credential.currentUser!.uid)
          .update({"profilepic": downloadUrl});
    } catch (e) {
      print(e);
    }
  }

  Signout() async {
    await credential.signOut();
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          backgroundColor: AppColors.whitetextcolor,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(credential.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            AppColors.darkthemecolor,
                            AppColors.lightthemecolor
                          ])),
                          width: 310,
                          height: 200,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 30),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(userData[
                                                "profilepic"] ??
                                            "https://images.pexels.com/photos/1545743/pexels-photo-1545743.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                                        radius: 50,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 155,
                                    top: 90,
                                    child: IconButton(
                                        onPressed: () {
                                          getFromGallery();
                                          uploadImageToFirebase(profilepic);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        )),
                                  )
                                ],
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child:
                                      Text(userData["firstname"] ?? "no name")),
                              Text(credential.currentUser!.email ?? "no email")
                            ],
                          )),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyProfile()),
                          );
                        },
                        title: Text(
                          "My Profile",
                          style: TextStyle(color: AppColors.blacktextcolor),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          color: AppColors.lightthemecolor,
                          height: 1,
                          width: 230),
                      ListTile(
                        onTap: () {
                          setState(() {
                             ThemeChange.toggleTheme();
                          });
                        },
                        title: Text(
                          "Change Theme",
                          style: TextStyle(color: AppColors.blacktextcolor),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          color: AppColors.lightthemecolor,
                          height: 1,
                          width: 230),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  CustomDonarsList()),
                          );
                        },
                        title: Text("Donar's List",
                            style: TextStyle(color: AppColors.blacktextcolor)),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          color: AppColors.lightthemecolor,
                          height: 1,
                          width: 230),
                      ListTile(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  ManagersList()),
                          );
                        },
                        title: Text("Manager's List",
                            style: TextStyle(color: AppColors.blacktextcolor)),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          color: AppColors.lightthemecolor,
                          height: 1,
                          width: 230),
                      ListTile(
                        onTap: () {
                          Signout();
                        },
                        title: Text("Sign Out",
                            style: TextStyle(color: AppColors.blacktextcolor)),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          color: AppColors.lightthemecolor,
                          height: 1,
                          width: 230),
                      ListTile(

                        onTap: (){
                          setState(() {
                             deletedonar() {
    firestore.doc(credential.currentUser!.uid).delete();
  }
                          });
                        },
                        title: Text("Delete Account",
                            style: TextStyle(color: AppColors.blacktextcolor)),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          color: AppColors.lightthemecolor,
                          height: 1,
                          width: 230),
                    ],
                  );
                }
                return CircularProgressIndicator();
              })),
    );
  }
}
