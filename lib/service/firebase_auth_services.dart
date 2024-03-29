import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;


  static Future<void> userSignOut() async {
    _auth.signOut();
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      User? user = result.user;
      return user;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  static Stream<User?> get firebaseUserStream => _auth.authStateChanges();
}