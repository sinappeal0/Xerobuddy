import 'package:flutter/material.dart';
import 'package:xerobuddy_app/screens/authentication/login_screen.dart';
import 'package:xerobuddy_app/screens/authentication/registeration_screen.dart';
import 'package:xerobuddy_app/screens/dashboard.dart';
import 'package:xerobuddy_app/screens/oneTime_pages/oneTimePageVisit.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Initially show login page
  bool showLoginPage = true;

  // Toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    // User is logged in
    if(showLoginPage) {
      return LoginScreen(onTap: togglePages,);
    }
    // User is not logged in
    else {
      return RegisterationScreen(onTap: togglePages,);
    }
  }
}
