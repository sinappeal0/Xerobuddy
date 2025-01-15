import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/salivary_assessment_screens/drug_list.dart';

import '../../../model/bottomNavigationBar.dart';
import '../../../util/globals.dart';

class Xerostomia extends StatefulWidget {
  const Xerostomia({super.key});

  @override
  State<Xerostomia> createState() => _XerostomiaState();
}

class _XerostomiaState extends State<Xerostomia> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final User? currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: [
          // Discard report button
          TextButton(
            onPressed: () {
              try {
                // Delete the report from professional and patient side
                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).delete();

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Successfully deleted report.", style: GoogleFonts.poppins(),),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.grey[900],
                      elevation: 30,
                    )
                );

                Navigator.pop(context);
                // Redirect back to the dashboard
                Navigator.push(context, MaterialPageRoute(builder: (context) => const XBottomNavigationBar()));
              } on FirebaseException catch(e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error occurred : ${e.code}.", style: GoogleFonts.poppins(),),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.grey[900],
                      elevation: 30,
                    )
                );
              }
            },
            child: Text("Discard", style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 16),),
          ),

          // Home Button
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const XBottomNavigationBar()));
            },
            icon: const Icon(Icons.home),
          )
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Bg1.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
          children: [
            const SizedBox(height: 85,),
            Text("Xerostomia\nVAS", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 28), textAlign: TextAlign.center,),
            const SizedBox(height: 45,),
            Text('Rate Your Dry Mouth Intensity', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400),),
            const Divider(
              height: 30,
              thickness: 1.5,
              indent: 90,
              endIndent: 90,
              color: Colors.black,
            ),
            Text(xerostomia.toStringAsFixed(1), style: GoogleFonts.poppins(fontSize: 40, fontWeight: FontWeight.w600),),
            // const SizedBox(height: 40,),

            // Xerostomia Slider
            Slider(
              value: xerostomia,
              min: 0.0,
              max: 10.0,
              divisions: 100,
              activeColor: const Color(0xff8359e3),
              inactiveColor: const Color(0xffba96ca),
              label: 'Set Xerostomia Score',
              onChanged: (double newValue) {
                setState(() {
                  xerostomia = newValue;
                });
              },
              semanticFormatterCallback: (double newValue) {
                return '${newValue.toInt()} dollars';
              },
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('0', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500),),
                      Text('no dry\nmouth\nat all', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),),
                    ],
                  ),
                  Column(
                    children: [
                      Text('10', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500),),
                      Text('complete\ndryness', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 250,),

            GestureDetector(
              onTap: () {
                try {
                  // Redirect to next page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DrugList()));

                  // Updating doctor data into report of doctor side
                  FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).update({
                    "xerostomia": xerostomia,
                  });

                  // Updating patient data into report of patient side
                  FirebaseFirestore.instance.collection("users").doc(newDocumentName.text).collection("reports").doc(newDocumentName.text).update({
                    "xerostomia": xerostomia,
                  });
                } on FirebaseException catch(e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error occurred while updating data.", style: GoogleFonts.poppins(),),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.grey[900],
                        elevation: 30,
                      )
                  );
                }
              },
              child: Container(
                width: 160,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xff8359e3).withOpacity(0.70),
                    borderRadius: BorderRadius.circular(60)
                ),
                child: Center(
                  child: Text("Next", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
