import 'package:flutter/material.dart';
import 'package:xerobuddy_app/screens/authentication/login_or_register.dart';
import 'package:xerobuddy_app/screens/authentication/registeration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xerobuddy_app/screens/dashboard.dart';
import 'package:xerobuddy_app/screens/oneTime_pages/oneTimePageVisit.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return OneTimePageVisit();
          } else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
