import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:xerobuddy_app/model/advanced_diagnostics_redirection_model.dart';

import '../../model/bottomNavigationBar.dart';
import '../../util/globals.dart';

class AcbScoreScreen extends StatefulWidget {
  const AcbScoreScreen({super.key});

  @override
  State<AcbScoreScreen> createState() => _AcbScoreScreenState();
}

class _AcbScoreScreenState extends State<AcbScoreScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  _getAcbDataEarly() async {
    FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).snapshots().listen((docSnapshot) {
      Map<String, dynamic> data = docSnapshot.data()!;
      setState(() {
        acbScore = data['acbScore'];
        acbScoreSync = data['acbScoreSync'];
      });
    });

    print("=======================");
    print("Acb Score : ${acbScore}");
    print("=======================");
    print("Acb Score Sync : ${acbScoreSync}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getAcbDataEarly();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: [
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
              image: AssetImage("assets/images/Bg2.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 65,),
              Text("ACB Risk Score", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 28),),
              const SizedBox(height: 25,),

              Container(
                color: Colors.transparent,
                height: 200,
                child: SfRadialGauge(
                  backgroundColor: Colors.transparent,
                  axes: <RadialAxis>[
                    RadialAxis(
                        showAxisLine: false,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 180,
                        endAngle: 360,
                        maximum: 120,
                        canScaleToFit: true,
                        radiusFactor: 0.79,
                        pointers: <GaugePointer>[
                          NeedlePointer(
                              needleEndWidth: 5,
                              needleLength: 0.8,
                              value: acbScoreSync,
                              knobStyle: const KnobStyle(knobRadius: 0.055, color: Color(0xff8359e3))),
                        ],
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0,
                              endValue: 20,
                              startWidth: 0.32,
                              endWidth: 0.32,
                              sizeUnit: GaugeSizeUnit.factor,
                              color: const Color(0xFF8BE724)),
                          GaugeRange(
                              startValue: 20,
                              endValue: 40,
                              startWidth: 0.32,
                              sizeUnit: GaugeSizeUnit.factor,
                              endWidth: 0.32,
                              color: const Color(0xFFFFD314)),
                          GaugeRange(
                              startValue: 40,
                              endValue: 60,
                              startWidth: 0.32,
                              sizeUnit: GaugeSizeUnit.factor,
                              endWidth: 0.32,
                              color: const Color(0xFFFF8000)),
                          GaugeRange(
                              startValue: 60,
                              endValue: 80,
                              startWidth: 0.32,
                              sizeUnit: GaugeSizeUnit.factor,
                              endWidth: 0.32,
                              color: const Color(0xFFFF8000)),
                          GaugeRange(
                              startValue: 80,
                              endValue: 100,
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: 0.32,
                              endWidth: 0.32,
                              color: const Color(0xFFFF0000)),
                          GaugeRange(
                              startValue: 100,
                              endValue: 120,
                              startWidth: 0.32,
                              endWidth: 0.32,
                              sizeUnit: GaugeSizeUnit.factor,
                              color: const Color(0xFFFF0000)),
                        ]),
                    RadialAxis(
                      showAxisLine: false,
                      showLabels: false,
                      showTicks: false,
                      startAngle: 180,
                      endAngle: 360,
                      maximum: 120,
                      radiusFactor: 0.80,
                      canScaleToFit: true,
                      pointers: const <GaugePointer>[
                        MarkerPointer(
                            markerType: MarkerType.text,
                            text: 'Low',
                            value: 30,
                            textStyle: GaugeTextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'Times'),
                            offsetUnit: GaugeSizeUnit.factor,
                            markerOffset: -0.12),
                        MarkerPointer(
                            markerType: MarkerType.text,
                            text: 'Medium',
                            value: 60,
                            textStyle: GaugeTextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'Times'),
                            offsetUnit: GaugeSizeUnit.factor,
                            markerOffset: -0.12),
                        MarkerPointer(
                            markerType: MarkerType.text,
                            text: 'Bad',
                            value: 100,
                            textStyle: GaugeTextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'Times'),
                            offsetUnit: GaugeSizeUnit.factor,
                            markerOffset: -0.12)
                      ],
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 25,),

              Container(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text("ACB Score : ${acbScore}", style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 20,),


              // Drugs List
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).collection("drugsRecommended").snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if(snapshot.data == null){
                    return Text("No Drugs Found", style: GoogleFonts.inika(color: const Color(0xff161416)),);
                  }

                  // Get drug lists
                  final drugLists = snapshot.data!.docs;

                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: drugLists.length,
                      itemBuilder: (context, index) {
                        // Get single drugs
                        final drug = drugLists[index];

                        return Card(
                          color: const Color(0xffbba7e8).withOpacity(0.8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 20, bottom: 5, top: 5, right: 10),
                            title: Text("${drug['drugName']}", style: GoogleFonts.poppins(color: Colors.black54, fontWeight: FontWeight.bold),),
                            subtitle: Text('ACB Score : ${drug['acbScore']}', style: GoogleFonts.poppins(color: Colors.black38),),
                            trailing: IconButton(
                              iconSize: 40.0,
                              icon: const Icon(Icons.delete_forever_rounded),
                              color: const Color(0xff8359e3),
                              onPressed: () async {
                                var docSnapshot = await FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).get();
                                Map<String, dynamic> data = docSnapshot.data()!;
                                setState(() {
                                  acbScore = data['acbScore'] - snapshot.data!.docs[index]['acbScore'];
                                  acbScoreSync = data['acbScoreSync'];
                                });

                                // Syncfusion Value
                                if(acbScore <= 0){
                                  acbScore = 0;
                                  acbScoreSync = 10;
                                } else if(acbScore == 1) {
                                  acbScoreSync = acbScore * 30;
                                } else if(acbScore == 2) {
                                  acbScoreSync = acbScore * 30;
                                } else if(acbScore == 3 || acbScore >=3) {
                                  acbScore = 3;
                                  acbScoreSync = acbScore * 33.45;
                                }

                                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).update({
                                  'acbScore': acbScore,
                                  'acbScoreSync': acbScoreSync,
                                });

                                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).collection("drugsRecommended").doc(snapshot.data!.docs[index].reference.id).delete();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${drug['drugName']} is deleted.", style: GoogleFonts.poppins(),),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.grey[900],
                                    elevation: 30,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20,),

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ADR_Model()));
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
