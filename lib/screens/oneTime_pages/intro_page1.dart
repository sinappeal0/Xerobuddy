import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/util/globals.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // pageController.nextPage(duration: Duration(milliseconds: 100), curve: Curves.easeIn);
              pageController.jumpToPage(2);
            },
            child: Text('Skip', style: GoogleFonts.poppins(color: Colors.black),),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 250, child: Image.asset("assets/images/waves1.gif")),

                // Title
                Text("Welcome to your personal saliva assistant!", style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),

                // Desscription
                Text("Precise, fast and always available", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),

                const SizedBox(height: 100,),

                GestureDetector(
                  onTap: () {
                    pageController.nextPage(duration: const Duration(milliseconds: 50), curve: Curves.easeIn);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff8359e3).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text("Great", style: GoogleFonts.poppins(fontSize: 20, fontWeight:FontWeight.w500, color: Colors.white),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
