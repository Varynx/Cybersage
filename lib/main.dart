import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// App pages/screens
import 'login_page.dart';
import 'signup.dart';
import 'quiz_page.dart';
import 'lesson_page.dart';
import 'home_page.dart';
import 'result_page.dart';

void main() async {
  // Ensure widgets are bound before Firebase initializes
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with generated options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Launch the app
  runApp(const MyApp());
}

// Root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set initial route
      initialRoute: '/',

      // Define app-wide routes
      routes: {
        '/': (context) => const LoginPage(),
        '/signup': (context) => Signup(),
        '/quiz': (context) => const QuizPage(),
        '/lesson': (context) => LessonPage(),
        '/home': (context) => HomePage(),
        '/results': (context) => ResultsPage(),
      },

      // Apply custom theme with accessibility considerations
      theme: ThemeData(
        // Custom color scheme matching FGCU colors
        colorScheme: ColorScheme(
          primary: const Color(0xFF006B53), // FGCU Green
          onPrimary: Colors.white,
          secondary: const Color(0xFF00287A), // FGCU Blue
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black87,
          error: Colors.red.shade700,
          onError: Colors.white,
          brightness: Brightness.light,
        ),

        // Text styles optimized for readability (elderly-friendly)
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          displayMedium: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          displaySmall: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          headlineLarge: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          headlineMedium: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          bodyLarge: TextStyle(fontSize: 20.0, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 18.0, color: Colors.black87),
        ),

        // Larger buttons for improved touch targets
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(fontSize: 18),
            minimumSize: const Size(100, 50),
          ),
        ),

        // Enhanced input fields for better visibility and accessibility
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white, // Ensures inputs aren't transparent
          contentPadding: const EdgeInsets.all(
            16,
          ), // Padding inside input fields
          labelStyle: const TextStyle(fontSize: 18.0),
          hintStyle: const TextStyle(fontSize: 18.0),
          errorStyle: const TextStyle(fontSize: 16.0, color: Colors.red),

          // Icon visibility settings
          iconColor: Colors.black87,
          prefixIconColor: Colors.black87,
          suffixIconColor: Colors.black87,

          // Border styles for various states
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color(0xFF006B53), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
        ),
      ),
    );
  }
}
