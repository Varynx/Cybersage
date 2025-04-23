import 'package:flutter/material.dart';
import '../auth_service.dart';  // Ensure AuthService is imported

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to CyberSage'),
        backgroundColor: cs.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome to CyberSage, the Cybersecurity Quiz Platform!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Start Quiz Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/quiz');  // Navigate to the quiz page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Start Quiz'),
            ),

            const SizedBox(height: 20),

            // Results Button (if you want to direct users to the results page)
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/results');  // Navigate to the results page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.secondary,
                foregroundColor: cs.onSecondary,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('View Results'),
            ),

            const SizedBox(height: 20),

            // Sign-Out Button
            ElevatedButton(
              onPressed: () {
                // Call the signOut method from AuthService
                AuthService().signout(context: context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.error,
                foregroundColor: cs.onError,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
