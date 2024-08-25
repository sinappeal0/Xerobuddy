import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:xerobuddy_app/screens/advanced_diagnostics/viewReport.dart';
import 'package:xerobuddy_app/screens/salivary_assessment_screens/salivary_assessment.dart';

import '../../util/globals.dart';

class ProfessionalDashboard extends StatefulWidget {
  const ProfessionalDashboard({super.key});

  @override
  State<ProfessionalDashboard> createState() => _ProfessionalDashboardState();
}

class _ProfessionalDashboardState extends State<ProfessionalDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final User? currentUser = FirebaseAuth.instance.currentUser!;

  // Hide System Buttons & Change Status Bar Color Method
  void _hideSystemButton() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  }

  void _tabChanged(int index) {
    myCurrentIndex = 0;
    setState(() {
      myCurrentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hideSystemButton();
  }

  var searchReportName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   actions: [
      //     // Logout Button
      //     IconButton(
      //       onPressed: () {
      //         try{
      //           FirebaseAuth.instance.signOut().then((value){
      //             GoogleSignIn().disconnect();
      //           });
      //
      //           ScaffoldMessenger.of(context).showSnackBar(
      //               SnackBar(
      //                 content: Text("Logged out successfully.", style: GoogleFonts.poppins(),),
      //                 behavior: SnackBarBehavior.floating,
      //                 backgroundColor: Colors.grey[900],
      //                 elevation: 30,
      //               )
      //           );
      //         } on FirebaseException catch(e) {
      //           ScaffoldMessenger.of(context).showSnackBar(
      //               SnackBar(
      //                 content: Text("Error occurred : ${e.code}", style: GoogleFonts.poppins(),),
      //                 behavior: SnackBarBehavior.floating,
      //                 // backgroundColor: Color(0xff0000000).withOpacity(0.4),
      //                 backgroundColor: Colors.grey[900],
      //                 elevation: 30,
      //               )
      //           );
      //         }
      //       },
      //       icon: const Icon(Icons.logout_rounded),)
      //   ],
      // ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      //   child: GNav(
      //     gap: 5,
      //     color: Colors.black54,
      //     activeColor: Colors.black54,
      //     rippleColor: const Color(0xffbba7e8),
      //     hoverColor: const Color(0xffbba7e8),
      //     iconSize: 20,
      //     textStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500),
      //     tabBackgroundColor: const Color(0xffbba7e8).withOpacity(0.85),
      //     tabBorderRadius: 20,
      //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.5),
      //     duration: const Duration(milliseconds: 600),
      //     tabs: const [
      //       GButton(
      //         icon: Icons.home_filled,
      //         text: 'Home',
      //       ),
      //       GButton(
      //         icon: Icons.medical_services_rounded,
      //         text: 'Products',
      //       ),
      //       GButton(
      //         icon: Icons.lightbulb,
      //         text: 'Saliva Facts',
      //       ),
      //       GButton(
      //         icon: Icons.settings,
      //         text: 'Settings',
      //       ),
      //     ],
      //     selectedIndex: myCurrentIndex,
      //     onTabChange: _tabChanged,
      //   ),
      // ),
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
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").doc(currentUser!.email).snapshots(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                final userProfile = snapshot.data!.data() as Map<String, dynamic>;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 75,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/water_drop.png", height: 60,),
                        const SizedBox(width: 20,),
                        RichText(
                          text: TextSpan(
                              style: GoogleFonts.poppins(fontSize: 24, color: Colors.white),
                              children: <TextSpan>[
                                TextSpan(text: "Hello ", style: GoogleFonts.poppins()),
                                TextSpan(text: "${userProfile['userNickname']}", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                              ]
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                      height: 300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("New Salivary Assessment", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 24, color: const Color(0xff8359e3)),),
                                            Text("Please enter the name for report to show that to that specific patient.", style: GoogleFonts.poppins(color: Colors.black54),),
                                            const SizedBox(height: 20,),
                                            SizedBox(
                                              child: TextField(
                                                textInputAction: TextInputAction.done,
                                                keyboardType: TextInputType.emailAddress,
                                                controller: newDocumentName,
                                                // autofocus: true,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: const Color(0xffbba7e8).withOpacity(0.85),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(30),
                                                      borderSide: BorderSide.none,
                                                    ),
                                                    hintText: "Report Name",
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
                                                    // Creating reports for professionals side
                                                    FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(newDocumentName.text).set({
                                                      'patientEmail': newDocumentName.text,
                                                      'creationDate': dateTime,
                                                      'patientAge': 0,
                                                      'patientGender': "",
                                                      'number_of_drugs': 0,
                                                      'xerostomia': 0.0,
                                                      'acbScore': 0,
                                                      'acbScoreSync': 0.0,
                                                      'schirmer': 0,
                                                      'usfr': 0.0,
                                                    });

                                                    // Creating reports for patients side
                                                    FirebaseFirestore.instance.collection("users").doc(newDocumentName.text).collection("reports").doc(newDocumentName.text).set({
                                                      'patientEmail': newDocumentName.text,
                                                      'creationDate': dateTime,
                                                      'patientAge': 0,
                                                      'patientGender': "",
                                                      'number_of_drugs': 0,
                                                      'xerostomia': 0.0,
                                                      'acbScore': 0,
                                                      'acbScoreSync': 0.0,
                                                      'schirmer': 0,
                                                      'usfr': 0.0,
                                                    });

                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text("Successfully created the report.", style: GoogleFonts.poppins(),),
                                                          behavior: SnackBarBehavior.floating,
                                                          // backgroundColor: Color(0xff0000000).withOpacity(0.4),
                                                          backgroundColor: Colors.grey[900],
                                                          elevation: 30,
                                                        )
                                                    );

                                                    Navigator.pop(context);
                                                    // Redirect to the Salivary Assessment page
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SalivaryAssessment()));
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
                                                child: Text('Create Report', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),),
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
                            width: 270,
                            height: 100,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/water_drop.png", height: 60,),
                                const SizedBox(width: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Start Salivary', style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
                                    Text('Assessment', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54),),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          height: 100,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xff7f49ff).withOpacity(0.2),
                              width: 3,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),

                    // Previously created reports
                    Container(
                      width: 350,
                      height: 460,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
                        child: Column(
                          children: [
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Text('Previous Salivary Assessment', style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),),
                            // ),
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Previous', style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),),
                                Text('Salivary Assessment', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            // Search Area
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 240,
                                  child: TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        searchReportName = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xffbba7e8).withOpacity(0.85),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: "Search here...",
                                        hintStyle: GoogleFonts.poppins(color: Colors.white60),
                                        prefixIcon: const Icon(Icons.search, color: Colors.white60,)
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1000),
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: Stack(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 375),
                                              padding: const EdgeInsets.all(16),
                                              height: 130,
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
                                                      Row(
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                            },
                                                            child: Text("Dismiss", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              try{
                                                                // Deleting the report from professional side
                                                                FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").get().then((snapshot) {
                                                                  for (DocumentSnapshot ds in snapshot.docs){
                                                                    ds.reference.delete();
                                                                  };
                                                                });

                                                                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                    SnackBar(
                                                                      content: Text("All Reports are successfully deleted.", style: GoogleFonts.poppins(),),
                                                                      behavior: SnackBarBehavior.floating,
                                                                      backgroundColor: Colors.grey[900],
                                                                      elevation: 30,
                                                                    )
                                                                );
                                                              } on FirebaseException catch(e) {
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                    SnackBar(
                                                                      content: Text("Error Occurred.", style: GoogleFonts.poppins(),),
                                                                      behavior: SnackBarBehavior.floating,
                                                                      backgroundColor: Colors.grey[900],
                                                                      elevation: 30,
                                                                    )
                                                                );
                                                              }
                                                            },
                                                            child: Text("Delete All", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffbba7e8).withOpacity(0.85),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const Icon(Icons.delete_forever_rounded, color: Colors.black54,),
                                  ),
                                ),
                              ],
                            ),
                            // Search Area

                            Divider(
                              thickness: 2,
                              endIndent: 10,
                              indent: 10,
                              height: 30,
                              color: const Color(0xff8359E3).withOpacity(0.75),
                            ),

                            // Document Lists
                            SizedBox(
                              height: 290,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").orderBy('patientEmail').startAt([searchReportName]).endAt([searchReportName + "\uf8ff"]).snapshots(),
                                builder: (context, snapshots){
                                  return (snapshots.connectionState == ConnectionState.waiting)
                                      ? const Center(
                                    child: Text("No reports found"),
                                  ) : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: snapshots.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var data = snapshots.data!.docs[index].data() as Map<String, dynamic>;

                                      if(data.isEmpty) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: const Color(0xffbba7e8).withOpacity(0.85),
                                          ),
                                          child: Text("No reports found", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),),
                                        );
                                      }

                                      // if(data.isEmpty){
                                      //   return Container(
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.circular(20),
                                      //       color: const Color(0xffbba7e8).withOpacity(0.85),
                                      //     ),
                                      //     child: ListTile(
                                      //       leading: const Icon(Icons.file_copy_sharp, color: Colors.black54,),
                                      //       title: Text(data['patientEmail'], style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54),),
                                      //       subtitle: Text(data['creationDate'], style: GoogleFonts.poppins(fontSize: 12),),
                                      //       trailing: IconButton(
                                      //         onPressed: () {},
                                      //         icon: const Icon(Icons.remove_red_eye, color: Colors.black54,),
                                      //       ),
                                      //     ),
                                      //   );
                                      // }

                                      // if(data['patientEmail'].toString().toLowerCase().startsWith(data['patientEmail'].toLowerCase())) {
                                      //   return Slidable(
                                      //     endActionPane: ActionPane(
                                      //       motion: const BehindMotion(),
                                      //       children: [
                                      //         SlidableAction(
                                      //           backgroundColor: const Color(0xffbba7e8).withOpacity(0.8),
                                      //           foregroundColor: Colors.red.shade700,
                                      //           icon: Icons.delete_forever,
                                      //           borderRadius: BorderRadius.circular(16),
                                      //           onPressed: (BuildContext context) {
                                      //             try{
                                      //               // Deleting the report from professional side
                                      //               FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(data['patientEmail']).delete();
                                      //
                                      //               ScaffoldMessenger.of(context).showSnackBar(
                                      //                   SnackBar(
                                      //                     content: Text("Report successfully deleted.", style: GoogleFonts.poppins(),),
                                      //                     behavior: SnackBarBehavior.floating,
                                      //                     backgroundColor: Colors.grey[900],
                                      //                     elevation: 30,
                                      //                   )
                                      //               );
                                      //             } on FirebaseException catch(e) {
                                      //               ScaffoldMessenger.of(context).showSnackBar(
                                      //                   SnackBar(
                                      //                     content: Text("Error Occurred.", style: GoogleFonts.poppins(),),
                                      //                     behavior: SnackBarBehavior.floating,
                                      //                     backgroundColor: Colors.grey[900],
                                      //                     elevation: 30,
                                      //                   )
                                      //               );
                                      //             }
                                      //           },
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     child: Container(
                                      //       margin: const EdgeInsets.only(bottom: 5),
                                      //       decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(16),
                                      //         color: const Color(0xffbba7e8).withOpacity(0.85),
                                      //       ),
                                      //       child: ListTile(
                                      //         leading: const Icon(Icons.file_copy_sharp, color: Colors.black54,),
                                      //         title: Text("${data['patientEmail']}".split("@").first, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),),
                                      //         subtitle: Text(data['creationDate'], style: GoogleFonts.poppins(fontSize: 12),),
                                      //         trailing: GestureDetector(
                                      //           onTap: () {},
                                      //           child: const Icon(Icons.remove_red_eye, color: Colors.black54,),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   );
                                      // }

                                      if(data['patientEmail'].toString().toLowerCase().startsWith(data['patientEmail'].toLowerCase())) {
                                        return Container(
                                          margin: const EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: const Color(0xffbba7e8).withOpacity(0.85),
                                          ),
                                          child: ListTile(
                                            leading: const Icon(Icons.file_copy_sharp, color: Colors.black54,),
                                            title: Text("${data['patientEmail']}".split("@").first, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),),
                                            subtitle: Text(data['creationDate'], style: GoogleFonts.poppins(fontSize: 12),),
                                            trailing: GestureDetector(
                                              onTap: () {
                                                try{
                                                  // Deleting the report from professional side
                                                  FirebaseFirestore.instance.collection("users").doc(currentUser!.email).collection("reports").doc(data['patientEmail']).delete();

                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text("Report successfully deleted.", style: GoogleFonts.poppins(),),
                                                        behavior: SnackBarBehavior.floating,
                                                        backgroundColor: Colors.grey[900],
                                                        elevation: 30,
                                                      )
                                                  );
                                                } on FirebaseException catch(e) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text("Error Occurred.", style: GoogleFonts.poppins(),),
                                                        behavior: SnackBarBehavior.floating,
                                                        backgroundColor: Colors.grey[900],
                                                        elevation: 30,
                                                      )
                                                  );
                                                }
                                              },
                                              child: const Icon(Icons.delete_forever_rounded, color: Colors.black54,),
                                            ),
                                            onTap: () {
                                              reportName = data['patientEmail'];

                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewReport()));
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                           ],
                        ),
                      ),
                    ),
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
      ),
    );
  }
}