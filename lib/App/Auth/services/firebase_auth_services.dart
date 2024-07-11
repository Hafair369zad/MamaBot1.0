// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseAuthService {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
//       GlobalKey<ScaffoldMessengerState>();

//   // method agar tidak ada error di dashboard
//   User? getCurrentUser() {
//     return _auth.currentUser;
//   }

//   Future<User?> signUpWithEmailAndPassword(
//       String email, String password, String username) async {
//     try {
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);

//       // Set user's display name
//       await credential.user?.updateDisplayName(username);
//       return credential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         _showSnackbar('Alamat email sudah terdaftar');
//       } else {
//         _showSnackbar('An error occurred: ${e.code}');
//       }
//     }
//     return null;
//   }

//   Future<User?> signInWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       return credential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found' || e.code == 'wrong-password') {
//         _showSnackbar('Email atau Password salah');
//       } else {
//         _showSnackbar('An error occurred: ${e.code}');
//       }
//     }
//     return null;
//   }

//   void _showSnackbar(String message) {
//     final snackBar = SnackBar(
//       content: Text(message),
//       duration: Duration(seconds: 2),
//     );
//     scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await credential.user?.updateDisplayName(username);

      String defaultProfilePictureUrl = 'assets/default_profile.png';
      await credential.user?.updatePhotoURL(defaultProfilePictureUrl);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(credential.user!.uid)
          .set({
        'username': username,
        'email': email,
        'photoURL': defaultProfilePictureUrl,
      });

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _showSnackbar('Alamat email sudah terdaftar');
      } else {
        _showSnackbar('An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        _showSnackbar('Email atau Password salah');
      } else {
        _showSnackbar('An error occurred: ${e.code}');
      }
    }
    return null;
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
