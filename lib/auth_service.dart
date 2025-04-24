import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login_page.dart';
import '../quiz_page.dart';
import '../Lesson_page.dart';


class AuthService {

  Future<String?> signup({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    
    try {
      
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      // Optional delay before navigating
      await Future.delayed(const Duration(seconds: 1));

      // Wrap navigation in addPostFrameCallback
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        }
      });

      return null;
      
    } on FirebaseAuthException catch(e) {

      print('🔥 SIGN-UP ERROR: ${e.code} - ${e.message}');

      if (e.code == 'weak-password') {
         return 'The password provided is too weak.';
      }
      else if (e.code == 'invalid-email') {
      return 'The email address is not valid.';
      } 
      else if (e.code == 'email-already-in-use') {
        return 'An account already exists with that email.';
      }
      else if(e.code == 'network-request-failed')
      {
        return 'No internet connection. Check you connection.';
      }
      else{
       return 'An error has occured. Please try again';
      }
    }

  }

Future<String?> signin({
  required String email,
  required String password,
  required BuildContext context
}) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
    );

    await Future.delayed(const Duration(seconds: 1));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const QuizPage()),//change this later to homepage
        );
      }
    });

    return null; // no error

  } on FirebaseAuthException catch (e) {
    print('🔥 SIGN-IN ERROR: ${e.code} - ${e.message}');
    if (e.code == 'wrong-password') {
      return 'Incorrect password. Try again.';
    } else if (e.code == 'invalid-credential') {
      return 'Username or password is incorrect.';
    } else if (e.code == 'invalid-email') {
      return 'Enter a valid email address.';
    } else if (e.code == 'missing-password') {
      return 'Enter your password.';
    } else if (e.code == 'network-request-failed') {
      return 'No internet connection. Check your connection.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}

  Future<void> signout({
    required BuildContext context
  }) async {
    
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>LoginPage()
        )
      );
  }
}