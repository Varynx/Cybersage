import 'package:flutter/material.dart';
import 'login_page.dart';
import 'quiz_page.dart'; 
import 'signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
     
    // Initialize Firebase
    options: DefaultFirebaseOptions.currentPlatform,);
    
    //Runs app
    runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  //  Root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme(
          primary: const Color(0xFF006B53),      // FGCU Green
          onPrimary: Colors.white,
          secondary: const Color(0xFF00287A),    // FGCU Blue
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black87,
          error: Colors.red.shade700,       
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        
        // ENHANCED TEXT THEME FOR ELDERLY READABILITY
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black87),
          displayMedium: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.black87),
          displaySmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
          headlineMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black87),
          bodyLarge: TextStyle(fontSize: 20.0, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 18.0, color: Colors.black87),
        ),
        
        // INCREASED BUTTON SIZE FOR BETTER ACCESSIBILITY
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(fontSize: 18),
            minimumSize: const Size(100, 50),
          ),
        ),
        
        // INCREASED INPUT FIELD SIZE FOR BETTER ACCESSIBILITY
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: 2.0),
          ),
          labelStyle: const TextStyle(fontSize: 18.0),
          hintStyle: const TextStyle(fontSize: 18.0),
          errorStyle: const TextStyle(fontSize: 16.0, color: Colors.red),
        ),
      ),
      
      // REPLACED 'home' PROPERTY WITH ROUTES
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/quiz': (context) => const QuizPage(),
        '/signup': (context) => Signup(),
      },
    );
  }
}