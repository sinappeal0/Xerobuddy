import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/risk_screens/average_risk.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/risk_screens/high_risk.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/risk_screens/low_risk.dart';

import '../../../util/globals.dart';

class RiskScreens extends StatefulWidget {
  const RiskScreens({super.key});

  @override
  State<RiskScreens> createState() => _RiskScreensState();
}

class _RiskScreensState extends State<RiskScreens> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  getXerostomia() async {
    FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).snapshots().listen((docSnapshot) {
      Map<String, dynamic> data = docSnapshot.data()!;
      setState(() {
        xerostomia = data['xerostomia'];
        acbScore = data['acbScore'];
        usfr = data['usfr'];
        schirmer = data['schirmer'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getXerostomia();
    });  }

  @override
  Widget build(BuildContext context) {
    if(xerostomia <= 4.0 && acbScore == 0 && usfr >= 0.25 && schirmer >= 1.0) {
      return LowRisk();
    } else if(((xerostomia >= 4.0) || (xerostomia <= 6.0)) && ((acbScore == 1) || (acbScore == 2)) && ((usfr <= 0.25) || (usfr >= 0.1)) && ((schirmer >= 0.5) && (schirmer <= 1.0))) {
      return AverageRisk();
    } else {
      return HighRisk();
    }
  }
}
