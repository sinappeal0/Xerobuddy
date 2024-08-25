import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/globals.dart';

class AddCountry extends StatefulWidget {
  const AddCountry({super.key});

  @override
  State<AddCountry> createState() => _AddCountryState();
}

class _AddCountryState extends State<AddCountry> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  final TextEditingController addCountryController = TextEditingController();

  bool showCountry = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            pageController.previousPage(duration: const Duration(milliseconds: 50), curve: Curves.easeIn);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24,),
        ),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                    style: GoogleFonts.poppins(fontSize: 23, color: Colors.white),
                    children: <TextSpan>[
                      const TextSpan(text: "In which "),
                      TextSpan(text: "country", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      const TextSpan(text: " do you live?"),
                    ]
                ),
              ),
              const SizedBox(height: 20,),

              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    onSelect: (Country country) {
                      showCountry = true;

                      print("Country name is : ${country.flagEmoji}");
                      setState(() {
                        userCountry = country.displayName.split(" ")[0];
                      });
                    },
                    countryListTheme: CountryListThemeData(
                      textStyle: GoogleFonts.poppins(color: Colors.black54),
                      borderRadius: BorderRadius.circular(30),
                      backgroundColor: Colors.white.withOpacity(0.9),
                      bottomSheetHeight: 490,
                      inputDecoration: InputDecoration(
                        labelText: "Search",
                        labelStyle: GoogleFonts.poppins(color: const Color(0xff8359E3).withOpacity(0.6)),
                        hintText: "Start typing to search",
                        prefixIcon: const Icon(Icons.search, color: Colors.black54,),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide(
                              color: Color(0xffbba7e8),
                              width: 2
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide(
                            color: Color(0xffbba7e8),
                          ),
                        ),
                      ),
                      searchTextStyle: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    )
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xffbba7e8).withOpacity(0.85),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ShowCountry(showCountry: showCountry,),
                ),
              ),
              const SizedBox(height: 200,),

              GestureDetector(
                onTap: () {
                  pageController.nextPage(duration: const Duration(milliseconds: 50), curve: Curves.easeIn);

                  try {
                    // Updating the first visit value to false and adding other user data collected for the only single time.
                    FirebaseFirestore.instance.collection("users").doc(currentUser!.email).update({
                      "userCountry": userCountry,
                    });

                    // Showing user that nickname is added and status updated
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Country is updated.", style: GoogleFonts.poppins(),),
                          behavior: SnackBarBehavior.floating,
                          // backgroundColor: Color(0xff0000000).withOpacity(0.4),
                          backgroundColor: Colors.grey[900],
                          elevation: 30,
                        )
                    );

                  } on FirebaseException catch (e) {
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
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xff8359e3).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text('Next', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowCountry extends StatelessWidget {
  ShowCountry({super.key, required this.showCountry});
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  final bool showCountry;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if(showCountry) Text("${userCountry}", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),)
        else Text("Select Country", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),), const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white,),
      ],
    );
  }
}
