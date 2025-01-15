import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';

import '../../model/bottomNavigationBar.dart';

class AboutXerobuddy extends StatefulWidget {
  const AboutXerobuddy({super.key});

  @override
  State<AboutXerobuddy> createState() => _AboutXerobuddyState();
}

class _AboutXerobuddyState extends State<AboutXerobuddy> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final User? currentUser = FirebaseAuth.instance.currentUser!;
  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const XBottomNavigationBar()),
              );
            },
            icon: const Icon(Icons.home, color: Colors.black54),
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Bg1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildPage(
                    title: "About",
                    description:
                    "Xerobuddy is a modern app designed to assist dentists and patients in managing xerostomia-related care effectively.",
                    assetAddress: 'assets/images/waves1.gif'
                  ),
                  _buildPage(
                    title: "Our Mission",
                    description:
                    "We aim to simplify the lives of dentists and patients through innovative tools and technology.",
                    assetAddress: 'assets/images/thoughtful.gif'
                  ),
                  _buildPage(
                    title: "Our Vision",
                    description:
                    "To become the leading platform for managing xerostomia and similar conditions efficiently.", assetAddress: 'assets/images/magnifying_glass.gif',
                  ),
                ],
              ),
            ),
            _buildPageIndicator(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({required String title, required String description, required String assetAddress}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 250, child: Image.asset(assetAddress)),

          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black54),
          ),

          const SizedBox(height: 20),
          Text(
            description,
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 160,),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            decoration: BoxDecoration(
                color: const Color(0xff8359e3).withOpacity(0.6),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform(alignment: Alignment.center, transform: Matrix4.identity()..scale(-1.0, 1.0), child: const Icon(Icons.arrow_right_alt, color: Colors.white,)),
                const SizedBox(width: 12,),
                Text("Swipe", style: GoogleFonts.poppins(fontSize: 14, fontWeight:FontWeight.w500, color: Colors.white),),
                const SizedBox(width: 12,),
                const Icon(Icons.arrow_right_alt, color: Colors.white,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3, // Number of pages
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          height: 10,
          width: _currentPage == index ? 20 : 10,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.deepPurple : Colors.deepPurple.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
