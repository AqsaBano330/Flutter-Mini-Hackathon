import 'dart:math';

import 'package:HackathonApp/Screens/AddDonar.dart';
import 'package:HackathonApp/Screens/DonarProfile.dart';
import 'package:HackathonApp/Screens/DonationForm.dart';
import 'package:HackathonApp/Wigdets/Drawer.dart';
import 'package:HackathonApp/Wigdets/custom_text.dart';
import 'package:HackathonApp/conStants/colors.dart';
import 'package:HackathonApp/instance/firebase_instance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
 String Currentrole = "";


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  
  deleteDonar(uid) {
    FirebaseFirestore.instance.collection("users").doc(uid.toString()).update({"role":"User"});
  }

  @override



   Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          
          backgroundColor: AppColors.lightthemecolor,
        title: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(credential.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return CustomText(
                    text: "Hi   ${userData["firstname"]},",
                    textColor: AppColors.whitetextcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400);
              }
              return CircularProgressIndicator();
            }),
        ),
        
        body: Container(
          color: AppColors.whitetextcolor,
          child: Column(
            
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(credential.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
              
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
              
                  if (snapshot.hasData) {
                    final userData = snapshot.data!.data() as Map<String, dynamic>;
                    Currentrole = userData["role"];
                    print(Currentrole);
                    return Column(
        
                      children: [
        
                        
                        
                        Container(
                          
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.lightthemecolor,
                            borderRadius: BorderRadius.circular(2),
                            // gradient: LinearGradient(
                            //   colors: [
                            //     AppColors.darkthemecolor,
                            //     AppColors.lightthemecolor
                            //   ],
                            // ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Visibility(
                                visible: Currentrole=="Manager",
                                
                                child: CustomText(text: "Manager's Panel", textColor: AppColors.whitetextcolor, fontSize: 20, fontWeight: FontWeight.w400))
              ,
                              Container(
                                padding: EdgeInsets.only(),
                                child: Row(
                                  children: [],
                                ),
                              ),
                              Container(
                                height: 10,
                              ),
                              Visibility(
                                visible: userData["role"] == "Manager",
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 2),
                                  height: 50,
                                  width: 300,
                                  child: ElevatedButton(
                                    style: ButtonStyle(),
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(Icons.search),
                                        CustomText(
                                          text: "Search By BloodGroup",
                                          textColor: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: userData["role"] == "donar" ||
                                    userData["role"] == "User",
                                child: Container(
                                  padding: EdgeInsets.only(top: 2),
                                  height: 50,
                                  width: 300,
                                  child: ElevatedButton(
                                    style: ButtonStyle(),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DonationForm()),
                                      );
                                    },
                                    child: CustomText(
                                      text: "Want to Donate ?",
                                      textColor: AppColors.darkthemecolor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        CustomText(fontSize: 20, text: userData["role"]=="donar"? "Other Donars:" :
                         'Donars:', textColor: AppColors.darkthemecolor, fontWeight: FontWeight.w700,),
                      ],
                    );
                  }
              
                  return CircularProgressIndicator(color: AppColors.darkthemecolor);
                },
              ),
              

              StreamBuilder(
                
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('role', isEqualTo: "donar")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
        
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
        
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView( // Wrap with ListView
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot abc = snapshot.data!.docs[index];
                              if (credential.currentUser!.email.toString() !=
                                  abc["email"]) {
                                return Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 2, top: 2, right: 2, left: 2),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 20, right: 20, top: 10, bottom: 10),
                                            height: 120,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.darkthemecolor,
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Center(
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DonarProfile(
                                                                  donarname: abc["firstname"],
                                                                  location: abc["address"],
                                                                  bloodgroup: abc["bloodgroup"],
                                                                  donaruid: abc["uid"].toString(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.only(
                                                                left: 10, top: 4),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text("Name:   ${abc["firstname"]}"),
                                                                Text("Location:   ${abc["address"]}"),
                                                                Text("Contact:    ${abc["contact"]}"),
                                                                Text("Last Date : 10/22/23"),
                                                                // Add other user details here
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            Visibility(
                                                              visible: Currentrole == "Manager",
                                                              child: Container(
                                                                padding: EdgeInsets.only(left: 60),
                                                                child: IconButton(
                                                                  onPressed: () {
                                                                    deleteDonar(abc["uid"]);
                                                                  },
                                                                  icon: Icon(Icons.delete),
                                                                ),
                                                              ),
                                                            
                                                            ),
                                                            Spacer(),
                                                            GestureDetector(
                                                              onTap: (){
                                                                Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DonarProfile(
                                                                  donarname: abc["firstname"],
                                                                  location: abc["address"],
                                                                  bloodgroup: abc["bloodgroup"],
                                                                  donaruid: abc["uid"].toString(),
                                                                ),
                                                              ),
                                                            );
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets.only(left:10,bottom:10),
                                                                child: CustomText(text: "        View Profile>>", textColor: AppColors.darkthemecolor, fontSize: 13, fontWeight: FontWeight.w400)),
                                                            )
                                                          ],
        
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 20,
                                          top: 10,
                                          child: Container(
                                            padding: EdgeInsets.only(left: 9, top: 4),
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: AppColors.darkthemecolor,
                                              border: Border.all(
                                                color: AppColors.whitetextcolor,
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            child: Text(
                                              abc["bloodgroup"],
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          Visibility(
                            visible: Currentrole == "Manager",
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5, left: 250,),
                              padding: EdgeInsets.only(bottom: 5, right: 10,top:40),
                              child: FloatingActionButton(
                                backgroundColor: AppColors.darkthemecolor,
                                child: Text(
                                  "+",
                                  style: TextStyle(fontSize: 25),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const AddDonar()),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
        
                  return CircularProgressIndicator(color: AppColors.darkthemecolor);
                },
              ),
        
            ],
          ),
        ),
        drawer: MyDarwer(),
      ),
    );
  }
  
        
     
  }

