import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xerobuddy_app/screens/profession_group/professional_dashboard.dart';
import 'package:xerobuddy_app/screens/salivary_assessment_screens/acb_score_screen.dart';
import 'package:xerobuddy_app/util/globals.dart';

import '../../model/bottomNavigationBar.dart';

class DrugList extends StatefulWidget {
  const DrugList({super.key});

  @override
  State<DrugList> createState() => _DrugListState();
}

class _DrugListState extends State<DrugList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _searchController = TextEditingController();

  final TextEditingController drugNameC = TextEditingController();
  final TextEditingController acbScoreC = TextEditingController();

  final User? currentUser = FirebaseAuth.instance.currentUser!;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Show user an initial pop up to add medication
    WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 5),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: Stack(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 375),
                padding: const EdgeInsets.all(16),
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xff7b1a28),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/pills.png", height: 50, width: 50,),
                    const SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alert!!!', style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),),
                        const SizedBox(height: 5,),
                        Text('Please add your medications.', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    ));
  }

  getCountOfDrugs() async {
    FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).snapshots().listen((docSnapshot) {
      Map<String, dynamic> data = docSnapshot.data()!;
      setState(() {
        countOfDrugs = int.parse(data['number_of_drugs']);
      });
    });
  }

  var searchDrugName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: <Widget>[
          // Discard report button
          TextButton(
            onPressed: () {
              try {
                // Delete the report from professional and patient side
                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).delete();

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Successfully deleted report.", style: GoogleFonts.poppins(),),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.grey[900],
                      elevation: 30,
                    )
                );

                Navigator.pop(context);
                // Redirect back to the dashboard
                Navigator.push(context, MaterialPageRoute(builder: (context) => const XBottomNavigationBar()));
              } on FirebaseException catch(e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error occurred : ${e.code}.", style: GoogleFonts.poppins(),),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.grey[900],
                      elevation: 30,
                    )
                );
              }
            },
            child: Text("Discard", style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 16),),
          ),

          // Home Button
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const XBottomNavigationBar()));
            },
            icon: const Icon(Icons.home),
          )
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Bg1.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 75,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Drug Search", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 28),),
                  Image.asset("assets/images/drug_search.png", height: 75,),
                ],
              ),
              const SizedBox(height: 25,),
              Row(
                children: [
                  SizedBox(
                    width: 285,
                    child: TextField(
                      onChanged: (query) {
                        setState(() {
                          searchDrugName = query;
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffbba7e8).withOpacity(0.85),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Search",
                          hintStyle: const TextStyle(color: Colors.black54),
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor: Colors.black54
                      ),
                      controller: _searchController,
                    ),
                  ), //Drug Search Field
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          isScrollControlled: true,
                          isDismissible: true,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: SizedBox(
                                height: 400,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Drug Detail", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 36, color: const Color(0xff8359e3)),),
                                      const Text("Enter drug details here to add into the list of drugs.",),
                                      const SizedBox(height: 20,),
                                      Text("Drug Name", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12, color: const Color(0xff8359e3)),),
                                      const SizedBox(height: 3,),
                                      SizedBox(
                                        child: TextField(
                                          textInputAction: TextInputAction.next,
                                          controller: drugNameC,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: const Color(0xffbba7e8).withOpacity(0.85),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            hintText: "Drug Name",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Text("Acb Score", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12, color: const Color(0xff8359e3)),),
                                      const SizedBox(height: 3,),
                                      SizedBox(
                                        child: TextField(
                                          controller: acbScoreC,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: const Color(0xffbba7e8).withOpacity(0.85),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            hintText: "Acb Score",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 40,),
                                      Align(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () async {
                                            Navigator.pop(context);

                                            Map<String, dynamic> data = {
                                              "drugName": drugNameC.text,
                                              "acbScore": acbScoreC.text,
                                            };
                                            FirebaseFirestore.instance.collection("main_drug_list").add(data).then((value) {
                                              Navigator.pop(context);
                                            }).catchError((error) => print("Failed to add new drug to the existing list."));

                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Stack(
                                                  // clipBehavior: Clip.none,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 375),
                                                        padding: const EdgeInsets.all(16),
                                                        height: 100,
                                                        decoration: const BoxDecoration(
                                                          color: Color(0xff009607),
                                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/pills.png",
                                                              height: 50,
                                                              width: 50,
                                                            ),
                                                            const SizedBox(width: 20,),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text('Hurray!', style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),),
                                                                  const SizedBox(height: 5,),
                                                                  Text('You have added Drug : ${drugNameC.text}.', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ]
                                                ),
                                                elevation: 0,
                                                behavior: SnackBarBehavior.floating,
                                                backgroundColor: Colors.transparent,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 160,
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            decoration: BoxDecoration(
                                                color: const Color(0xff8359e3).withOpacity(0.70),
                                                borderRadius: BorderRadius.circular(60)
                                            ),
                                            child: Center(
                                              child: Text("Save Drug", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff8359e3)
                      ),
                      child: const Icon(Icons.add, size: 30, color: Colors.white,),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Drugs List
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("main_drug_list").orderBy('drugName').startAt([searchDrugName]).endAt([searchDrugName + "\uf8ff"]).snapshots(),
                  builder: (context, snapshots) {
                    return (snapshots.connectionState == ConnectionState.waiting) ? const Center(child: CircularProgressIndicator(),) : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        var drugList = snapshots.data!.docs[index].data() as Map<String, dynamic>;

                        if(drugList.isEmpty) {
                          return Text("No drugs found", style: GoogleFonts.poppins(fontWeight: FontWeight.bold),);
                        }

                        if(drugList.isNotEmpty) {
                          return Card(
                            color: const Color(0xffbba7e8).withOpacity(0.8),
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(left: 20, bottom: 5, top: 5, right: 10),
                              title: Text("${drugList['drugName']}", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),),
                              subtitle: Text("Acb Score : ${drugList['acbScore']}", style: GoogleFonts.poppins(fontSize: 12),),
                              trailing: IconButton(
                                iconSize: 40.0,
                                icon: const Icon(Icons.add_box_rounded),
                                color: const Color(0xff8359e3),
                                onPressed: () {
                                  Map<String, dynamic> data = {
                                    "drugName": drugList['drugName'],
                                    "acbScore": drugList['acbScore'],
                                  };
// Updating doctor data into report of doctor side
                                  FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).collection("drugsRecommended").doc(data['drugName']).set(data);

// Get the number of drugs
                                  getCountOfDrugs();

                                  acbScore = data['acbScore'] + acbScore;

// Syncfusion value
                                  if(acbScore <= 0) {
                                    acbScore = 0;
                                    acbScoreSync = 10;
                                  } else if(acbScore == 1) {
                                    acbScoreSync = acbScore * 30;
                                  } else if(acbScore == 2) {
                                    acbScoreSync = acbScore * 30;
                                  } else if(acbScore == 3 || acbScore >= 3) {
                                    acbScore = 3;
                                    acbScoreSync = acbScore * 33.45;
                                  }

                                  FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).update({
                                    'acbScore': acbScore,
                                    'acbScoreSync': acbScoreSync,
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("${data['drugName']} is added.", style: GoogleFonts.poppins(),),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.grey[900],
                                      elevation: 30,
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20,),

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AcbScoreScreen()));
                },
                child: Container(
                  width: 160,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xff8359e3).withOpacity(0.70),
                      borderRadius: BorderRadius.circular(60)
                  ),
                  child: Center(
                    child: Text("Next", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
