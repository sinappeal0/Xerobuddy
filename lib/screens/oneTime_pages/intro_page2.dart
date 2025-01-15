import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/globals.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
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
            child: Text(
              'Skip', style: GoogleFonts.poppins(color: Colors.black),),
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
                SizedBox(height: 250, child: Image.asset("assets/images/thoughtful.gif")),

                // Title
                Text("Get started straight away!", style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),

                // Desscription
                Text("No complicated instructions, no waiting times - quickly and easily identify your risk of dry mouth", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),

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
