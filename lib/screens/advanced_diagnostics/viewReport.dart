import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/reportData/reportPreview.dart';

import '../../model/bottomNavigationBar.dart';
import '../../util/globals.dart';

class ViewReport extends StatefulWidget {
  const ViewReport({super.key});

  @override
  State<ViewReport> createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  TextEditingController patientEmailController = TextEditingController();

  getAllData () {
    FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).snapshots().listen((docSnapshot) {
      Map<String, dynamic> data = docSnapshot.data()!;
      setState(() {
        acbScore = data['acbScore'];
        acbScoreSync = data['acbScoreSync'];
        countOfDrugs = int.parse(data['number_of_drugs']);
        patientGender = data['patientGender'];
        patientAge = int.parse(data['patientAge']);
        schirmer = data['schirmer'];
        usfr = data['usfr'];
        creationDate = data['creationDate'];
      });
    });
  }

  //the list where you have all the data
  List viewReportDrugList = [];

  getDrugsRecommended () async {
    await FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(reportName).collection("drugsRecommended").get().then((value) {
      for(var i in value.docs) {
        viewReportDrugList.add(i.data());
        drugsRecommended.add(i.data());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDrugsRecommended();
      getAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: [
          // Discard report button
          TextButton(
            onPressed: () {
              try {
                // Delete the report from professional and patient side
                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(reportName).delete();

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
            child: Text("Delete", style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 16),),
          ),
          TextButton(
            onPressed: () {
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
                        height: 280,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Send Report", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 24, color: const Color(0xff8359e3)),),
                              Text("Please enter the email of patient to send report to that specific patient.", style: GoogleFonts.poppins(color: Colors.black54),),
                              const SizedBox(height: 20,),
                              SizedBox(
                                child: TextField(
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: patientEmailController,
                                  // autofocus: true,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffbba7e8).withOpacity(0.85),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Patient Email",
                                      hintStyle: GoogleFonts.poppins(color: Colors.black54),
                                      prefixIcon: const Icon(Icons.file_copy_rounded, color: Colors.black54,)
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff8359e3).withOpacity(0.70),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      fixedSize: const Size(double.infinity, 50)
                                  ),
                                  onPressed: () async {
                                    var now = DateTime.now();
                                    var dateTime = DateFormat('MMMM dd, yyyy').format(now);

                                    try {
                                      // Creating reports for patients side
                                      FirebaseFirestore.instance.collection("users").doc(patientEmailController.text).collection("reports").doc(reportName).set({
                                        'patientEmail': patientEmailController.text,
                                        'creationDate': dateTime,
                                        'patientAge': patientAge,
                                        'patientGender': patientGender,
                                        'number_of_drugs': countOfDrugs,
                                        'xerostomia': xerostomia,
                                        'acbScore': acbScore,
                                        'acbScoreSync': acbScoreSync,
                                        'schirmer': schirmer,
                                        'usfr': usfr,
                                      });

                                      // Getting recommended drugs details from doctor
                                      FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(reportName).collection("drugsRecommended").get().then((QuerySnapshot snapshot) {
                                        snapshot.docs.forEach((DocumentSnapshot doc) {
                                          var item = doc.data() as Map<String, dynamic>;
                                          try {
                                            FirebaseFirestore.instance.collection("users").doc(patientEmailController.text).collection("reports").doc(reportName).collection("drugsRecommended").doc(doc.id).set(item);
                                          } on FirebaseException catch (e) {
                                            print("=============================================\n\n");
                                            print(e.code);
                                            print("\n\n=============================================");
                                          }
                                        });
                                      });

                                      // Getting recommended xerostomia questions from doctor
                                      FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(reportName).collection("xerostomia_questions").get().then((QuerySnapshot snapshot) {
                                        snapshot.docs.forEach((DocumentSnapshot doc) {
                                          var item = doc.data() as Map<String, dynamic>;
                                          try {
                                            FirebaseFirestore.instance.collection("users").doc(patientEmailController.text).collection("reports").doc(reportName).collection("xerostomia_questions").doc(doc.id).set(item);
                                          } on FirebaseException catch (e) {
                                            print("=============================================\n\n");
                                            print(e.code);
                                            print("\n\n=============================================");
                                          }
                                        });
                                      });

                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Report sent to the patient.", style: GoogleFonts.poppins(),),
                                            behavior: SnackBarBehavior.floating,
                                            // backgroundColor: Color(0xff0000000).withOpacity(0.4),
                                            backgroundColor: Colors.grey[900],
                                            elevation: 30,
                                          )
                                      );

                                      Navigator.pop(context);
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
                                  child: Text('Send Report', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),),
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
            child: Text("Send Report", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(currentUser!.email).collection("reports").doc(reportName).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            final reportData = snapshot.data!.data() as Map<String, dynamic>;

            return Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Bg2.png"),
                    fit: BoxFit.cover,
                  )
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100,),

                    SizedBox(
                      height: 180,
                      child: Image.asset("assets/images/green light 1.png"),
                    ),
                    const SizedBox(height: 40,),

                    Text("Low Risk", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 28), textAlign: TextAlign.center,),
                    const SizedBox(height: 20,),

                    Text("Explanation...", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 14), textAlign: TextAlign.center,),
                    Text("Summary", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 24), textAlign: TextAlign.center,),
                    const SizedBox(height: 40,),

                    // Xerostomia
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                          color: (xerostomia <= 4.0) ? const Color(0xff70e800) : ((xerostomia >= 4.0) && (xerostomia <= 6.0)) ? Colors.yellow : Colors.red,
                          borderRadius: BorderRadius.circular(60.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Xerostomia", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                          Text("${reportData['xerostomia'].toStringAsFixed(1)}", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),

                    // Acb Score
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                          color: (reportData['acbScore'] == 0) ? const Color(0xff70e800) : ((reportData['acbScore'] == 1) || (reportData['acbScore'] == 2)) ? Colors.yellow : Colors.red,
                          borderRadius: BorderRadius.circular(60.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Acb Score", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                          Text("${reportData['acbScore']}", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),

                    // USFR
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                          color: (usfr >= 0.25) ? const Color(0xff70e800) : ((usfr <= 0.25) || (usfr >= 0.1)) ? Colors.yellow : Colors.red,
                          borderRadius: BorderRadius.circular(60.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("USFR", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                          Text("${reportData['usfr']} ml/5min", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),

                    // Schirmer
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                          color: (reportData['schirmer'] >= 1.0) ? const Color(0xff70e800) : ((reportData['schirmer'] >= 0.5) && (reportData['schirmer'] <= 1.0)) ? Colors.yellow : Colors.red,
                          borderRadius: BorderRadius.circular(60.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("SFR", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                          Text("${reportData['schirmer']} ml/5min", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40,),

                    // Patient Data
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Gender", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                              Text("${reportData['patientGender']}", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          const Divider(
                            thickness: 0.9,
                          ),
                          const SizedBox(height: 4,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Age", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                              Text("${reportData['patientAge']}", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          const Divider(
                            thickness: 0.9,
                          ),
                          const SizedBox(height: 4,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Number of Drugs", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                              Text("${reportData['number_of_drugs']}", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black, decoration: TextDecoration.none),),
                            ],
                          ),
                          const SizedBox(height: 8,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40,),

                    // Drug Lists
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Drugs Recommended", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black54),),
                      ),
                    ),
                    const SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: viewReportDrugList.length,
                        itemBuilder: (context, index) {
                          // Get single summary drugs
                          final drug = viewReportDrugList[index];

                          return Card(
                            color: const Color(0xffbba7e8).withOpacity(0.8),
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(left: 20, bottom: 5, top: 5, right: 10),
                              title: Text("${drug['drugName']}", style: GoogleFonts.poppins(color: Colors.black54, fontWeight: FontWeight.bold),),
                              subtitle: Text('ACB Score : ${drug['acbScore']}', style: GoogleFonts.poppins(color: Colors.black38),),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff8359e3).withOpacity(0.70),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                fixedSize: const Size(150, 50)
                            ),
                            onPressed: () async {
                              try {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportPreview()));
                              } on FirebaseException catch(e) {
                                print("=============================");
                                print("Error Occurred");
                                print("=============================");
                              }
                            },
                            icon: Image.asset("assets/images/summary.png", height: 30,),
                            label: Text("Print", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff8359e3).withOpacity(0.70),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                fixedSize: const Size(150, 50)
                            ),
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => MediumRiskScreen()));
                            },
                            child: Text("ToDo's", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40,),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff8359e3).withOpacity(0.70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          fixedSize: const Size(180, 50)
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const XBottomNavigationBar()));
                      },
                      child: Text("Back to Home", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
                    ),
                    const SizedBox(height: 60,),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error + ${snapshot.error}"),
            );
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
