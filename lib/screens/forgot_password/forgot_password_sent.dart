import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/forgot_password/forgot_password_request.dart';

import '../authentication/login_or_register.dart';

class ForgotPasswordSent extends StatefulWidget {
  const ForgotPasswordSent({super.key});

  @override
  State<ForgotPasswordSent> createState() => _ForgotPasswordSentState();
}

class _ForgotPasswordSentState extends State<ForgotPasswordSent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordRequest()));}, icon: const Icon(CupertinoIcons.multiply))
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
              Image.asset("assets/images/email_sent.png", height: 140,),
              const SizedBox(height: 20,),
              Text("Check your email !!", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 24)),
              const SizedBox(height: 10,),
              Text("We have just send a link on your email. Please check your email and click on that link to reset your password", style: GoogleFonts.poppins(), textAlign: TextAlign.center,),const SizedBox(height: 10,),
              const SizedBox(height: 10,),
              Text("If not auto redirected after verification, click \non the Continue button.", style: GoogleFonts.poppins(), textAlign: TextAlign.center,),

              const SizedBox(height: 50,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginOrRegister()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 250,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xff8359E3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('Continue', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white), textAlign: TextAlign.center,),
                ),
              ),
              const SizedBox(height: 30,),

              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordRequest()));
                },
                child: Text("Didn't recieve the email? Resend", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500),),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordRequest()));
                },
                child: Text("Wrong email entered? Re-Enter", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
