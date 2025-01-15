import 'package:flutter/material.dart';
import 'package:xerobuddy_app/screens/patient_side/patientAverageRisk.dart';
import 'package:xerobuddy_app/screens/patient_side/patientHighRisk.dart';
import 'package:xerobuddy_app/screens/patient_side/patientLowRisk.dart';

import '../../util/globals.dart';

class ADR_Patient_Route extends StatefulWidget {
  const ADR_Patient_Route({super.key});

  @override
  State<ADR_Patient_Route> createState() => _ADR_Patient_RouteState();
}

class _ADR_Patient_RouteState extends State<ADR_Patient_Route> {
  @override
  Widget build(BuildContext context) {
    if(xerostomia <= 4.0 && acbScore == 0) {
      return const PatientLowRisk();
    } else if(((xerostomia >= 4.0) || (xerostomia <= 6.0)) && ((acbScore == 1) || (acbScore == 2))) {
      return const PatientAverageRisk();
    } else {
      return const PatientHighRisk();
    }  }
}