import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/util/globals.dart';

import '../../model/bottomNavigationBar.dart';

class MedicalProductDetail extends StatefulWidget {
  const MedicalProductDetail({super.key});

  @override
  State<MedicalProductDetail> createState() => _MedicalProductDetailState();
}

class _MedicalProductDetailState extends State<MedicalProductDetail> {
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
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("medical_products").doc(medicineName).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                final medicine = snapshot.data!.data() as Map<String, dynamic>;

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [

                    const SizedBox(height: 30,),
                    Text("${medicine['name']}", style: GoogleFonts.inika(fontWeight: FontWeight.w600, fontSize: 20),),
                    Text("${medicine['description']}", style: GoogleFonts.inika(fontWeight: FontWeight.w400, fontSize: 14),),
                    const SizedBox(height: 30,),
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
          )
        )
    );
  }
}
