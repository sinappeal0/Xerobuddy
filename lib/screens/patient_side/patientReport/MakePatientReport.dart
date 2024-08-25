import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xerobuddy_app/util/globals.dart';

final User? currentUser = FirebaseAuth.instance.currentUser!;

Future<Uint8List> makePatientReport() async {
  final pdf = Document();
  final fontRegular = await PdfGoogleFonts.poppinsRegular();
  final fontSemiBold = await PdfGoogleFonts.poppinsSemiBold();
  final fontBold = await PdfGoogleFonts.poppinsBold();
  final imageLogo = MemoryImage((await rootBundle.load("assets/logo/App_Logo.png")).buffer.asUint8List());

  pdf.addPage(
      Page(
          build: (context) {
            return Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Xerobuddy Report", style: TextStyle(font: fontSemiBold, fontSize: 20,),),
                              Text("Report Name : ${newDocumentName.text}", style: TextStyle(font: fontRegular, fontSize: 14,),),
                              Text("Creation Date : $creationDate", style: TextStyle(font: fontRegular, fontSize: 14,),),
                            ]
                        ),
                        SizedBox(
                            height: 80,
                            width: 80,
                            child: Image(imageLogo)
                        ),
                      ]
                  ),
                  SizedBox(height: 10),

                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: 20),

                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Report Details", style: TextStyle(font: fontRegular, fontSize: 10,),),
                              SizedBox(height: 2),

                              Text("Number of Drugs : $countOfDrugs", style: TextStyle(font: fontRegular, fontSize: 14,),),
                              SizedBox(height: 2),

                              Text("Xerostomia : ${xerostomia.toStringAsFixed(1)}", style: TextStyle(font: fontRegular, fontSize: 14,),),
                              SizedBox(height: 2),

                              Text("Acb Score : $acbScore", style: TextStyle(font: fontRegular, fontSize: 14,),),
                              SizedBox(height: 2),
                            ]
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Patient Details", style: TextStyle(font: fontRegular, fontSize: 10,),),
                              SizedBox(height: 2),

                              Text("Patient Age : $patientAge", style: TextStyle(font: fontRegular, fontSize: 14,),),
                              SizedBox(height: 2),

                              Text("Patient Gender : $patientGender", style: TextStyle(font: fontRegular, fontSize: 14,),),
                              SizedBox(height: 2),
                            ]
                        ),
                      ]
                  ),
                  SizedBox(height: 20),

                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: 20),

                  // Table Header
                  Table(
                      border: TableBorder.all(color: PdfColors.black),
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Text("Drugs Recommended", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, font: fontSemiBold)),
                            ),
                          ],
                        ),
                      ]
                  ),
                  Table(
                      border: TableBorder.all(color: PdfColors.black),
                      children: [
                        TableRow(
                          children: [
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: Text("Drug Name")
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: Text("Acb Score")
                              ),
                            ),
                          ],
                        ),
                      ]
                  ),
                  SizedBox(height: 10),

                  // Table Content
                  Table(
                      border: TableBorder.all(color: PdfColors.black),
                      children: [
                        ...drugsRecommended.map((e) => TableRow(
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: Text("${e['drugName']}")
                                ),
                                flex: 1
                            ),
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: Text("${e['acbScore']}")
                                ),
                                flex: 1
                            ),
                          ],
                        ),)
                      ]
                  ),
                ]
            );
          }
      )
  );
  return pdf.save();
}