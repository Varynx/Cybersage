import 'package:flutter/material.dart';

// List of cybersecurity lessons
// Each lesson contains a title, content, and image path (stored in your assets folder)
final List<Map<String, String>> cybersecurityLessons = [
  {
    'title': 'What is Phishing?',
    'content':
        'Often disguised as texts or emails from the Social Security Administration (SSA) or the Internal Revenue Service (IRS), the elderly are'
        'constantly bombarded with warnings or threats from attackers, who claim that the elderly victim is in trouble, or at risk of losing their Social Security benefits, threatening their livelihood. (American Bar Association).',
    'top_image': 'Phishing_Fischer.png',
  },
  {
    'title': 'Phishing Example',
    'content':
        'At first glance it can be hard to identify that this is a phishing attempt, but when looking closer these are some common identifiers of phishing present in this email:'
        '\n ⦁	The recipient list contains many emails'
        '\n ⦁	The subject line is left blank'
        '\n ⦁	The transaction image attached to the email contains actions you have never taken',
    'bot_image': 'Phishing_Example.png',
  },
  {
    'title': 'What is Identity Fraud?',
    'content':
        'Similarly, due to the lack of knowledge with technology, the elderly are very susceptible to identity fraud, as social engineering tactics or the use of phishing emails can lead to attackers gaining personal information'
        'about the victim that allows attackers to impersonate the victim for their personal gain, such as taking loans out in their name.',
    'top_image': 'assets/images/password.png',
  },
  {
    'title': 'Identity Fraud Example',
    'content':
        'Similarly, due to the lack of knowledge with technology, the elderly are very susceptible to identity fraud, as social engineering tactics or the use of phishing emails can lead to attackers gaining personal information'
        'about the victim that allows attackers to impersonate the victim for their personal gain, such as taking loans out in their name.',
    'top_image': 'assets/images/password.png',
  },
  {
    'title': 'What is a Tech Support Scam?',
    'content':
        '⦁	Without the proper understanding of electronics, elderly people are also susceptible to the many tech scams that claim to find viruses on the victim’s device and are willing to remove them. These types of scams are often'
        'used to gain access to the victim\'s device in order to steal banking information, passwords, or to have the elderly victim pay an exorbitant price to solve a problem that did not exist. (Senior Consulting Advisors)',
    'top_image': 'assets/images/scams.png',
  },
  {
    'title': 'Tech Support Scam Example',
    'content':
        'Two-factor authentication adds an extra layer of security by requiring both a password and a temporary code sent to your phone or email.',
    'top_image': 'assets/images/2fa.png',
  },
];

// Main lesson page widget (stateful because it tracks which lesson you're on)
class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  int currentLessonIndex = 0; //Tracks current lesson index

  //Move to next lesson (if available)
  void nextLesson() {
    if (currentLessonIndex < cybersecurityLessons.length - 1) {
      setState(() {
        currentLessonIndex++;
      });
    }
  }

  // Move to previous lesson (if available)
  void previousLesson() {
    if (currentLessonIndex > 0) {
      setState(() {
        currentLessonIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the currently selected lesson
    final currentLesson = cybersecurityLessons[currentLessonIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('CyberSage Lessons', style: TextStyle(fontSize: 22)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Top section with image, title, and lesson count
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.secondary,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Show image if available
                  if (currentLesson['top_image'] != null)
                    Image.asset(
                      currentLesson['top_image']!,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  const SizedBox(height: 16),
                  // Lesson title
                  Text(
                    currentLesson['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Lesson number
                  Text(
                    'Lesson ${currentLessonIndex + 1} of ${cybersecurityLessons.length}',
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Lesson content text area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (currentLesson['bot_image'] != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Center(
                            child: Image.asset(
                              currentLesson['bot_image']!,
                              height: 500,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      Text(
                        currentLesson['content'] ?? '',
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Navigation buttons (Previous / Next)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Previous Button
                  TextButton.icon(
                    onPressed: currentLessonIndex > 0 ? previousLesson : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text(
                      'Previous',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  // Home Button (center)
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('Home', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),

                  // Next Button
                  ElevatedButton(
                    onPressed:
                        currentLessonIndex < cybersecurityLessons.length - 1
                            ? nextLesson
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Next', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),

            /*
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: currentLessonIndex > 0 ? previousLesson : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text(
                      'Previous',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    onPressed:
                        currentLessonIndex < cybersecurityLessons.length - 1
                            ? nextLesson
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Next', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),*/
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
