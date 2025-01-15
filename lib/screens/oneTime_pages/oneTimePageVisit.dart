import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xerobuddy_app/screens/dashboard.dart';
import 'package:xerobuddy_app/screens/oneTime_pages/introPage.dart';

class OneTimePageVisit extends StatefulWidget {
  const OneTimePageVisit({super.key});

  @override
  State<OneTimePageVisit> createState() => _OneTimePageVisitState();
}

class _OneTimePageVisitState extends State<OneTimePageVisit> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(currentUser!.email).snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          final userProfile = snapshot.data!.data() as Map<String, dynamic>;

          print("Sign in reached here");

          return userProfile['first_visit'] == true ? IntroPage() : DashboardScreen();
        } else if (snapshot.hasError) {
          print("Error Occurred snapshot has error");
          return Center(
            child: Text("Error occurred : ${snapshot.error}"),
          );
        } else {
          print("Error Occurred");
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
