import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class Authentication extends ChangeNotifier {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          Get.showSnackbar(const GetSnackBar(
            message:
                "You already have an account with this email. Use other login method.",
            duration: Duration(seconds: 3),
          ));
        } else if (e.code == 'invalid-credential') {
          Get.showSnackbar(const GetSnackBar(
            message: "Invalid Credential!",
            duration: Duration(seconds: 3),
          ));
        } else if (e.code == 'wrong-password') {
          Get.showSnackbar(const GetSnackBar(
            message: "Wrong password!",
            duration: Duration(seconds: 3),
          ));
        }
      } catch (e) {
        Get.showSnackbar(const GetSnackBar(
          message: "Unknown Error. Try again later",
          duration: Duration(seconds: 3),
        ));
      }
    }

    return user;
  }

  // signUpWithEmail(String text, String text2, String text3) {}
}
