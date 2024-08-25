import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalivaFacts extends StatefulWidget {
  const SalivaFacts({super.key});

  @override
  State<SalivaFacts> createState() => _SalivaFactsState();
}

class _SalivaFactsState extends State<SalivaFacts> {
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
        automaticallyImplyLeading: false,
        actions: [
          // Logout Button
          // IconButton(
          //   onPressed: () {
          //     try{
          //       FirebaseAuth.instance.signOut().then((value){
          //         GoogleSignIn().disconnect();
          //       });
          //
          //       ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(
          //             content: Text("Logged out successfully.", style: GoogleFonts.poppins(),),
          //             behavior: SnackBarBehavior.floating,
          //             backgroundColor: Colors.grey[900],
          //             elevation: 30,
          //           )
          //       );
          //     } on FirebaseException catch(e) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(
          //             content: Text("Error occurred : ${e.code}", style: GoogleFonts.poppins(),),
          //             behavior: SnackBarBehavior.floating,
          //             // backgroundColor: Color(0xff0000000).withOpacity(0.4),
          //             backgroundColor: Colors.grey[900],
          //             elevation: 30,
          //           )
          //       );
          //     }
          //   },
          //   icon: const Icon(Icons.logout_rounded),)
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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(currentUser!.email).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final userProfile = snapshot.data!.data() as Map<String, dynamic>;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40,),
                  Text("What are you interested in?", style: GoogleFonts.poppins(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 10,),

                  SizedBox(
                    // width: 200,
                    child: TextFormField(
                      onChanged: (val) {},
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffbba7e8).withOpacity(0.85),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(width: 5),
                          ),
                          hintText: "Search here...",
                          hintStyle: GoogleFonts.poppins(color: Colors.white60),
                          prefixIcon: const Icon(Icons.search, color: Colors.white60,)
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),

                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.5),
                            border: Border.all(width: 2, color: const Color(0xff7f49ff).withOpacity(0.2),),
                          ),
                          child: Text("Title Here", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),),
                        );
                      },
                    ),
                  )
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
