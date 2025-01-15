import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/globals.dart';

class AddAge extends StatefulWidget {
  const AddAge({super.key});

  @override
  State<AddAge> createState() => _AddAgeState();
}

class _AddAgeState extends State<AddAge> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  final TextEditingController addAgeController = TextEditingController();

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
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Bg2.png"),
            fit: BoxFit.cover,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                    style: GoogleFonts.poppins(fontSize: 23, color: Colors.white),
                    children: <TextSpan>[
                      const TextSpan(text: "How "),
                      TextSpan(text: "old", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      const TextSpan(text: " are you?"),
                    ]
                ),
              ),

              const SizedBox(height: 20,),
              SizedBox(
                width: 300,
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    counter: const Offstage(),
                    filled: true,
                    fillColor: const Color(0xffbba7e8).withOpacity(0.85),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Enter your age here...",
                    hintStyle: const TextStyle(color: Colors.white38),
                    prefixIcon: const Icon(Icons.person, color: Colors.white60,),
                  ),
                  controller: addAgeController,
                ),
              ),
              const SizedBox(height: 200,),

              GestureDetector(
                onTap: () {
                  pageController.nextPage(duration: const Duration(milliseconds: 50), curve: Curves.easeIn);

                  try {
                    // Updating the first visit value to false and adding other user data collected for the only single time.
                    FirebaseFirestore.instance.collection("users").doc(currentUser!.email).update({
                      "userAge": addAgeController.text,
                    });

                    // Showing user that nickname is added and status updated
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Age is updated.", style: GoogleFonts.poppins(),),
                          behavior: SnackBarBehavior.floating,
                          // backgroundColor: Color(0xff0000000).withOpacity(0.4),
                          backgroundColor: Colors.grey[900],
                          elevation: 30,
                        )
                    );

                  } on FirebaseException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error occurred : ${e.code}", style: GoogleFonts.poppins(),),
                          behavior: SnackBarBehavior.floating,
                          // backgroundColor: Color(0xff0000000).withOpacity(0.4),
                          backgroundColor: Colors.grey[900],
                          elevation: 30,
                        )
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xff8359e3).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text('Next', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
