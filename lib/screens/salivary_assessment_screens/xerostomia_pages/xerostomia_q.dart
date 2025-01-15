import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/salivary_assessment_screens/xerostomia_pages/xerostomia_q1.dart';

import '../../../model/bottomNavigationBar.dart';
import '../../../util/globals.dart';


class XerostomiaQ extends StatefulWidget {
  const XerostomiaQ({super.key});

  @override
  State<XerostomiaQ> createState() => _XerostomiaQState();
}

class _XerostomiaQState extends State<XerostomiaQ> {
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
              const SizedBox(height: 85,),
              Text("Xerostomia\nInventory", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 28), textAlign: TextAlign.center,),
              const SizedBox(height: 45,),
              Padding(
                padding: const EdgeInsets.only(right: 40, left: 40),
                child: Text('We use the Xerostomia Inventory (XI) to better understand the extent of your subjective dry mouth. This short questionnaire is made up of five questions, each with three possible answers. ”', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 200,),

              GestureDetector(
                onTap: () {
                  // Redirect to next page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const XerostomiaQ1()));
                },
                child: Container(
                  width: 160,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xff8359e3).withOpacity(0.70),
                      borderRadius: BorderRadius.circular(60)
                  ),
                  child: Center(
                    child: Text("OK", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
