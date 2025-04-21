import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../login_page.dart';
import '../quiz_page.dart';


class AuthService {

  Future<void> signup({
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
      
    } on FirebaseAuthException catch(e) {
      String message;

      print('🔥 SIGN-UP ERROR: ${e.code} - ${e.message}');

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      }
      else if (e.code == 'invalid-email') {
      message = 'The email address is not valid.';
      } 
      else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      else{
        message = 'An error has occured. Please try again';
      }
      //This will display the error message at the bottom of the screen in a black box white text.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
    }

  }

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
          MaterialPageRoute(builder: (_) => const QuizPage()),
        );
      }
    });
      
    } on FirebaseAuthException catch(e) {
      String message;

      print('🔥 SIGN-IN ERROR: ${e.code} - ${e.message}');

      if (e.code == 'invalid-credential') {
      message = 'Incorrect password. Try again';
    } else if (e.code == 'invalid-email') {
      message = 'The email address is not valid.';
    } else {
      // For any other errors, uses a general message
      message = 'An unexpected error occurred. Please try again later.';
    }

    //This will display the error message at the bottom of the screen in a black box white text.
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));

      //Outdated: Due to platforming issues. Kept: Incase we switch back
      /*
       Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );*/
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