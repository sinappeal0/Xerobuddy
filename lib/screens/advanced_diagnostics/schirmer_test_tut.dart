import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/schirmer_test.dart';

class Schirmer_Test_Tutorial extends StatefulWidget {
  const Schirmer_Test_Tutorial({super.key});

  @override
  State<Schirmer_Test_Tutorial> createState() => _Schirmer_Test_TutorialState();
}

class _Schirmer_Test_TutorialState extends State<Schirmer_Test_Tutorial> {
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
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageScreen()));
            },
            icon: const Icon(Icons.home, color: Colors.black,),
          ),
          const SizedBox(width: 10,),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 85,),
            Text("Modified Schirmer\nTest Tutorial", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 28), textAlign: TextAlign.center,),
            const SizedBox(height: 40,),
            Container(
              child: Image.asset("assets/images/p3.png"),
            ),
            const SizedBox(height: 20,),
            Container(
              child: Image.asset("assets/images/p2.png"),
            ),
            const SizedBox(height: 40,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8359e3).withOpacity(0.70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fixedSize: const Size(150, 50)
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Schirmer_Test()));
              },
              child: Text('Back', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
