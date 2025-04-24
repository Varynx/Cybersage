import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  int? lastScore;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // start fetching the latest score when the screen loads
    _fetchLatestScore();
  }

  // fetch the most recent quiz score from firestore for the current user
  Future<void> _fetchLatestScore() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // query the latest quiz result for the logged-in user
        final snapshot =
            await FirebaseFirestore.instance
                .collection('quiz_results')
                .where('user_id', isEqualTo: currentUser.uid)
                .orderBy('timestamp', descending: true)
                .limit(1)
                .get();

        // if a result exists, set it in the state
        if (snapshot.docs.isNotEmpty) {
          setState(() {
            lastScore = snapshot.docs.first['score'];
            isLoading = false;
          });
        } else {
          // if no results found
          setState(() {
            lastScore = null;
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print("error fetching score: $e");

      // stop loading if an error occurs
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CyberSage Login', style: TextStyle(fontSize: 22)),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),

        child: Center(
          child:
              isLoading
                  // show loading spinner while fetching score
                  ? const CircularProgressIndicator()
                  // show results content after loading
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      // heading text
                      const Text(
                        'Your Quiz Results!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 40),

                      // display the last score or a fallback message
                      Text(
                        lastScore != null
                            ? 'You scored $lastScore out of 9!'
                            : 'No previous score found.',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 40),

                      // return to home page button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        child: const Text('Return to Home Page'),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
