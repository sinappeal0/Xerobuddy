import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/bottomNavigationBar.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final User? currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black54,
        ),
        actions: [
          // Profile Button
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const XBottomNavigationBar()));
            },
            icon: const Icon(Icons.home, color: Colors.black54,),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Bg1.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
          children: [
            const SizedBox(height: 80,),

            Text("Select your", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),),
            Text("Language", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black54),),
            const SizedBox(height: 40,),
            Container(
              width: 160,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xff7f49ff).withOpacity(0.2),
                  width: 3,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    child: Image.asset("assets/images/uk.png"),
                  ),
                  const SizedBox(width: 16,),
                  Text("English", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),),
                ],
              ),
            ),
            const SizedBox(height: 14,),

            Container(
              width: 160,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xff7f49ff).withOpacity(0.2),
                  width: 3,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    child: Image.asset("assets/images/german-flag.png"),
                  ),
                  const SizedBox(width: 14,),
                  Text("German", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
