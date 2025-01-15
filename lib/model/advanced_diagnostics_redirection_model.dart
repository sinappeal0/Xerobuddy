import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xerobuddy_app/screens/profession_group/adr_patient_route.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/advanced_diagnostics.dart';

class ADR_Model extends StatefulWidget {
  const ADR_Model({super.key});

  @override
  State<ADR_Model> createState() => _ADR_ModelState();
}

class _ADR_ModelState extends State<ADR_Model> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(currentUser!.email).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          final userProfile = snapshot.data!.data() as Map<String, dynamic>;

          return userProfile['userProfession'] == "Patient" ? const ADR_Patient_Route() : const AdvancedDiagnostics();
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
