import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:xerobuddy_app/screens/settings/about_xerobuddy.dart';
import 'package:xerobuddy_app/screens/settings/faq_screen.dart';
import 'package:xerobuddy_app/screens/settings/select_language.dart';
import 'package:xerobuddy_app/screens/settings/terms_and_conditions.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final User? currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.all(20.0),
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Bg2.png"),
              fit: BoxFit.cover,
            )
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(currentUser!.email).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final userProfile = snapshot.data!.data() as Map<String, dynamic>;

              return Column(
                children: [
                  const SizedBox(height: 40,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("About You", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),),
                  ),
                  const SizedBox(height: 20,),

                  // About User
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 170,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xff7f49ff).withOpacity(0.2),
                            width: 3,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Username", style: GoogleFonts.poppins(fontSize: 12),),
                            Text("${userProfile['userNickname']}", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xff7f49ff).withOpacity(0.2),
                            width: 3,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Profession", style: GoogleFonts.poppins(fontSize: 12),),
                            Text("${userProfile['userProfession']}", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),

                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("App Settings", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),),
                  ),
                  const SizedBox(height: 20,),

                  // About Xerobuddy
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
                        Text("About Xerobuddy", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutXerobuddy()));
                          },
                          child: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // FAQ
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FAQScreen()));
                    },
                    child: Container(
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
                          Text("FAQ", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Terms & Conditions
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsAndConditions()));
                    },
                    child: Container(
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
                          Text("Terms & Conditions", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Language
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectLanguage()));
                    },
                    child: Container(
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
                          Text("Select Language", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Logout
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
                        Text("Logout", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),),
                        GestureDetector(
                          onTap: () {
                            try{
                              FirebaseAuth.instance.signOut().then((value){
                                GoogleSignIn().disconnect();
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Logged out successfully.", style: GoogleFonts.poppins(),),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.grey[900],
                                    elevation: 30,
                                  )
                              );
                            } on FirebaseException catch(e) {
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
                          child: const Icon(Icons.logout_rounded),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Delete Account
                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white.withOpacity(0.5),
                  //     borderRadius: BorderRadius.circular(20),
                  //     border: Border.all(
                  //       color: const Color(0xff7f49ff).withOpacity(0.2),
                  //       width: 3,
                  //     ),
                  //   ),
                  //   child: Text("Delete you account", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),),
                  // ),
                ],
              );
            } else if (snapshot.hasError){
              return Center(
                child: Text("Error + ${snapshot.error}"),
              );
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}
