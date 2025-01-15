import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/util/globals.dart';


class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                SizedBox(height: 250, child: Image.asset("assets/images/magnifying_glass.gif")),

                // Title
                Text("Discover personalized solutions", style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),

                // Desscription
                Text("Based on your saliva parameters to combat dry mouth!", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),

                const SizedBox(height: 100,),

                GestureDetector(
                  onTap: () {
                    pageController.nextPage(duration: Duration(milliseconds: 100), curve: Curves.easeIn);
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
