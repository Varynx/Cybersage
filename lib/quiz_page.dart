import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// List of cybersecurity quiz questions for seniors
final List<Map<String, dynamic>> quizQuestions = [
  {
    'question': 'What is "phishing"?',
    'options': [
      'A hobby activity involving catching fish', 
      'An attempt by scammers to trick you into giving personal information by pretending to be a trustworthy organization', 
      'A computer virus that damages your files', 
      'A method of fixing computer problems remotely'
    ],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'If you receive an email from your bank asking you to click a link to verify your account information, what should you do?',
    'options': [
      'Click the link and enter your information immediately', 
      'Reply to the email with your account number', 
      'Do not click the link, instead call your bank directly using the number on your card or statement', 
      'Forward the email to friends to warn them'
    ],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'Which of these is a sign that an email might be a scam?',
    'options': [
      'It\'s from someone you know and contains normal conversation', 
      'It has urgent language demanding immediate action', 
      'It has the company\'s correct logo', 
      'It addresses you by your full name'
    ],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'What is a "strong password"?',
    'options': [
      'A simple word that\'s easy to remember', 
      'Your name followed by your birth year', 
      'A combination of upper and lowercase letters, numbers, and symbols', 
      'The same password you use for all websites'
    ],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'What should you do if someone calls claiming to be from Microsoft or Apple saying there\'s a problem with your computer?',
    'options': [
      'Give them remote access to your computer', 
      'Provide your credit card to pay for their support', 
      'Hang up immediately - this is a common scam', 
      'Tell them your computer\'s password'
    ],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'Which of these is a safe way to share sensitive documents?',
    'options': [
      'Posting them on social media', 
      'Using secure, encrypted email or file-sharing services', 
      'Sending them as email attachments to everyone', 
      'Using public WiFi to send them quickly'
    ],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'What is "two-factor authentication"?',
    'options': [
      'Having two different passwords for the same account', 
      'An extra security step that requires both a password and a temporary code', 
      'Logging in twice to make sure the system recognizes you', 
      'Having two people verify your identity'
    ],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'If a loved one sends you a message saying they\'re stranded overseas and need money urgently, what should you do first?',
    'options': [
      'Send money immediately through wire transfer', 
      'Purchase gift cards and send the codes as requested', 
      'Contact them directly through a different method to verify it\'s really them', 
      'Share your bank account details so they can access your funds'
    ],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'What information is generally safe to share on social media?',
    'options': [
      'Your full birth date including year', 
      'When you\'re going on vacation and your home will be empty', 
      'General hobbies and interests', 
      'Your home address and phone number'
    ],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'If you receive a text message saying you\'ve won a prize and need to click a link to claim it, what should you do?',
    'options': [
      'Click the link immediately to claim your prize', 
      'Delete the message - this is likely a scam', 
      'Reply with your personal information', 
      'Forward it to everyone in your contacts'
    ],
    'correctAnswerIndex': 1,
  },
];



class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  int? selectedAnswerIndex;
  bool isAnswerSubmitted = false;
  int score = 0;

  // Store the user's score in Firestore
  Future<void> _storeUserScore(int score) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance.collection('quiz_results').add({
          'user_id': currentUser.uid,
          'score': score,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print("Error storing score: $e");
    }
  }

  void previousQuestion() {
  if (currentQuestionIndex > 0) {
    setState(() {
      currentQuestionIndex--;
      selectedAnswer = null;
      selectedAnswerIndex = null;
      isAnswerSubmitted = false;
    });
  }
}


  void nextQuestion() {
    if (currentQuestionIndex < quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        selectedAnswerIndex = null;
        isAnswerSubmitted = false;
      });
    } else {
      // Store score when quiz is completed
      _storeUserScore(score);
      showQuizCompletionDialog();
    }
  }

  void showQuizCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Completed!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your Score: $score out of ${quizQuestions.length}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              const Text('Thank you for completing the cybersecurity quiz!', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Return to Home', style: TextStyle(fontSize: 18)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex = 0;
                  selectedAnswer = null;
                  selectedAnswerIndex = null;
                  isAnswerSubmitted = false;
                  score = 0;
                });
              },
              child: const Text('Try Again', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  void submitAnswer() {
    if (selectedAnswerIndex != null && !isAnswerSubmitted) {
      setState(() {
        isAnswerSubmitted = true;
        if (selectedAnswerIndex == quizQuestions[currentQuestionIndex]['correctAnswerIndex']) {
          score++;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = quizQuestions[currentQuestionIndex];
    final List<String> options = List<String>.from(currentQuestion['options']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CyberSage Survey', style: TextStyle(fontSize: 22)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                  ),
                  child: Text(
                    'Question ${currentQuestionIndex + 1} of ${quizQuestions.length}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                  ),
                  child: Text(
                    currentQuestion['question'],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Select one answer below:', style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ...options.asMap().entries.map((entry) {
                  int index = entry.key;
                  String option = entry.value;

                  Color backgroundColor = Theme.of(context).colorScheme.surface;
                  Color textColor = Theme.of(context).colorScheme.onSurface;
                  Color borderColor = Colors.grey.shade300;

                  if (selectedAnswerIndex == index) {
                    backgroundColor = Theme.of(context).colorScheme.secondary;
                    textColor = Theme.of(context).colorScheme.onSecondary;
                    borderColor = Theme.of(context).colorScheme.secondary;
                  }

                  if (isAnswerSubmitted) {
                    if (index == currentQuestion['correctAnswerIndex']) {
                      backgroundColor = Colors.green;
                      textColor = Colors.white;
                      borderColor = Colors.green;
                    } else if (selectedAnswerIndex == index) {
                      backgroundColor = Colors.red;
                      textColor = Colors.white;
                      borderColor = Colors.red;
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton(
                      onPressed: isAnswerSubmitted ? null : () {
                        setState(() {
                          selectedAnswer = option;
                          selectedAnswerIndex = index;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor,
                        foregroundColor: textColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: borderColor, width: 2),
                        disabledBackgroundColor: backgroundColor,
                        disabledForegroundColor: textColor,
                      ),
                      child: Text(option, style: const TextStyle(fontSize: 20)),
                    ),
                  );
                }),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: currentQuestionIndex > 0 ? previousQuestion : null,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Previous', style: TextStyle(fontSize: 18)),
                    ),
                    if (!isAnswerSubmitted)
                      ElevatedButton(
                        onPressed: selectedAnswerIndex != null ? submitAnswer : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Submit Answer', style: TextStyle(fontSize: 18)),
                      )
                    else
                      ElevatedButton(
                        onPressed: nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          currentQuestionIndex < quizQuestions.length - 1 ? 'Next Question' : 'See Results',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
