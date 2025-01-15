import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xerobuddy_app/model/bottomNavigationBar.dart';
import 'package:xerobuddy_app/model/patientBottomNavigationBar.dart';
import 'package:xerobuddy_app/screens/profession_group/patient_dashboard.dart';
import 'package:xerobuddy_app/screens/profession_group/professional_dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(currentUser!.email).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          final userProfile = snapshot.data!.data() as Map<String, dynamic>;

          // return userProfile['userProfession'] == "Patient" ? const PatientDashboard() : const ProfessionalDashboard();
          // return XBottomNavigationBar();
          return userProfile['userProfession'] == "Patient" ? PatientBottomNavigationBar() : XBottomNavigationBar();
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error occurred : ${snapshot.error}"),
          );
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
