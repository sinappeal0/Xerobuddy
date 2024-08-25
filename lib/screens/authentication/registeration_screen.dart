import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/authentication/google_auth_reg_service.dart';

class RegisterationScreen extends StatefulWidget {
  final void Function()? onTap;
  RegisterationScreen({super.key, required this.onTap});

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerUsernameController = TextEditingController();
  final TextEditingController registerPasswordController = TextEditingController();
  final TextEditingController registerConfirmPasswordController = TextEditingController();

  // Register method
  void registerUser() async {
    // Make sure that passwords are matching
    if(registerPasswordController.text == registerConfirmPasswordController.text) {
      // Creating User
      try{
        // User Creation
        UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerEmailController.text,
          password: registerPasswordController.text,
        ).then((value) {
          FirebaseFirestore.instance.collection("users").doc(value.user!.email).set({
            "email": registerEmailController.text,
            "username": registerUsernameController.text,
            "first_visit": true,
          });

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Account registered.", style: GoogleFonts.poppins(),),
                behavior: SnackBarBehavior.floating,
                // backgroundColor: Color(0xff0000000).withOpacity(0.4),
                backgroundColor: Colors.grey[900],
                elevation: 30,
              )
          );
        });
      } on FirebaseAuthException catch(e){
        print("~~~~~~~~~~~~ Error is : ${e}");
        if(e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Email already in use.", style: GoogleFonts.poppins(),),
                behavior: SnackBarBehavior.floating,
                // backgroundColor: Color(0xff0000000).withOpacity(0.4),
                backgroundColor: Colors.grey[900],
                elevation: 30,
              )
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Passwords don't match", style: GoogleFonts.poppins(),),
            behavior: SnackBarBehavior.floating,
            // backgroundColor: Color(0xff0000000).withOpacity(0.4),
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
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Bg2.png"),
            fit: BoxFit.cover,
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              const Icon(Icons.lock, size: 80,),
              const SizedBox(height: 20,),
          
              // Title
              Text("Let's create an account for you!", style: GoogleFonts.poppins(),),
              const SizedBox(height: 25,),
          
              // Username Textfield
              SizedBox(
                child: TextField(
                  // onChanged: (value) => updateList(value),
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffbba7e8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Username",
                    hintStyle: const TextStyle(color: Colors.white38),
                    prefixIcon: const Icon(Icons.email_rounded, color: Colors.white60,),
                  ),
                  controller: registerUsernameController,
                ),
              ),
              const SizedBox(height: 10,),
          
              // Email Textfield
              SizedBox(
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.white),
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
                  controller: registerEmailController,
                ),
              ),
              const SizedBox(height: 10,),
          
              // Password Textfield
              SizedBox(
                child: TextField(
                  textInputAction: TextInputAction.next,
                  // onChanged: (value) => updateList(value),
                  style: const TextStyle(color: Colors.white),
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
                  controller: registerPasswordController,
                  // obscureText: _obscureText,
                ),
              ),
              const SizedBox(height: 10,),
          
              // Confirm Password Textfield
              SizedBox(
                child: TextField(
                  textInputAction: TextInputAction.done,
                  // onChanged: (value) => updateList(value),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffbba7e8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Confirm password",
                    hintStyle: const TextStyle(color: Colors.white38),
                    prefixIcon: const Icon(Icons.password_rounded, color: Colors.white60,),
                  ),
                  controller: registerConfirmPasswordController,
                  // obscureText: true,
                ),
              ),
              const SizedBox(height: 20,),
          
              // Register button
              InkWell(
                onTap: () async {
                  registerUser();
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
                  child: Text('Sign Up', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white), textAlign: TextAlign.center,),
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
                  GestureDetector(
                    onTap: () {
                      GoogleAuthRegService().signUpWithGoogle();
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
          
              // Already Registered Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a member?", style: GoogleFonts.poppins(),),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Sign In!",
                      style: GoogleFonts.poppins(color: const Color(0xff8359E3), fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}