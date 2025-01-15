import 'package:flutter/material.dart';
import 'package:xerobuddy_app/screens/oneTime_pages/collectUserData/add_age.dart';
import 'package:xerobuddy_app/screens/oneTime_pages/collectUserData/add_country.dart';
import 'package:xerobuddy_app/screens/oneTime_pages/collectUserData/add_nickname.dart';
import 'package:xerobuddy_app/screens/oneTime_pages/collectUserData/add_professional_group.dart';
// import 'package:xerobuddy_app/screens/oneTime_pages/collectUserData/user_group_selection.dart';
import 'package:xerobuddy_app/screens/oneTime_pages/intro_page1.dart';
import 'package:xerobuddy_app/screens/oneTime_pages/intro_page2.dart';
import 'package:xerobuddy_app/screens/oneTime_pages/intro_page3.dart';

import '../../util/globals.dart';


class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
            AddNickname(),
            AddAge(),
            AddCountry(),
            AddProfessionalGroup(),
          ],
        ),
      ]
    );
  }
}
