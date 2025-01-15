import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/salivary_assessment_screens/xerostomia_pages/xerostomia_q5.dart';

import '../../../model/bottomNavigationBar.dart';
import '../../../util/globals.dart';

class XerostomiaQ4 extends StatefulWidget {
  const XerostomiaQ4({super.key});

  @override
  State<XerostomiaQ4> createState() => _XerostomiaQ4State();
}

class _XerostomiaQ4State extends State<XerostomiaQ4> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40),
              child: Text(xQuestions[4], style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 80,),

            GestureDetector(
              onTap: () {
                try {
                  FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).collection("xerostomia_questions").doc("Question4").set({
                    "xQuestion": xQuestions[4],
                    "xQuestionAnswer": "Never",
                  });

                  // Redirect to next page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const XerostomiaQ5()));
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
                width: 220,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xff8359e3).withOpacity(0.70),
                    borderRadius: BorderRadius.circular(60)
                ),
                child: Center(
                  child: Text("Never", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
                ),
              ),
            ),
            const SizedBox(height: 20,),

            GestureDetector(
              onTap: () {
                try {
                  FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).collection("xerostomia_questions").doc("Question4").set({
                    "xQuestion": xQuestions[4],
                    "xQuestionAnswer": "Occassionally",
                  });

                  // Redirect to next page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const XerostomiaQ5()));
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
                width: 220,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xff8359e3).withOpacity(0.70),
                    borderRadius: BorderRadius.circular(60)
                ),
                child: Center(
                  child: Text("Occassionally", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
                ),
              ),
            ),
            const SizedBox(height: 20,),

            GestureDetector(
              onTap: () {
                try {
                  FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).collection("xerostomia_questions").doc("Question4").set({
                    "xQuestion": xQuestions[4],
                    "xQuestionAnswer": "Often",
                  });

                  // Redirect to next page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const XerostomiaQ5()));
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
                width: 220,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xff8359e3).withOpacity(0.70),
                    borderRadius: BorderRadius.circular(60)
                ),
                child: Center(
                  child: Text("Often", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
