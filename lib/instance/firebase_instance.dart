import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final credential = FirebaseAuth.instance;
CollectionReference firestore = FirebaseFirestore.instance.collection("users");
