import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthRegService {
  // Google sign in
  signUpWithGoogle() async {
    // Begin interactive sign in process
    GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Obtain auth details from request
    GoogleSignInAuthentication? gAuth = await gUser!.authentication;

    // Create a new credential for user
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Finally, sign in
    return dbGoogleUser(credential);
  }

  // Database creation
  dbGoogleUser(AuthCredential credential) async {
    try{
      final User? user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      var email = user!.providerData[0].email;

      FirebaseFirestore.instance.collection("users").doc(email).set({
        "email": email,
        "username": email!.split("@").first,
        "first_visit": true,
      });
    } on FirebaseAuthException catch(e) {

    }
  }
}