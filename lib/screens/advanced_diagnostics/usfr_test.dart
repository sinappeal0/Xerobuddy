import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/cost_calculation.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/risk_screens/risk_screens.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/schirmer_test.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/usfr_test_tut.dart';
import 'package:xerobuddy_app/util/globals.dart';

import '../../model/bottomNavigationBar.dart';

class USFR_Test extends StatefulWidget {
  const USFR_Test({super.key});

  @override
  State<USFR_Test> createState() => _USFR_TestState();
}

class _USFR_TestState extends State<USFR_Test> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  // USFR Test
  TextEditingController usfr_test = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
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
            const SizedBox(height: 95,),
            Text("USFR Unstimulated\nSalivary Flow Rate", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 28), textAlign: TextAlign.center,),
            const SizedBox(height: 75,),
            Container(
              height: 125,
              width: 290,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Measurement Result", style: GoogleFonts.poppins(fontSize: 14),),
                  const SizedBox(height: 5,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 100,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: usfr_test,
                          decoration: InputDecoration(
                            hintText: '0.0',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text('ml/min', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100,),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const USFR_Test_Tutorial()));
              },
              child: Container(
                height: 55,
                width: 180,
                decoration: BoxDecoration(
                    color: const Color(0xff6284ff),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Image.asset("assets/images/light_bulb.png", height: 35,),
                      Text("Tutorial", style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff8359e3).withOpacity(0.70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        fixedSize: const Size(160, 50)
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Schirmer_Test()));

                      FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).update({
                        "usfr": double.parse(usfr_test.text),
                      });
                    },
                    child: Text('Next', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff8359e3).withOpacity(0.70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        fixedSize: const Size(160, 50)
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RiskScreens()));
                    },
                    child: Text('Summary', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8359e3).withOpacity(0.70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fixedSize: const Size(220, 50)
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CostCalculation()));
              },
              child: Text('Cost Calculation', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
