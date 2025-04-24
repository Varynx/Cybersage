import 'package:flutter/material.dart';
import '../auth_service.dart'; // Import your custom authentication service

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme =
        theme
            .colorScheme; // Get the current color scheme for consistent theming

    return Scaffold(
      // AppBar at the top with a title and primary background color
      appBar: AppBar(
        title: const Text('Home Page', style: TextStyle(fontSize: 22)),
        backgroundColor: colorScheme.primary,
        foregroundColor:
            colorScheme.onPrimary, // Use primary color from colorScheme
        automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(
          24.0,
        ), // Add padding around the body content
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Vertically center the content
          crossAxisAlignment:
              CrossAxisAlignment.center, // Horizontally center the content

          children: [
            // Welcome message centered at the top
            const Text(
              'Welcome to CyberSage, the Cybersecurity Quiz Platform!',
              style: TextStyle(
                fontSize: 24, // Set the font size for the welcome message
                fontWeight: FontWeight.bold, // Make the text bold
              ),
              textAlign:
                  TextAlign.center, // Center the text within the container
            ),

            const SizedBox(
              height: 40,
            ), // Add space between the welcome message and the button
            // Start Quiz Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the quiz page when the button is pressed
                Navigator.pushNamed(context, '/lesson');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    colorScheme
                        .primary, // Use primary color for button background
                foregroundColor:
                    colorScheme.onPrimary, // Use contrasting text color
                minimumSize: const Size.fromHeight(
                  80,
                ), // Make the button taller for better visibility
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ), // Increase horizontal padding for a wider button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Round the corners of the button
                ),
              ),
              child: const Text(
                'Start Lessons',
                style: TextStyle(fontSize: 18),
              ), // Button text with larger font size
            ),

            const SizedBox(
              height: 40,
            ), // Add space between the welcome message and the button
            // Start Quiz Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the quiz page when the button is pressed
                Navigator.pushNamed(context, '/quiz');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    colorScheme
                        .primary, // Use primary color for button background
                foregroundColor:
                    colorScheme.onPrimary, // Use contrasting text color
                minimumSize: const Size.fromHeight(
                  80,
                ), // Make the button taller for better visibility
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ), // Increase horizontal padding for a wider button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Round the corners of the button
                ),
              ),
              child: const Text(
                'Start Quiz',
                style: TextStyle(fontSize: 18),
              ), // Button text with larger font size
            ),

            const SizedBox(height: 30), // Add more space between buttons
            // View Results Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the results page when the button is pressed
                Navigator.pushNamed(context, '/results');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    colorScheme
                        .secondary, // Use secondary color for button background
                foregroundColor:
                    colorScheme.onSecondary, // Use contrasting text color
                minimumSize: const Size.fromHeight(
                  80,
                ), // Make the button taller
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ), // Increase horizontal padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Round the corners of the button
                ),
              ),
              child: const Text(
                'View Results',
                style: TextStyle(fontSize: 18),
              ), // Button text with larger font size
            ),

            const SizedBox(height: 30), // Add more space between buttons
            // Sign Out Button
            ElevatedButton(
              onPressed: () {
                // Call the signout method from AuthService to log the user out
                AuthService().signout(context: context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    colorScheme
                        .error, // Use error color (typically red) for the sign-out button
                foregroundColor:
                    colorScheme.onError, // Use contrasting text color
                minimumSize: const Size.fromHeight(
                  80,
                ), // Make the button taller
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ), // Increase horizontal padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Round the corners of the button
                ),
              ),
              child: const Text(
                'Sign Out',
                style: TextStyle(fontSize: 18),
              ), // Button text with larger font size
            ),
          ],
        ),
      ),
    );
  }
}
