import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/forgot_password/forgot_password_request.dart';

import 'google_auth_login_service.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signInUser() async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text,).then((value){
        FirebaseFirestore.instance.collection("users").doc(value.user!.email).update({
          "first_visit": false,
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Logged In", style: GoogleFonts.poppins(),),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.grey[900],
              elevation: 30,
            )
        );
      });
    } on FirebaseAuthException catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error occurred : ${e.code}", style: GoogleFonts.poppins(),),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.grey[900],
            elevation: 30,
          )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Bg2.png"),
              fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40,),
                const Icon(Icons.lock, size: 125,),
                const SizedBox(height: 30,),

                // Title here
                Text("Welcome back you've been missed!", style: GoogleFonts.poppins(),),
                const SizedBox(height: 25,),

                // Email Textfield
                SizedBox(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffbba7e8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Email",
                      hintStyle: const TextStyle(color: Colors.white38),
                      prefixIcon: const Icon(Icons.email_rounded, color: Colors.white60,),
                    ),
                    controller: emailController,
                  ),
                ), // Email
                const SizedBox(height: 10,),

                // Password Textfield
                SizedBox(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffbba7e8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.white38),
                      prefixIcon: const Icon(Icons.password_rounded, color: Colors.white60,),
                    ),
                    controller: passwordController,
                  ),
                ), // Password
                const SizedBox(height: 10,),

                // Forgot Password
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordRequest()));
                    },
                    child: Text("Forgot Password?", style: GoogleFonts.poppins(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 10,),

                // Sign In button
                GestureDetector(
                  onTap: () async {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AddAge()));
                    signInUser();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 400,
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xff8359E3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Sign In', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white), textAlign: TextAlign.center,),
                  ),
                ),
                const SizedBox(height: 40,),

                // Or continue with
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 0.75,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Or continue with", style: GoogleFonts.poppins(),),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 0.75,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40,),

                // Google + Apple sign-in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        GoogleAuthLoginService().signInWithGoogle();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff8359E3)),
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xff8359E3).withOpacity(0.4),
                        ),
                        child: Image.asset("assets/images/Google.png", height: 40,),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff8359E3)),
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xff8359E3).withOpacity(0.4),
                      ),
                      child: Image.asset("assets/images/Apple_Logo.png", height: 40,),
                    )
                  ],
                ),
                const SizedBox(height: 40,),

                // Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?", style: GoogleFonts.poppins(),),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Sign Up!",
                        style: GoogleFonts.poppins(color: const Color(0xff8359E3), fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
