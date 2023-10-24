import 'package:HackathonApp/conStants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManagersList extends StatefulWidget {
  const ManagersList({super.key});

  @override
  State<ManagersList> createState() => _ManagersListState();
}

class _ManagersListState extends State<ManagersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkthemecolor,
          title: Text("Manager's List"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('role', isEqualTo: "Manager")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return Column(
                children: [
                  ListView.builder(

                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot abc = snapshot.data!.docs[index];
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left:10),
                              child: ListTile(
                                
                                title: Text(abc["firstname"]) ,
                                subtitle: Text(abc["email"]),
                                
                                
                              ),
                            ),
                            Container(
                        color: AppColors.darkthemecolor,
                        height:1,
                        width:300
                      )
                          ],
                        );
                      }),
                      
                ],
              );
            }));
  }
}