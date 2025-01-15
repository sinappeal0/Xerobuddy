import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/globals.dart';

class AddProfessionalGroup extends StatefulWidget {
  const AddProfessionalGroup({super.key});

  @override
  State<AddProfessionalGroup> createState() => _AddProfessionalGroupState();
}

class _AddProfessionalGroupState extends State<AddProfessionalGroup> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            pageController.previousPage(duration: const Duration(milliseconds: 50), curve: Curves.easeIn);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24,),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: GoogleFonts.poppins(fontSize: 23, color: Colors.white),
                  children: <TextSpan>[
                    const TextSpan(text: "To which "),
                    TextSpan(text: "professional group", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    const TextSpan(text: " do you belong?"),
                  ]
              ),
            ),
            const SizedBox(height: 30,),

            GestureDetector(
              onTap: () {
                userProfession = "Dentist";

                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).update({
                  "userProfession": userProfession,
                  "first_visit": false,
                });
              },
              child: Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff8359E3).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: const Color(0xff7f49ff).withOpacity(0.3),
                        width: 2
                    )
                ),
                child: Text('Dentist', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
              ),
            ),
            const SizedBox(height: 10,),

            GestureDetector(
              onTap: () {
                userProfession = "Dental Assistant";

                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).update({
                  "userProfession": userProfession,
                  "first_visit": false,
                });
              },
              child: Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff8359E3).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: const Color(0xff7f49ff).withOpacity(0.3),
                        width: 2
                    )
                ),
                child: Text('Dental Assisteant', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
              ),
            ),
            const SizedBox(height: 10,),

            GestureDetector(
              onTap: () {
                userProfession = "Doctor";

                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).update({
                  "userProfession": userProfession,
                  "first_visit": false,
                });
              },
              child: Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff8359E3).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: const Color(0xff7f49ff).withOpacity(0.3),
                        width: 2
                    )
                ),
                child: Text('Doctor', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
              ),
            ),
            const SizedBox(height: 10,),

            GestureDetector(
              onTap: () {
                userProfession = "Nurse";

                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).update({
                  "userProfession": userProfession,
                  "first_visit": false,
                });
              },
              child: Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff8359E3).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: const Color(0xff7f49ff).withOpacity(0.3),
                        width: 2
                    )
                ),
                child: Text('Nurse', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
              ),
            ),
            const SizedBox(height: 10,),

            GestureDetector(
              onTap: () {
                userProfession = "Pharmacist";

                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).update({
                  "userProfession": userProfession,
                  "first_visit": false,
                });
              },
              child: Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff8359E3).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: const Color(0xff7f49ff).withOpacity(0.3),
                        width: 2
                    )
                ),
                child: Text('Pharmacist', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
              ),
            ),
            const SizedBox(height: 10,),

            GestureDetector(
              onTap: () {
                userProfession = "Student";

                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).update({
                  "userProfession": userProfession,
                  "first_visit": false,
                });
              },
              child: Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff8359E3).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: const Color(0xff7f49ff).withOpacity(0.3),
                        width: 2
                    )
                ),
                child: Text('Student', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
              ),
            ),
            const SizedBox(height: 20,),

            // Divider
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or Are you", style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),

            GestureDetector(
              onTap: () {
                userProfession = "Patient";

                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).update({
                  "userProfession": userProfession,
                  "first_visit": false,
                });
              },
              child: Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff8359E3).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: const Color(0xff7f49ff).withOpacity(0.3),
                        width: 2
                    )
                ),
                child: Text('Patient', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
