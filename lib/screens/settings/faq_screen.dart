import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/bottomNavigationBar.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
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

            Text("FAQ Questions", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black54),),
            const SizedBox(height: 40,),
            Container(
              width: double.infinity,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Question 1", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.keyboard_arrow_down_rounded, size: 34, color: Colors.black54,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Question 2", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.keyboard_arrow_down_rounded, size: 34, color: Colors.black54,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Question 3", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.keyboard_arrow_down_rounded, size: 34, color: Colors.black54,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Question 4", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.keyboard_arrow_down_rounded, size: 34, color: Colors.black54,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Question 5", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.keyboard_arrow_down_rounded, size: 34, color: Colors.black54,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Question 6", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.keyboard_arrow_down_rounded, size: 34, color: Colors.black54,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
