import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:krita/ngo/mainPage.dart';
import 'package:krita/ngo/userRole.dart';

class Auth with ChangeNotifier{
  //create a new firebase auth instance on firebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? uid;

  String? get uidReturn => uid;

  //For Google Sign-In
  Future<User?> signInWithGoogle() async {
    GoogleSignIn? googleSignIn;

    // For Android platform
    googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleSignInAccount!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    UserCredential credentials =
    await FirebaseAuth.instance.signInWithCredential(credential);

    final user = FirebaseAuth.instance.currentUser!;
    final userIdToken = await user.getIdToken();
    final userName = user.displayName;
    final userEmail = user.email;

    // Save the user information to the "users" collection in Firestore
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'name': userName,
      'email': userEmail,
      'idToken': userIdToken,
    });
    uid = credentials.user!.uid;
    print(uid);
    notifyListeners();
    return credentials.user;
  }

  Future<bool> isUserRegistered(String? uidProvider) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get()
        .then((doc) => doc.exists);
  }

  //For sign up with email and password
  Future<String?> signUpWithEmail(String name, String email, String password) async {
    try {
      //Create a new user account with the provided email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      //returns user's unique id
      String uid = userCredential.user!.uid;

      //Store the user's name and email in Cloud Firestore
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
      });

      // Return true to indicate that the sign-up was successful
      // return uid;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email';
      }
    }
  }

  //For sign in with email and password
  Future<String?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  //To sign out
  Future<void> logout() async => await FirebaseAuth.instance.signOut();

}

// class AuthenticationByEmail {
//   //create a new firebase auth instance on firebaseAuth
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//
// }