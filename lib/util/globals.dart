library globals;

import 'package:flutter/cupertino.dart';

PageController pageController = PageController();

// User Detail
var userCountry = '';
var userProfession = '';

// Patient Detail
final TextEditingController newDocumentName = TextEditingController();
String reportName = '';
var patientGender = '';
int patientAge = 0;
double xerostomia = 0.0;
int countOfDrugs = 0;
double usfr = 0.0;
double schirmer = 0.0;
var creationDate = "";

// Xerostomia Questions
List<String> xQuestions = [
  "My mouth feels dry when eating a meal",
  "My mouth feels dry",
  "I have difficulty in eating dry foods",
  "I have difficulties swallowing certain foods",
  "My lips feel dry",
];

// Report data
int acbScore = 0;
double acbScoreSync = 0.0;
List drugsRecommended = [];
var distinctDrugList;

// Bottom Navigation Bar
int myCurrentIndex = 0;

// Medicine Products
String medicineName = '';
String medicineDescription = '';