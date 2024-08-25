import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/medical_products/medical_product_detail.dart';
import 'package:xerobuddy_app/util/globals.dart';

class MedicalProducts extends StatefulWidget {
  const MedicalProducts({super.key});

  @override
  State<MedicalProducts> createState() => _MedicalProductsState();
}

class _MedicalProductsState extends State<MedicalProducts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final User? currentUser = FirebaseAuth.instance.currentUser!;

  var searchMedicalProduct = "";
  List medicalProducts = [];

  getMedicalProducts () async {
    await FirebaseFirestore.instance.collection("medical_products").get().then((value) {
      for(var i in value.docs) {
        medicalProducts.add(i.data());
      }
    });
  }

  @override
  void initState() {
    getMedicalProducts();
    medicineName = '';
    // TODO: implement initState
    super.initState();
  }
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30,),

              Text("Products", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 26, color: Colors.black54),),
              const SizedBox(height: 20,),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    searchMedicalProduct = val;
                  });
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffbba7e8).withOpacity(0.85),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(width: 1),
                    ),
                    hintText: "Search here...",
                    hintStyle: GoogleFonts.poppins(color: Colors.white60),
                    prefixIcon: const Icon(Icons.search, color: Colors.white60,)
                ),
              ),
              const SizedBox(height: 20,),

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("medical_products").orderBy("name").startAt([searchMedicalProduct]).endAt([searchMedicalProduct + "\uf8ff"]).snapshots(),
                builder: (context, snapshots) {
                  return (snapshots.connectionState == ConnectionState.waiting) ? const Center(child: CircularProgressIndicator(),) : GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var medProduct = snapshots.data!.docs[index].data() as Map<String, dynamic>;

                      if(medProduct.isEmpty) {
                        return Center(
                          child: Text("No medical products found", style: GoogleFonts.poppins(),),
                        );
                      }

                      if(medProduct['name'].toString().toLowerCase().startsWith(medProduct['name'].toLowerCase())) {
                        return GestureDetector(
                          onTap: () {
                            medicineName = medProduct['name'];

                            // Redirect to Medicine Detail
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicalProductDetail()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xff7f49ff).withOpacity(0.2),
                                width: 3,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 80,
                                  child: Image.asset("assets/images/acticoat.webp",),
                                ),
                                const SizedBox(height: 16,),
                                Text("${medProduct['name']}", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black54), overflow: TextOverflow.ellipsis,),
                                Text("${medProduct['description']}", style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
