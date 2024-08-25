import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/util/globals.dart';

class AddNickname extends StatefulWidget {
  const AddNickname({super.key});

  @override
  State<AddNickname> createState() => _AddNicknameState();
}

class _AddNicknameState extends State<AddNickname> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  final TextEditingController addUserNickname = TextEditingController();

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
            fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                    style: GoogleFonts.poppins(fontSize: 23, color: Colors.white),
                    children: <TextSpan>[
                      const TextSpan(text: "What's your "),
                      TextSpan(text: "Nickname?", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    ]
                ),
              ),
              const SizedBox(height: 20,),

              SizedBox(
                width: 300,
                child: TextField(
                  // onChanged: (value) => updateList(value),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffbba7e8).withOpacity(0.85),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Enter your name here...",
                      hintStyle: const TextStyle(color: Colors.white38),
                      prefixIcon: const Icon(Icons.search, color: Colors.white60,),
                      prefixIconColor: Colors.black54
                  ),
                  controller: addUserNickname,
                ),
              ),
              const SizedBox(height: 200,),

              GestureDetector(
                onTap: () async {
                  pageController.nextPage(duration: const Duration(milliseconds: 50), curve: Curves.easeIn);

                  try {
                    // Updating the first visit value to false and adding other user data collected for the only single time.
                    FirebaseFirestore.instance.collection("users").doc(currentUser!.email).update({
                      "userNickname": addUserNickname.text,
                    });

                    // Showing user that nickname is added and status updated
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Nickname is updated.", style: GoogleFonts.poppins(),),
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
                    color: const Color(0xff8359E3).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text('Next', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
