import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/salivary_assessment_screens/xerostomia_pages/xerostomia_q.dart';

import '../../model/bottomNavigationBar.dart';
import '../../util/globals.dart';

class SalivaryAssessment extends StatefulWidget {
  const SalivaryAssessment({super.key});

  @override
  State<SalivaryAssessment> createState() => _SalivaryAssessmentState();
}

class _SalivaryAssessmentState extends State<SalivaryAssessment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController patientAge = TextEditingController();
  final TextEditingController numberOfDrugs = TextEditingController();

  final User? currentUser = FirebaseAuth.instance.currentUser!;

  bool isButtonPressedM = false;
  bool isButtonPressedF = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: <Widget>[
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
        padding: const EdgeInsets.all(20.0),
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Bg2.png"),
              fit: BoxFit.cover,
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100,),
              Text("Salivary Assessment", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 28),),
              const SizedBox(height: 45,),
              Image.asset("assets/images/seniors 1.png"),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isButtonPressedM = !isButtonPressedM;
                            isButtonPressedF = false;
                          });

                          patientGender = 'Male';
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: isButtonPressedM ? Colors.blue : const Color(0xff8359E3).withOpacity(0.6),
                        ),
                        child: Text('Male', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400, color: isButtonPressedM ? Colors.white : Colors.white54),),
                      ),
                    ),
                    // const SizedBox(width: 80,),
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isButtonPressedF = !isButtonPressedF;
                            isButtonPressedM = false;
                          });

                          patientGender = 'Female';
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: isButtonPressedF ? Colors.pinkAccent : const Color(0xff8359E3).withOpacity(0.6),
                        ),
                        child: Text('Female', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400, color: isButtonPressedF ? Colors.white : Colors.white54),),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),


              // Patient Age
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 120,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        controller: patientAge,
                        decoration: InputDecoration(
                          counter: const Offstage(),
                          labelText: 'Age',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    Text('Your Age', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400),)
                  ],
                ),
              ),
              const SizedBox(height: 10,),

              // Number of Drugs suggested to patient
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 120,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        controller: numberOfDrugs,
                        decoration: InputDecoration(
                          counter: const Offstage(),
                          labelText: 'No of drugs',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    Text('Number\nof Drugs', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400),)
                  ],
                ),
              ),
              const SizedBox(height: 40,),

              GestureDetector(
                onTap: () {
                  try {
                    // Redirect to next page
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const XerostomiaQ()));

                    // Updating patient data into report of doctor side
                    FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).update({
                      "patientAge": patientAge.text,
                      "number_of_drugs": numberOfDrugs.text,
                      "patientGender": patientGender,
                    });

                    // Updating patient data into report of patient side
                    FirebaseFirestore.instance.collection("users").doc(newDocumentName.text).collection("reports").doc(newDocumentName.text).update({
                      "patientAge": patientAge.text,
                      "number_of_drugs": numberOfDrugs.text,
                      // "gender": patientGender,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Patient detail updated.", style: GoogleFonts.poppins(),),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.grey[900],
                          elevation: 30,
                        )
                    );

                    acbScore = 0;
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
          ),
        ),
      ),
    );
  }
}
