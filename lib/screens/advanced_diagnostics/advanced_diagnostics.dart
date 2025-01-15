import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/schirmer_test.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/usfr_test.dart';

import '../../model/bottomNavigationBar.dart';
import '../../util/globals.dart';

class AdvancedDiagnostics extends StatefulWidget {
  const AdvancedDiagnostics({super.key});

  @override
  State<AdvancedDiagnostics> createState() => _AdvancedDiagnosticsState();
}

class _AdvancedDiagnosticsState extends State<AdvancedDiagnostics> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
              image: AssetImage("assets/images/Bg2.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Advanced\nDiagnostics", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 28), textAlign: TextAlign.center,),
                Image.asset("assets/images/stethoscope_1.png", height: 75,),
              ],
            ),
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: Text("Based on your current results, we recommend undergoing a more in-depth diagnostic evaluation", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14),),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: Text("For this purpose, the modified Schirmer test or the unstimulated salivary flow rate measurement are suitable", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14),),
            ),
            const SizedBox(height: 75,),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const USFR_Test()));
              },
              child: Container(
                height: 75,
                width: 150,
                decoration: BoxDecoration(
                    color: const Color(0xffff72b6),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/microskop 1.png", height: 45,),
                    Text("USFR", style: GoogleFonts.poppins(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25,),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Schirmer_Test()));
              },
              child: Container(
                height: 75,
                width: 215,
                decoration: BoxDecoration(
                    color: const Color(0xffff72b6),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  children: [
                    Image.asset("assets/images/stethoscope.png", height: 45,),
                    Text("Schimer Test", style: GoogleFonts.poppins(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
