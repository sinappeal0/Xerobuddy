import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:xerobuddy_app/screens/medical_products.dart';
import 'package:xerobuddy_app/screens/profession_group/professional_dashboard.dart';
import 'package:xerobuddy_app/screens/saliva_facts.dart';
import 'package:xerobuddy_app/screens/settings.dart';
import 'package:xerobuddy_app/util/globals.dart';

class XBottomNavigationBar extends StatefulWidget {
  const XBottomNavigationBar({super.key});

  @override
  State<XBottomNavigationBar> createState() => _XBottomNavigationBarState();
}

class _XBottomNavigationBarState extends State<XBottomNavigationBar> {
  static const List<Widget> navPages = <Widget>[
    ProfessionalDashboard(),
    MedicalProducts(),
    SalivaFacts(),
    Settings(),
  ];

  void _tabChanged(int index) {
    myCurrentIndex = 0;
    setState(() {
      myCurrentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white,),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: GNav(
            gap: 5,
            color: Colors.black54,
            activeColor: Colors.black54,
            rippleColor: const Color(0xffbba7e8),
            hoverColor: const Color(0xffbba7e8),
            iconSize: 20,
            textStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500),
            tabBackgroundColor: const Color(0xffbba7e8).withOpacity(0.85),
            tabBorderRadius: 20,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.5),
            duration: const Duration(milliseconds: 600),
            tabs: const [
              GButton(
                icon: Icons.home_filled,
                text: 'Home',
              ),
              GButton(
                icon: Icons.medical_services_rounded,
                text: 'Products',
              ),
              GButton(
                icon: Icons.lightbulb,
                text: 'Saliva Facts',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
            selectedIndex: myCurrentIndex,
            onTabChange: _tabChanged,
          ),
        ),
      ),
      body: navPages.elementAt(myCurrentIndex),
    );
  }
}
