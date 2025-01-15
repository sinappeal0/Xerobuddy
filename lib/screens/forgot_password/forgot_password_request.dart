import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/forgot_password/forgot_password_sent.dart';

import '../authentication/login_or_register.dart';

class ForgotPasswordRequest extends StatefulWidget {
  const ForgotPasswordRequest({super.key});

  @override
  State<ForgotPasswordRequest> createState() => _ForgotPasswordRequestState();
}

class _ForgotPasswordRequestState extends State<ForgotPasswordRequest> {
  final TextEditingController forgotPassEmailController = TextEditingController();

  @override
  void dispose() {
    forgotPassEmailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotPassEmailController.text.trim()
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordSent()));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password reset email sent.", style: GoogleFonts.poppins(),),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.grey[900],
          elevation: 30,
        ),
      );
    } on FirebaseAuthException catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error occurred : ${e.code}", style: GoogleFonts.poppins(),),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.grey[900],
          elevation: 30,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginOrRegister()));}, icon: const Icon(CupertinoIcons.multiply))
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(CupertinoIcons.lock_rotation_open, size: 150,),

              // Image.asset("assets/images/forgot_password.png"),
              const SizedBox(height: 20,),
              Text("Forgot Password", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 30)),
              const SizedBox(height: 10,),
              Text("Please enter your registered email to get the password reset link.", style: GoogleFonts.poppins(), textAlign: TextAlign.center,),

              const SizedBox(height: 20,),
              SizedBox(
                child: TextField(
                  // onChanged: (value) => updateList(value),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffbba7e8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Email",
                    hintStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.email_rounded, color: Colors.black,),
                  ),
                  controller: forgotPassEmailController,
                ),
              ), // Email
              const SizedBox(height: 20,),

              GestureDetector(
                onTap: passwordReset,
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xff8359e3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('Request', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white), textAlign: TextAlign.center,),
                ),
              ),
              const SizedBox(height: 50,),

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginOrRegister()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RotatedBox(
                      quarterTurns: 2,
                      child: Icon(Icons.arrow_right_alt,),
                    ),
                    Text("back to Sign in", style: GoogleFonts.poppins(fontWeight: FontWeight.w500),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
